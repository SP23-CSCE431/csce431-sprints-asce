class CreateEventTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :event_types do |t|
      t.integer :points

      t.timestamps
    end
  end
end
