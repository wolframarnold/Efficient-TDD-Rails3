class CreateShippingAddresses < ActiveRecord::Migration
  def self.up
    create_table :shipping_addresses do |t|
      t.string :street
      t.string :city
      t.string :zip
      t.string :state
      t.string :country, :length => 2
      t.integer :user_id

      t.timestamps
    end

    add_index :shipping_addresses, :user_id
  end

  def self.down
    drop_table :shipping_addresses
  end
end
