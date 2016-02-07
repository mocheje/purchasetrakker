class CreateIssueItems < ActiveRecord::Migration
  def change
    create_table :issue_items do |t|
      t.integer :item_id
      t.integer :quantity
      t.integer :request_id
      t.string :comment

      t.timestamps
    end
  end
end
