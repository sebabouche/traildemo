class User < ActiveRecord::Base
  has_many :authorships
  has_many :things, through: :authorships

  serialize :auth_meta_data
end
