class Thing < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Thing, :create

    contract do
      property :name
      property :description

      validates :name, presence: true
      validates :description, length: {in: 4..160}, allow_blank: true

      collection :users,
         prepopulator: :prepopulate_users!,
         populate_if_empty: :populate_users!,
         skip_if: :all_blank do
        property :email
        validates :email, presence: true, email: true
      end

      private

      def prepopulate_users!(options)
        (3 - users.size).times { users << User.new }
      end

      def populate_users!(params, options)
        User.find_by_email(params[email]) or User.new
      end
    end

    def process(params)
      validate(params[:thing]) do |f|
        f.save
      end
    end
  end

  class Update < Create
    action :update

    contract do
      property :name, writeable: false
    end
  end
end
