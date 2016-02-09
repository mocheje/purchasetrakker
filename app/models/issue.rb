class Issue < ActiveRecord::Base
  attr_accessible :request_id, :status, :user_id, :issue_items_attributes

  has_many :issue_items, dependent: :destroy
  belongs_to :request

  accepts_nested_attributes_for :issue_items, allow_destroy: true

  validate :req_status
  validates :issue_items, presence: true

  def req_status
    @request = Request.find(request_id)
    unless @request.approved?
      errors.add(:request_id, "Goods can only be issued for Approved Request")
    end
  end
end
