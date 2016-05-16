class LocalDataObject < ActiveRecord::Base
validates :sensor_output, :user_id, presence: true

  belongs_to :user
end
