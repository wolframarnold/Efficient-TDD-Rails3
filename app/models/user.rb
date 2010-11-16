class User < ActiveRecord::Base

  has_many :shipping_addresses, :autosave => true, :inverse_of => :user

  # Rails 2.3
  # validates_presence_of :first_name

  # Rails 3
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  scope :by_names_starting_with, lambda {|term|
    where("first_name LIKE :term OR last_name LIKE :term", { :term => "#{term}%" })
  }

  def full_name
    name = first_name
    name << (' ' + middle_name) unless middle_name.blank?
    name << ' '
    name << last_name
    name
  end

end
