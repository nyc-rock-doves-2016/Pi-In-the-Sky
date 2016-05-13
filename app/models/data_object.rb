class DataObject < ActiveRecord::Base
  validates :location, :date, :aqi, :type, :pollutant, :effects, presence: true

  has_many :favorites
  has_many :users, through: :favorites
end
