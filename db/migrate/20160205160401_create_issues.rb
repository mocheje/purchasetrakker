class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :request_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
