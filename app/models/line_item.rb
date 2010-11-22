class LineItem < ActiveRecord::Base

  belongs_to :order, :inverse_of => :line_items
  belongs_to :item

  validates :order, :presence => true
  validates :item, :presence => true
end
