class ChangeApprovalColumnAndType < ActiveRecord::Migration
  def change
    rename_column :requests, :approve, :status
    change_column :requests, :status, :string
  end
end
