class LocalDataObject < ActiveRecord::Base
validates :sensor_output, :user_id, presence: true

  belongs_to :user
  after_save :remove_old

  private
  def remove_old
    LocalDataObject.where('created_at < ?', 1.minute.ago).delete_all
  end
end
