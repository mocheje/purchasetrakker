class AddApproveToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :approve, :boolean
  end
end
