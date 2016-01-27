class Station < ActiveRecord::Base
  attr_accessible :location, :name, :address
  has_many :items
  has_many :departments
  has_many :purchases
  has_many :item_inventories
  validates :location, :address, :name, :presence => true

end
