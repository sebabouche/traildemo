class Comment::Cell::Grid < Cell::Concept
  # inherit_views Comment::Cell

  include Kaminari::Cells

  def show
    # render :grid
    concept("comment/cell", collection: comments) + paginate(comments)
  end

  private

  def comments
    @comments ||= model.comments.page(page).per(3)
  end

  def page
    options[:page] or 1
  end
end

