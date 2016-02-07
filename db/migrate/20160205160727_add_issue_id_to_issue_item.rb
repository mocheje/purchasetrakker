class AddIssueIdToIssueItem < ActiveRecord::Migration
  def change
    add_column :issue_items, :issue_id, :integer
    remove_column :issue_items, :request_id
  end
end
