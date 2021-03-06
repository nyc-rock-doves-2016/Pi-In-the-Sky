class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null:false
      t.string :last_name, null: false
      t.string :password_digest, null: false
      t.string :email, null: false, unique: true
      t.string :phone, null: false, unique: true
      t.integer :alert_level, default: 60

      t.timestamps null: false
    end
  end
end
