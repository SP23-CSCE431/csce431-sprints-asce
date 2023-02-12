class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :uin
      t.string :email
      t.string :phone_number
      t.date :dob
      t.integer :points
      t.integer :role_id

      t.timestamps
    end
  end
end
