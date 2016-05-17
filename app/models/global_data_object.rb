class GlobalDataObject < ActiveRecord::Base

  validates :country_name, :datetime, :breezometer_aqi, :dominant_pollutant_description, :breezometer_description, :dominant_pollutant_text, :city, :state, presence: true

  has_many :favorites
  has_many :users, through: :favorites
  has_one :alert
end
