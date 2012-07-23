class Entity < ActiveRecord::Base
  belongs_to :book
  belongs_to :place
  attr_accessible :memo
end
