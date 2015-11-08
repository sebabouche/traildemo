class Thing < ActiveRecord::Base
  class Create < Trailblazer::Operation
    contract do
      property :name
      property :description

      validates :name, presence: true
      validates :description, length: {in: 4..160}, allow_blank: true
    end

    def process(params)
      thing = Thing.new
      
      validate(params[:thing], thing) do |f|
        f.save
      end
    end
  end
end
