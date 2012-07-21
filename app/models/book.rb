require 'json'
require 'open-uri'
class Book < ActiveRecord::Base
  default_scope order: 'updated_at DESC'
  attr_accessible :image, :isbn, :place, :title, :authors, :publisher, :published, :description, :google

  def image
    image = read_attribute(:image)
    image.blank? ? 'default.png' : image
  end

  def google?
    google.present?
  end
  def google_url
    "http://books.google.com/books?id=#{google}"
  end

  before_save :store_from_isbn
  private
  def search_google
    open("https://www.googleapis.com/books/v1/volumes?q=#{isbn}") do |io|
      @retrived = JSON.load(io)
    end
    book = @retrived['items'].select do |b|
      b['volumeInfo']["industryIdentifiers"].any? do |i|
        /^ISBN/ =~ i['type'] and i['identifier'] == self.isbn
      end
    end.first unless @retrived['items'].nil?
    return false if book.nil?
    info = book['volumeInfo']
    self.google = book['id']
    self.title = info['title']
    self.title = "#{self.title} <small>#{info['subtitle']}</small>".html_safe if info['subtitle']
    self.authors = info['authors'].map{|a| "<li>#{a}</li>".html_safe}.join(' ')
    self.publisher = info['publisher'] || ''
    begin
      self.published = info['publishedDate'].to_datetime
    rescue
    end
    self.description = info['description']
    self.image = info['imageLinks']['thumbnail'] unless info['imageLinks'].nil?
  end
  def store_from_isbn
    return unless isbn_changed?
    isbn.strip!
    unless search_google
      
    end
  end
end
