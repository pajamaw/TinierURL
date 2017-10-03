class ShortLink
  include Cequel::Record
  attr_accessor :destination, :visited, :id
  key :slug, :text
  column :id, :int
  column :destination, :text
  column :visited, :int

  @@current_id = 1

  ALPHABET_MAP = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-_!."
  BASE = ALPHABET_MAP.length

  def self.base_conversion_to_slug(id)
    slug = ""
    while id > 0 do
      slug += ALPHABET_MAP[id % BASE]
      id /= BASE
    end
    slug
  end

  private
    def self.increment
      @@current_id +=1
    end

    def self.current_id
      @@current_id
    end

end
