class CreatePartStatuses < ActiveRecord::Migration[6.1]
  def change
    create_table :part_statuses do |t|
      t.text :name

      t.timestamps
    end
  end
end
