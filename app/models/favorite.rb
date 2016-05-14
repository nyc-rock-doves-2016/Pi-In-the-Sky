class Favorite < ActiveRecord::Base
  belongs_to :global_data_object
  belongs_to :user
end
