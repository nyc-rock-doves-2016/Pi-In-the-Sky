class Favorite < ActiveRecord::Base
  validates :user, :global_data_object, presence: true

  belongs_to :global_data_object
  belongs_to :user
end
