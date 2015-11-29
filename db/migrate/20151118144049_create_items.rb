class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :unit_of_measurement
      t.integer :unit_price
      t.string :currency

      t.timestamps
    end
  end
end
