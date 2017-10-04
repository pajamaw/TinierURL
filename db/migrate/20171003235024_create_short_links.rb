class CreateShortLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :short_links do |t|
      t.text :slug, unique: true
      t.text :destination
      t.integer :visited, default: 0

      t.timestamps
    end
  end
end
