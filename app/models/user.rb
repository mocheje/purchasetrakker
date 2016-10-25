class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable
  has_many :requests
  belongs_to :department
  has_many :purchases
  has_and_belongs_to_many :roles
  accepts_nested_attributes_for :roles, allow_destroy: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :address, :bio, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :department_id, :position, :photo, :role_ids, :phonenumber, :date_of_birth
  # attr_accessible :title, :body
  validates :department_id, :position, :presence => true
  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100" },
                    :default_url => ":style/missing.png"
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]



  def mailboxer_email(object)
   return email
  end
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
