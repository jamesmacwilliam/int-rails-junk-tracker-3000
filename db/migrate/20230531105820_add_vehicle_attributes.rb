class AddVehicleAttributes < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :vehicles, bulk: true do |t|
        dir.up do
          t.change :nickname, :text, null: false
          t.integer :mileage
          t.text :promotion_id
          t.text :registration_id
        end
        dir.down do
          t.change :nickname, :string
        end
      end
    end
  end
end
