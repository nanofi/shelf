require 'json'
require 'open-uri'
require 'nokogiri'
class Book < ActiveRecord::Base
  default_scope order: 'updated_at DESC'
  attr_accessible :image, :isbn, :place, :title, :authors, :publisher, :published, :description, :google

  has_many :relevants, dependent: :destroy
  has_many :entities, dependent: :destroy
  has_many :places, through: :entities

  def image
    image = read_attribute(:image)
    image.blank? ? 'default.png' : image
  end

  def isbn10
    identify = isbn
    begin
      identify = identify[3..11]
      check_digit = 0
      identify.split(//).each.with_index do |char, index|
        check_digit += char.to_i * (10 - index)
      end
      check_digit = 11 - (check_digit % 11)
      case check_digit
      when 10 then
        check_digit = "X"
      when 11 then
        check_digit = 0
      end
      identify = "identify#{check_digit}"
    end if identify.length != 10
    identify
  end

  def google_url
    google.present? ? "http://books.google.com/books?id=#{google}" : "http://books.google.com/books?vid=ISBN#{isbn}"
  end
  def amazon_url
    "http://www.amazon.co.jp/dp/#{isbn10}"
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
    return true if book.nil?
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
  def search_amazon
    begin
      retrive = Nokogiri::HTML(open("http://www.amazon.co.jp/dp/#{isbn10}"))
      self.title = retrive.css('#btAsinTitle').text.to_s
      self.description = retrive.css('#productDescription .content').text.to_s
      self.image = "http://ecx.images-amazon.com/images/P/#{isbn10}.01.LZZZZZZ"
    rescue
    end
  end
  def search_rakuten
  end
  def store_from_isbn
    return unless isbn_changed?
    isbn.strip!
    r = search_google
    r = search_amazon if r
    r = search_rakuten if r
  end
end
