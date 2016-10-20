class Station < ActiveRecord::Base
  attr_accessible :location, :name, :address
  has_many :items, :dependent => :nullify
  has_many :departments, :dependent => :nullify
  has_many :purchases, :dependent => :nullify
  has_many :item_inventories, :dependent => :nullify
  validates :location, :address, :name, :presence => true

end
