class Entity < ActiveRecord::Base
  belongs_to :book
  belongs_to :place, counter_cache: true
  attr_accessible :memo
end
