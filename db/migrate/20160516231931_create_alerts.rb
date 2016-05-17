class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :global_data_object_id, null: false
      t.boolean :ready_to_send?, default: true
      t.string :message, null: false

      t.timestamps null: false
    end
  end
end
