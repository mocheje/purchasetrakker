ActiveAdmin.register Item do
  menu :priority => 4
  menu :label => "Items"
  show do |item|
    attributes_table do
      row :image do
        image_tag(item.photo.url(:medium))
      end
      row :name
      row :description
      row :unit_of_measurement
      row :unit_price
      row :currency
    end
    active_admin_comments
  end
  index do
    column :photo do |item|
      link_to(image_tag(item.photo.url(:thumb)), admin_item_path(item))
    end
    column :name
    column :description
    column :unit_of_measurement
    column :unit_price
    column :currency
    default_actions
  end
  filter :name
  filter :description
  filter :unit_of_measurement
  filter :unit_price
  filter :currency


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "New Item", :multipart => true do
    f.input :name
    f.input :description
    f.input :unit_of_measurement
    f.input :unit_price
    f.input :station, :label => "Station", :as => :select, :collection => Station.all
    f.input :currency, :as => :select, :collection => ["NGN", "USD", "GBP","EUR"]
      f.input :photo, :as => :file, :hint => f.object.photo.nil? ? f.template.content_t(:span, "no photo yet"): f.template.image_tag(f.object.photo.url(:medium))


    end
    f.buttons
  end

  controller do
    actions :all, :except => [:edit]
  end

  collection_action :autocomplete, method: :get do
    items = Item.where('LOWER(name) LIKE ?', "#{params[:term]}%")
    render json: items, each_serializer: ItemAutocompleteSerializer, root: false
  end
end
