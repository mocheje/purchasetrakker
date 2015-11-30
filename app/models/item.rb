class Item < ActiveRecord::Base
  attr_accessible :currency, :description, :name, :unit_of_measurement, :unit_price, :photo, :station_id

  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100" }
  has_many :request_items
  belongs_to :station
  validates :currency, :name, :unit_of_measurement, :unit_price, :photo, :presence => true
end
