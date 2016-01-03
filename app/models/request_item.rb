class RequestItem < ActiveRecord::Base
  attr_accessible :item_id, :quantity, :request_id, :amount, :currency, :comment, :request_type
  belongs_to :request
  belongs_to :item
  validates :item, :quantity, :amount, :currency, :request_type, :presence => true
end
