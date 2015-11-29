class RequestItem < ActiveRecord::Base
  attr_accessible :item_id, :quantity, :request_id, :amount, :currency, :comment
  belongs_to :request
  belongs_to :item
end