class AddAmountToRequestItem < ActiveRecord::Migration
  def change
    add_column :request_items, :amount, :integer
    add_column :request_items, :currency, :string
    add_column :request_items, :comment, :string
  end
end
