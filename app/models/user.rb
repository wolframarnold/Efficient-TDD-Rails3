class User < ActiveRecord::Base

  # Rails 2.3
  # validates_presence_of :first_name

  # Rails 3
  validates :first_name, :presence => true
  validates :last_name, :presence => true

end
