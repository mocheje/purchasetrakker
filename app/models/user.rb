class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :department_id, :position, :photo
  # attr_accessible :title, :body
  validates :department_id, :photo, :position, :presence => true
  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100" }
  has_many :requests
  belongs_to :department
end
