require 'uri'
class ShortLink < ApplicationRecord
  default_scope { order("#{self.table_name}.visited DESC") }

  validates :destination, presence: true
  validate :valid_url
  ALPHABET_MAP = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_!."
  BASE = ALPHABET_MAP.length
  # base 66
  before_create do
    self.destination = self.destination.sub(/https?\:(\\\\|\/\/)(www.)?/,'')
  end

  after_create do
    self.slug = self.base_conversion_to_slug
    self.save
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
    while int > 0 do
      slug += ALPHABET_MAP[int % BASE]
      int /= BASE
    end
    slug
  end
end
