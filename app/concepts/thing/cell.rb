class Thing::Cell < Cell::Concept

  include Cell::Caching::Notifications
  # cache :show do
  #  [model.id, model.updated_at]
  # end
  # Now moved to Grid Cell

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
    cache :show do
      # Thing.latest.last.id # won't update cache if an older thing has been updated
      CacheVersion.for("thing/cell/grid")
    end

    def show
      things = Thing.latest
      concept("thing/cell", collection: things, last: Thing.last)
    end
  end

  class Decorator < Cell::Concept
    extend Paperdragon::Model::Reader
    processable_reader :image
    property :image_meta_data

    def thumb
      image_tag image[:thumb].url if image.exists?
    end
  end
end
