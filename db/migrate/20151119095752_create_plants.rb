class CreatePlants < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
