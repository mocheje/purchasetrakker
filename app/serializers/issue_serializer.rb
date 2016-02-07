class IssueSerializer < ActiveModel::Serializer
  attributes :id, :request_id, :user_id, :status
end
