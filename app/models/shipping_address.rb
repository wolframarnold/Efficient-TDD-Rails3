class ShippingAddress < ActiveRecord::Base

  belongs_to :user, :inverse_of => :shipping_addresses

  validates :street, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  validates :user, :presence => true
  validates :country, :length => {:maximum => 2}

  before_validation :default_country

  scope :in_california, where(:state => 'CA')
  scope :in_last_3_months, where("created_at > ?", 3.months.ago)
  scope :new_in_california, in_california.in_last_3_months

  private

  def default_country
    self.country = 'US' if self.country.blank?
  end
end
