class AddReasonForRejectionToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :reason_for_rejection, :string
  end
end
