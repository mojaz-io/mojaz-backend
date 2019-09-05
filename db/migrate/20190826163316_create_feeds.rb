class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :feed_url, unique: true, null: false
      t.string :title, null: false
      t.string :description
      t.string :language
      t.text :etag
      t.text :image_url
      t.datetime :last_modified
      t.string :home_page_url
      t.timestamps
    end
  end
end
