class Item < ActiveRecord::Base

  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true

  has_many :line_items

end
