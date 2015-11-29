class AddRequestIdToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :request_id, :integer
  end
end
