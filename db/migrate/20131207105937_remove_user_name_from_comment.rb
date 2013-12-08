class RemoveUserNameFromComment < ActiveRecord::Migration
  def up
  	remove_column :comments, :user_name, :string
  end

  def down
  	add_column :comments, :user_name, :string
  end
end
