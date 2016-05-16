class CreateGlobalDataObjects < ActiveRecord::Migration
  def change
    create_table :global_data_objects do |t|
      t.string :country_name, null: false
      t.datetime :datetime, null: false
      t.float :breezometer_aqi, null: false
      t.string :dominant_pollutant_description, null: false
      t.string :breezometer_description, null: false
      t.string :dominant_pollutant_text, null: false
      t.string :city
      t.string :state

      t.timestamps null: false
    end
  end
end
