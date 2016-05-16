class User < ActiveRecord::Base
  has_secure_password
  has_many :favorites
  has_many :global_data_objects, through: :favorites
  has_many :local_data_objects

  validates :first_name, :last_name, :location, presence: true
  validates :email, :phone, presence: true, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validates_format_of :phone, :with => /\A\d{3}-\d{3}-\d{4}\z/, on: :create
end
