class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :global_data_object_id, null: false
      t.boolean :below_threshold?, default: false
      t.string :message, null: false

      t.timestamps null: false
    end
  end
end
