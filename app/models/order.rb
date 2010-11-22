class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items, :inverse_of => :order, :dependent => :destroy
  has_many :items, :through => :line_items

  validates :line_items, :length => {:minimum => 1}
end
