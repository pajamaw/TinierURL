require 'uri'
class ShortLink < ApplicationRecord
  default_scope { order("#{self.table_name}.visited DESC") }
  # here I've got the database sorting itself by number visite
  # thereby not only making it faster for the top 100 -> but also
  # I think this would make it faster for the sites that are used more often

  validates :destination, presence: true
  # validating that the url exists
  validate :valid_url
  # validating that the url doesn't have any spaces
  # the internet says that periods are okay while heroku doesn't like it
  ALPHABET_MAP = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_!."
  # remove the periods
  BASE = ALPHABET_MAP.length
  
  # current characters that I'm using may possibly remove a couple due to similarity
  @@count = 0

  # base 66
  before_create do
    # remove any classic https or wwww
    self.destination = self.destination.sub(/https?\:(\\\\|\/\/)(www.)?/,'')
    self.slug == "" || self.slug == nil ? self.custom_slug = false : self.custom_slug = true
  end

  after_create do
    # check to see if custom slug was added
    if !self.custom_slug
      self.slug = self.base_conversion_to_slug
      self.save
    end
    @@count = self.id
    #@@count > 0 ? @@count+=1 : @@count = ShortLink.all.size
  end

  def self.count
    @@count
  end

  def self.count=(num)
    # used as a quicker way to check the number then running a query each time
    @@count =num
  end

  def valid_url
    begin
      uri = URI.parse(destination)
    rescue URI::InvalidURIError
      errors.add(:destination, "Must be a valid url")
    end
  end

  def base_conversion_to_slug
    int = self.id
    slug = ""
    #
    while int > 0 do
      slug += ALPHABET_MAP[int % BASE]
      # here i map a
      int /= BASE
    end
    slug
  end
end
