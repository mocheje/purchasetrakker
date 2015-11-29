class ChangeDepartmentToDepartmentIdInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :department, :department_id
    change_column :users, :department_id, :integer
  end
end
