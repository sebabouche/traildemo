class ThingsController < ApplicationController
  def create
    run Thing::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end
end
