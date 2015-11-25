class Comment < ActiveRecord::Base
  class Create < Trailblazer::Operation
    include Model
    model Comment, :create

    contract do

      def self.weights
        {"0" => "Nice! ", "1" => "Rubbish! "}
      end

      def weights
        [self.class.weights.to_a, :first, :last]
      end

      property :body
      property :weight, prepopulator: -> (*) { self.weight= "0" }
      property :thing

      validates :body, length: { in: 6..160 }
      validates :weight, inclusion: { in: weights.keys }
      validates :thing, :user, presence: true

      property :user, 
       prepopulator: -> (*) { self.user = User.new },
       populator: ->(fragment, *) { self.user = User.find_by(email: fragment["email"]) || User.new } do
        property :email
        validates :email, presence: true, email: true
      end

      def populate_user!(fragment, *)
        self.user = User.find_by(email: fragment["email"]) or User.new
      end
    end

    include Dispatch
    callback do
      on_change :sign_up_sleeping!, property: :user
    end

    def process(params)
      validate(params[:comment]) do |f|
        dispatch!
        f.save
      end
    end

    def thing 
      model.thing
    end
    
    private
    
    def setup_model!(params) # run before process
      model.thing = Thing.find_by_id(params[:id])
      
      ### if static population
      # model.build_user
    end

    # require_dependency "sessions/operations"
    def sign_up_sleeping!(comment)
      auth = Tyrant::Authenticatable.new(comment.user.model)
      auth.confirmable!
      auth.sync
    end

  end
end
