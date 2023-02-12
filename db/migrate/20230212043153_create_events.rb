class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :start
      t.datetime :end
      t.string :status
      t.integer :type_id

      t.timestamps
    end
  end
end
