class AddApproverIdToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :approver_id, :integer
  end
end
