class CreateRequestItems < ActiveRecord::Migration
  def change
    create_table :request_items do |t|
      t.integer :item_id
      t.integer :request_id
      t.integer :quantity

      t.timestamps
    end
  end
end
