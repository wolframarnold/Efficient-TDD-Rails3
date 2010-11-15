class ShippingAddress < ActiveRecord::Base

  belongs_to :user, :inverse_of => :shipping_addresses

  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  validates :user, :presence => true
  validates :country, :length => {:maximum => 2}

  before_validation :default_country

  private

  def default_country
    self.country = 'US' if self.country.blank?
  end
end
