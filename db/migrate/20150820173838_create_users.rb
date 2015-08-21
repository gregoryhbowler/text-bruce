class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :phone_number
      t.string :phone_pin
      t.boolean :phone_verified

      t.timestamps null: false
    end
  end
end
