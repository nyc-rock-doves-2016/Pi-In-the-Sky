class CreateDataObjects < ActiveRecord::Migration
  def change
    create_table :data_objects do |t|
      t.string :location, null: false
      t.datetime :date, null: false
      t.float :aqi, null: false
      t.string :type, null: false
      t.string :pollutant
      t.string :effects

      t.timestamps null: false
    end
  end
end
