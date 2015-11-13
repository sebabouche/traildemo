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
  
end
