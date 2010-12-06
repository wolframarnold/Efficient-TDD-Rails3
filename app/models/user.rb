class User < ActiveRecord::Base

  has_many :shipping_addresses, :autosave => true, :inverse_of => :user
  has_many :orders
  has_many :line_items, :through => :orders

  # Rails 2.3
  # validates_presence_of :first_name

  # Rails 3
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  accepts_nested_attributes_for :shipping_addresses, :reject_if => :all_blank

  scope :by_names_starting_with, lambda {|term|
    where("first_name LIKE :term OR last_name LIKE :term", { :term => "#{term}%" })
  }

  scope :loyal_last_90_days, lambda { joins(:orders).where('orders.created_at >= ?', 90.days.ago) }
  scope :min_2_items, joins(:orders => :line_items).group('users.id').having('COUNT(line_items.id) >= 2')

  def items
    Item.joins(:line_items => {:order => :user}).group('items.id').all
  end

  def full_name
    name = first_name
    name << (' ' + middle_name) unless middle_name.blank?
    name << ' '
    name << last_name
    name
  end

end
