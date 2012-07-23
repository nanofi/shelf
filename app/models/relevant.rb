class Relevant < ActiveRecord::Base
  belongs_to :book
  attr_accessible :what, :url, :book_id

  class << self
    def whats
      [ 'link', 'globe', 'picture', 'file']
    end
  end
end
