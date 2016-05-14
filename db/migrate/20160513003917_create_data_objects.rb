class CreateDataObjects < ActiveRecord::Migration
  def change
    create_table :data_objects do |t|
      t.string :country_name, null: false
      t.datetime :datetime, null: false
      t.float :breezometer_aqi, null: false
      t.string :breezometer_description, null: false
      t.string :type
      t.string :dominant_pollutant_text

      t.timestamps null: false
    end
  end
end
