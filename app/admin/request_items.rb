ActiveAdmin.register RequestItem do
  menu :priority => 5
  index do
    column :photo do |request_item|
      link_to(image_tag(request_item.item.photo.url(:thumb)), admin_request_item_path(request_item.item))
    end
    column :item do |request_item|
      link_to(request_item.item.name, admin_item_path(request_item.item))
    end
    column :request do |request_item|
      link_to(request_item.request.title, admin_request_path(request_item.item))
    end
    column :quantity
    column :amount
    column :currency
    default_actions
  end
  
end
