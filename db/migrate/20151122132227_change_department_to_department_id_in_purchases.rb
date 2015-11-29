class ChangeDepartmentToDepartmentIdInPurchases < ActiveRecord::Migration
  def change
    rename_column :purchases, :department, :department_id
    change_column :purchases, :department_id, :integer
  end
end
