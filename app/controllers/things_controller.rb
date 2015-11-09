class ThingsController < ApplicationController

  def new
    form Thing::Create
  end
  def create
    run Thing::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end
end
