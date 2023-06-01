class AddHeadlineToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :headline, :text
  end
end
