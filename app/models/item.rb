class Item < ActiveRecord::Base
  attr_accessible :currency, :description, :name, :unit_of_measurement, :unit_price, :photo, :station_id

  has_attached_file :photo, :styles => { :medium => "300x300", :thumb => "100x100" },
                    :default_url => "item/list.jpg"
  has_many :request_items
  has_many :issue_items
  has_many :item_inventories
  belongs_to :station
  validates :currency, :name, :unit_of_measurement, :unit_price, :presence => true
  validates :name, :uniqueness => true
  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
