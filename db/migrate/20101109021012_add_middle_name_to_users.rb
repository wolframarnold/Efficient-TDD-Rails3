class AddMiddleNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :middle_name, :string
  end

  def self.down
    remove_column :users, :middle_name
  end
end
