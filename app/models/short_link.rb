class ShortLink
  include Cequel::Record
  attr_accessor :destination, :visited
  key :slug, :text
  column :destination, :text
  column :visited, :int

  timestamps
end
