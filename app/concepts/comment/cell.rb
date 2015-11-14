class Comment::Cell < Cell::Concept
  property :created_at
  property :body
  property :user

  include Cell::GridCell
  self.classes = ["comment", "col-md-4", "col-sm-6"]

  include Cell::CreatedAt

  def show
    render
  end

  private

  def nice?
    model.weight == 0
  end

  class Grid < Cell::Concept
    inherit_views Comment::Cell

    include Kaminari::Cells
    include ActionView::Helpers::JavaScriptHelper

    def show
      render :grid
      #concept("comment/cell", collection: comments) + paginate(comments) + raw("<strong>OK!!!</strong>")
    end

    def append
      %{ $("#next").replaceWith("#{j(show)}") }
    end

    private

    def comments
      @comments ||= model.comments.page(page).per(3)
    end

    def page
      options[:page] or 1
    end
  end
  
end
