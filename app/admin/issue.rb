ActiveAdmin.register Issue do

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Request Header", :multipart => true do
      f.input :user_id, :label => "Staff", :as => :select, :collection => User.all.map{|u| ["#{u.last_name} #{u.first_name}", u.id]}
      f.input :request, :label => "Request Number", :as => :string, :input_html => {
                          class: 'autocomplete',
                          name: '',
                          value: f.object.request.try(:request_number),
                          data: {
                              url: autocomplete_admin_requests_path
                          }
                      }
      f.input :request_id, as: :hidden
    end
    f.inputs "Issue Items" do
      f.has_many :issue_items, allow_destroy: true, new_record: true do |a|
        a.input :item, :label => "Item", :as => :string, :input_html => {
                         class: 'autocomplete',
                         name: '',
                         value: a.object.item.try(:name),
                         data: {
                             url: autocomplete_admin_items_path
                         }
                     }
        a.input :item_id, as: :hidden
        a.input :quantity
        a.input :comment
      end
    end
    f.buttons
  end

end