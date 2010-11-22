class User < ActiveRecord::Base

  has_many :shipping_addresses, :autosave => true, :inverse_of => :user
  has_many :orders
  has_many :line_items, :through => :orders

  # Rails 2.3
  # validates_presence_of :first_name

  # Rails 3
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  scope :by_names_starting_with, lambda {|term|
    where("first_name LIKE :term OR last_name LIKE :term", { :term => "#{term}%" })
  }

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
