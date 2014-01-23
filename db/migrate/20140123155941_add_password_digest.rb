class AddPasswordDigest < ActiveRecord::Migration
  def up
  	remove_column("users","password")
  	add_column("users","password_digest", :string, :after => 'email')
  end

  def down
  	remove_column("users","password_digest")
  	add_column("users","password", :string, :after => 'email')
  end
end
