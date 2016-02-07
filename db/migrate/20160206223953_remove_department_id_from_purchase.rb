class RemoveDepartmentIdFromPurchase < ActiveRecord::Migration
  def up
    remove_column :purchases, :department_id
  end

  def down
    add_column :purchases, :department_id, :integer
  end
end
