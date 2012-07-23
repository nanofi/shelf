class Relevant < ActiveRecord::Base
  belongs_to :book
  attr_accessible :type, :url

  class << self
    def types
      [ 'link', 'globe', 'picture', 'file']
    end
  end
end
