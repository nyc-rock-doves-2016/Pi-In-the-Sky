class Favorite < ActiveRecord::Base
  belongs_to :api_data
  belongs_to :pi_data
  belongs_to :user
end
