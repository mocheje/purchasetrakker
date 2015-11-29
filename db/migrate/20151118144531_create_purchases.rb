class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :item_id
      t.string :department
      t.datetime :approved
      t.integer :requester

      t.timestamps
    end
  end
end
