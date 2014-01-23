class CreatePosts < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title, :limit => 100
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end

  def down
  	drop_table :posts
  end
end
