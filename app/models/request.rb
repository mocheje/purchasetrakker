class Request < ActiveRecord::Base
  attr_accessible :approver_id, :reason_for_rejection, :request_number, :department_id, :reason, :user_id, :date_approved, :status, :title, :request_items_attributes, :created_at
  has_many :request_items, dependent: :destroy
  has_many :purchases
  has_many :issues
  belongs_to :user
  belongs_to :department
  accepts_nested_attributes_for :request_items, allow_destroy: true
  scope :recent, order('id DESC')
  scope :all, order('id DESC')
  scope :approved, where(:status => "Approved")
  scope :rejected, where(:status => "Rejected")
  scope :openrequest, where(:status => "Open" )
  before_create :set_number
  validates :title, :request_items, :presence => true
  validate :requester_not_approver


  after_save :update_amount
  after_update :update_amount

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
  def reject(reason)
    if status == "Open"
      self.status  = "Rejected"
      self.date_approved = Time.now
      self.reason_for_rejection = reason
      save
    end
  end


  def set_number
     self.request_number = SecureRandom.hex(4)
  end

  def update_amount
    items = self.request_items
    m_amount = self.total_amount
    puts items
    amount = 0
    items.each do |item|
      amount += (item.amount * item.quantity)
    end
    self.total_amount = amount
    self.save if amount != m_amount
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['request_number LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def requester_not_approver
    if user_id == approver_id
      errors.add(:approver_id, "The Requester cannot be the Approver. Leave blank to use the default department approver")
    end
  end
end
