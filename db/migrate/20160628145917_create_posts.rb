class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :shop
      t.string :area
      t.string :genre
      t.integer :rate_u
      t.integer :rate_l
      t.string :url

      t.timestamps null: false
    end
  end
end
