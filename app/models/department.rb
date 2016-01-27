class Department < ActiveRecord::Base
  attr_accessible :name, :station_id
  has_many :users
  has_many :purchases
  belongs_to :station
  validates :station, :name, :presence => true
end
