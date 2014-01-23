class AlterUserEmail < ActiveRecord::Migration
  def up
  	remove_column("users", "email")
  	add_column("users","email",:string,:limit=>120 , :unique => true, :after => "lastname")
  end

  def down
  	remove_column("users", "email")
  	add_column("users","email",:string,:limit=>120 , :after => "lastname")
  end
end
