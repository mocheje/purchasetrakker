class Purchase < ActiveRecord::Base
  attr_accessible :approved, :department_id, :item_id, :requester, :request_id, :quantity_received
  belongs_to :item
  belongs_to :request
  belongs_to :department
  scope :recent, order('id DESC')

  validates :quantity_received, numericality: true

end
