class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string "name", :limit =>100
      t.string :firstname, :limit => 50
      t.string :lastname, :limit => 50
      t.string :email, :limit => 120
      t.string :password
      t.integer :role, :default => 0

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
