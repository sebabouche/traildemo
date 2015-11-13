class Thing::Cell < Cell::Concept
  property :name
  property :created_at

  include ActionView::Helpers::DateHelper

  include Cell::GridCell
  self.classes = ["box", "col-md-4", "col-sm-6"]

  def show
    render
  end

  private

  def name_link
    link_to model.name, thing_path(model)
  end

  def created_at
    time_ago_in_words(super)
  end

  def classes
    classes = ["col-md-4", "col-sm-6"]
    classes << "test" if options[:last] == model 
    classes
  end

  class Grid < Cell::Concept
    def show
      things = Thing.latest
      concept("thing/cell", collection: things, last: Thing.last)
    end
  end
end
