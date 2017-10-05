class AddCustomSlugBool < ActiveRecord::Migration[5.1]
  def change
    add_column :short_links, :custom_slug, :boolean, default: false
  end
end
