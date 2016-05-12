class User < ActiveRecord::Base
  has_secure_password
  has_many :favorites
  has_many :data_objects, through: :favorites

  validates :first_name, :last_name, :location, presence: true
  validates :email, :phone, presence: true, uniqueness: true 
end
