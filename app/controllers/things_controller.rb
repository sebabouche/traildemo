class ThingsController < ApplicationController

  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.find(params[:id])
  end

  def new
    form Thing::Create
  end

  def create
    run Thing::Create do |op|
      return redirect_to op.model
    end

    render action: :new
  end

  def edit
    form Thing::Update

    render action: :new
  end

  def update
    run Thing::Update do |op|
      return redirect_to op.model
    end

    render action: :new
  end
end
