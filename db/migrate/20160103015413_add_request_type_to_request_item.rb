class AddRequestTypeToRequestItem < ActiveRecord::Migration
  def change
    add_column :request_items, :request_type, :string
  end
end
