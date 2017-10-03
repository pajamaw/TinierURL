class ShortLink
  include Cequel::Record

  key :slug, :text
  column :destintation, :text
  column :times_visited, :int

  timestamps
end
