class Department < ActiveRecord::Base
  attr_accessible :name, :station
  has_many :users
  has_many :purchases
  validates :station, :name, :presence => true
end
