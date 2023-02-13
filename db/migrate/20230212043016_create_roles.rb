class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :role_name
      t.boolean :create_event
      t.boolean :delete_event
      t.boolean :edit_event
      t.boolean :delete_member
      t.boolean :promote_member

      t.timestamps
    end
  end
end
