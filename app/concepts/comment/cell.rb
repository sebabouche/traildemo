class Comment::Cell < Cell::ViewModel
  property :created_at
  property :body
  property :user

  include Cell::GridCell
  self.classes = ["comment", "col-md-4", "col-sm-6"]

  def show
    render
  end

  class Grid < Cell::Concept
    inherit_views Comment::Cell

    def show
      render :grid
      # concept("comment/cell")
    end
  end
end
