class AddBioDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :phonenumber, :integer
    add_column :users, :date_of_birth, :date
    add_column :users, :address, :string
    add_column :users, :bio, :text
  end
end
