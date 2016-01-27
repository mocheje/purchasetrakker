class RomveApprovedFromPurchase < ActiveRecord::Migration
  def change
    remove_column :purchases, :approved
  end
end
