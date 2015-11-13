class ThingsController < ApplicationController

  def index
    @things = Thing.all
  end

  def show
    present Thing::Update
    form Comment::Create
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

  def create_comment
    present Thing::Update
    run Comment::Create

    render action: :show
  end
end
