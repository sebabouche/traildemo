class Thing < ActiveRecord::Base
  has_many :comments

  scope :latest, -> { all.limit(9).order("id DESC") }
end
