class Department < ActiveRecord::Base
  attr_accessible :name, :station_id
  has_many :users, :dependent => :nullify
  has_many :purchases, :dependent => :nullify
  belongs_to :station
  has_many :requests, :dependent => :nullify
  validates :station, :name, :presence => true
end
