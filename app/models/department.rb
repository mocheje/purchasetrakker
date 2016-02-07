class Department < ActiveRecord::Base
  attr_accessible :name, :station_id
  has_many :users
  has_many :purchases
  belongs_to :station
  has_many :requests
  validates :station, :name, :presence => true
end
