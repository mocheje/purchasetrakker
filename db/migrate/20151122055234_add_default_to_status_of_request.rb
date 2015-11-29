class AddDefaultToStatusOfRequest < ActiveRecord::Migration
  def change
    change_column :requests, :status, :string, :default => "Open"
  end
end
