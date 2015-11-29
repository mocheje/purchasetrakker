class AddAddressToPlant < ActiveRecord::Migration
  def change
    add_column :plants, :address, :string
  end
end
