class AddNameAndPointsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :name, :string
    add_column :events, :points, :integer, default: 0
  end
end
