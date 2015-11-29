class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :total_amount
      t.string :department
      t.string :type
      t.text :reason

      t.timestamps
    end
  end
end
