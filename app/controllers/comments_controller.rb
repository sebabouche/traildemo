class CommentsController < ApplicationController
  def new
    @thing = Thing.find(params[:thing_id])

    form Comment::Create
  end
  
  def create
    run Comment::Create do |op|
      flash[:notice] = "Created comment for \"#{op.thing.name}\""
      return redirect_to thing_path(op.thing) 
    end

    @thing = Thing.find(params[:thing_id])
    render action: :new
  end
end
