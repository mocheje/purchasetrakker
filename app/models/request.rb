class Request < ActiveRecord::Base
  attr_accessible :department, :reason, :total_amount, :request_type, :user_id, :date_approved, :status, :title, :request_items_attributes, :created_at
  has_many :request_items
  has_many :purchases
  belongs_to :user
  accepts_nested_attributes_for :request_items, allow_destroy: true
  scope :recent, order('id DESC')
  scope :all, order('id DESC')
  scope :approved, where(:status => "Approved")
  scope :rejected, where(:status => "Rejected")
  scope :openrequest, where(:status => "Open" )
  validates :request_type, :title, :presence => true
  def approved?
    return true if status == "Approved"
    return false
  end
  def rejected?
    return true if status == "Rejected"
    return false
  end
  def open?
    return true if status == "Open"
    return false
  end
  def approve
    if status == "Open"
      self.status = "Approved"
      self.date_approved = Time.now
      save
    end

  end
  def reject
    if status == "Open"
      self.status  = "Rejected"
      self.date_approved = Time.now
      save
    end
  end


end
