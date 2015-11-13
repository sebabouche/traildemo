module Cell
  module CreatedAt
    def self.included(base)
      base.send :include, ActionView::Helpers::DateHelper
    end

    private

    def created_at
      time_tag(super)
    end
  end
end
