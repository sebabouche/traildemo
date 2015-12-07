class Thing < ActiveRecord::Base

  class Create < Trailblazer::Operation

    include Resolver # include Resolver == include Model + include Policy (thus available in the builder block)
    policy Thing::Policy, :create?
    model Thing, :create

    builds -> (model, policy, params) do
      return self::Admin if policy.admin?
      return self::SignedIn if policy.signed_in?
    end


    contract do
      feature Disposable::Twin::Persisted

      property :name
      property :description

      property :file, virtual: true
      validates :file, file_size: { less_than: 1.megabyte },
        file_content_type: { allow: ['image/jpeg', 'image/png'] }
      
      extend Paperdragon::Model::Writer
      processable_writer :image
      property :image_meta_data, deserializer: {writeable: false}

      validates :name, presence: true
      validates :description, length: {in: 4..160}, allow_blank: true

      collection :users,
         prepopulator: :prepopulate_users!,
         populate_if_empty: :populate_users!,
         skip_if: :all_blank do

        property :email
        validates :email, presence: true, email: true
        validate :authorship_limit_reached?

        def readonly?
          model.persisted?
        end
        alias_method :removeable?, :readonly?

        private

        def authorship_limit_reached?
          return if model.authorships.find_all { |au| au.confirmed == 0 }.size < 5
          errors.add("user", "This user has too many unconfirmed authorships.")
        end
      end
      validates :users, length: {maximum: 3}

      private

      def prepopulate_users!(options)
        (3 - users.size).times { users << User.new }
      end

      def populate_users!(params, options)
        User.find_by_email(params["email"]) or User.new
      end
    end

    include Dispatch
    callback(:before_save) do
      on_change :upload_image!, property: :file
      collection :users do
        on_add :sign_up_sleeping!
      end
    end

    callback do 
      collection :users do
        on_add :notify_author!
        on_add :reset_authorship! 
      end
      on_change :expire_cache! 
    end
    

    def process(params)
      validate(params[:thing]) do |f|
        dispatch!(:before_save)
        # upload_image!(f) if f.changed?(:file)
        f.save
        dispatch!
      end
    end

    private

    def upload_image!(contract)
      contract.image!(contract.file) do |ff|
        ff.process!(:original)
        ff.process!(:thumb) { |job| job.thumb!("120x120#") }
      end
    end
        
    def sign_up_sleeping!(user)
      return if user.persisted?

      auth = Tyrant::Authenticatable.new(user.model)
      auth.confirmable!
      auth.sync
    end

    def notify_author!(user)
      # return UserMailer.welcome_and_added(user, model) if user.created?
      # UserMailer.thing_added(thing_added)
    end

    def reset_authorship!(user)
      user.model.authorships.find_by(thing_id: model.id).update_attribute(:confirmed, 0)
    end

    def expire_cache!(thing)
      CacheVersion.for("thing/cell/grid").expire!
    end

    class SignedIn < self
      include Thing::SignedIn
    end

    class Admin < SignedIn
    end
  end

  class Update < Create
    action :update

    contract do
      property :name, writeable: false

      collection :users, inherit: true, skip_if: :skip_user? do
        property :remove, virtual: true
        property :email, skip_if: :skip_email?

        def skip_email?(fragment, options)
          model.persisted?
        end
      end

      private

      def skip_user?(fragment, options)
        return true if fragment[:remove] == "1" and users.delete(users.find { |u| u.id.to_s == fragment["id"] })
        return true if fragment["email"].blank?
      end
    end
  end
end
