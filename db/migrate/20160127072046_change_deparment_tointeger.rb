class ChangeDeparmentTointeger < ActiveRecord::Migration
def change
  rename_column :requests, :department, :department_id
  change_column :requests, :department_id, :integer
end
end
