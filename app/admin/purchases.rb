ActiveAdmin.register Purchase do
  menu :label => "Goods Receipt"
  config.per_page = 10
  @request_items = []
  config.clear_action_items!
  action_item :only => :index do
    link_to "New Goods Receipt" , "/admin/purchases/new"
  end
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "New Goods Receipt / Purchase", :multipart => true do
    f.input :request, :label => "Request", :as => :string, :input_html => {
                       class: 'autocomplete',
                       name: '',
                       value: f.object.request.try(:request_number),
                       data: {
                           url: autocomplete_admin_requests_path
                       }
                    }
    f.input :request_id, as: :hidden
    f.input :item, :label => "Item", :as => :string, :input_html => {
                     class: 'autocomplete',
                     name: '',
                     value: f.object.item.try(:name),
                     data: {
                         url: autocomplete_admin_items_path
                     }
                 }
    f.input :item_id, as: :hidden
    f.input :quantity_received
    end
    f.buttons
  end

  controller do
    actions :all, :except => [:edit, :destroy]
  end
  before_create do |purchase|
    @request = Request.find(purchase.request_id)
    purchase.user  = @request.user
    purchase.station = @request.department.station
  end
end
