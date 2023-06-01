class AddStackedAdToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :stacked_ad, :boolean, default: false, null: false
  end
end
