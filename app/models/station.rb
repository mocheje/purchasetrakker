class Station < ActiveRecord::Base
  attr_accessible :location, :name, :address
  has_many :items
end