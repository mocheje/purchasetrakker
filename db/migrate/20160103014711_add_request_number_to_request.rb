class AddRequestNumberToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :request_number, :string
    remove_column :requests, :request_type, :string
  end
end
