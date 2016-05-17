class GlobalDataObject < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites
  has_one :alert
end
