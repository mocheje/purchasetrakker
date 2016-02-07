class IssueItem < ActiveRecord::Base
  attr_accessible :comment, :item_id, :quantity, :request_id, :issue_id
  belongs_to :issue
  belongs_to :item
end
