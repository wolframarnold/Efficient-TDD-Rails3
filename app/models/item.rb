class Item < ActiveRecord::Base

  validates :name, :presence => true
  validates :price, :presence => true, :numericality => true

  has_many :line_items

  scope :by_popularity, joins(:line_items).group('line_items.item_id').order('COUNT(line_items.item_id) DESC')

end
