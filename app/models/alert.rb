class Alert < ActiveRecord::Base
  validates :global_data_object_id, :message, presence: true

  belongs_to :global_data_object
end
