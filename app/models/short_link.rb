class ShortLink < ApplicationRecord

  ALPHABET_MAP = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_!."
  BASE = ALPHABET_MAP.length

  after_create do
    self.slug = self.base_conversion_to_slug
    self.save
  end

  def base_conversion_to_slug
    int = self.id
    puts "#{self.attributes}"
    slug = ""
    while int > 0 do
      slug += ALPHABET_MAP[int % BASE]
      int /= BASE
    end
    slug
  end
end
