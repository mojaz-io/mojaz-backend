class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :language
      t.timestamps
    end
  end
end
