ActiveAdmin.register Purchase do
  @request_items = []
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "New Goods Receipt / Purchase", :multipart => true do
      f.input :request, :as => :select, :collection => ["request 1", "requst 2"]
      f.input :quantity_received
      f.input :department_id, :as => :hidden
      f.input :requester, :as => :hidden
      f.input :item, :as => :hidden   #, :collection => @request_items

    end
    f.buttons
  end

end
