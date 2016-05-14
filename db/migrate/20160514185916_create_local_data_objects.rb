class CreateLocalDataObjects < ActiveRecord::Migration
  def change
    create_table :local_data_objects do |t|
      t.float :sensor_output, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
