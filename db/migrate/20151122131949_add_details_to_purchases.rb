class AddDetailsToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :quantity_received, :integer
  end
end
