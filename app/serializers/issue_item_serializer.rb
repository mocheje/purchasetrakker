class IssueItemSerializer < ActiveModel::Serializer
  attributes :id, :item_id, :quantity, :request_id, :comment
end
