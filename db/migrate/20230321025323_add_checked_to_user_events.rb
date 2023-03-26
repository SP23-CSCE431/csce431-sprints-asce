class AddCheckedToUserEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :user_events, :checked, :boolean, default: false
  end
end
