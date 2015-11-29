class AddApprovedDateToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :date_approved, :datetime
  end
end
