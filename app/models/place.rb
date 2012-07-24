class Place < ActiveRecord::Base
  has_many :entities
  has_many :books, through: :entities
  attr_accessible :name
end
