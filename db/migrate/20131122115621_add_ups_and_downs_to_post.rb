class AddUpsAndDownsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ups, :integer, :default => 0
    add_column :posts, :downs, :integer, :default => 0
  end
end
