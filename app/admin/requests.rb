ActiveAdmin.register Request do
  menu :priority => 3
  scope(:open){|request| request.open }
  scope :approved
  scope :rejected
  scope :all
  batch_action :destroy, false
  batch_action :approve_selected, confirm: "Only Selected Records with Status as Open will be approved... Do you want to Proceed?" do |requests|
    requests.each do |request|
      Request.find(request).approve
    end
    redirect_to :back
  end
  batch_action :reject_selected, confirm: "Only Selected Record with Status as Open will be rejected ... Do you want to proceed?"  do |requests|
    requests.each do |request|
      Request.find(request).reject
    end
    redirect_to :back
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Request Header", :multipart => true do
      f.input :user_id, :label => "Staff", :as => :select, :collection => User.all.map{|u| ["#{u.last_name} #{u.first_name}", u.id]}
      f.input   :title
      f.input  :total_amount
      f.input  :department, :as => :select, :collection => Department.all.map{|u| ["#{u.name} - #{u.station}", u.id]}
      f.input   :request_type, :as => :select, :collection => ["New", "Replacemeent", "Damaged", "others"]
      f.input     :reason
    end
    f.inputs "Request Items" do
      f.has_many :request_items, allow_destroy: true, new_record: true do |a|
        a.input :item_id, :label => "Item", :as => :select, :collection => Item.all
        a.input :quantity
        a.input :amount
        a.input :currency, :as => :select, :collection => ["NGN", "USD", "GBP","EUR"]
      end
    end
    f.buttons
  end
  index do
    selectable_column
    column :Requester do |request|
      link_to(image_tag(request.user.photo.url(:thumb)), admin_user_path(request.user)) if request.user
    end
    column :title do |request|
      link_to(request.title, admin_request_path(request))
    end
    column :total_amount
    column :department
    column :request_type
    column :reason
    column("status") {|request|
        if request.status == "Open"
          status_tag(request.status)
        elsif request.status == "Approved"
          status_tag(request.status, :ok)
        else
          status_tag(request.status, class: 'reject' )
        end
    }
    column :date_approved

    actions defaults: true do |request|
      link_to 'Approve', admin_request_path(request) if request.open?
    end
  end

  show do |request|
    @items = request.request_items
    attributes_table  do
      row :Requested_Items do
          @items.each do |ritem|
            span link_to(image_tag(ritem.item.photo.url(:thumb)), admin_item_path(ritem.item))
          end
      end
      row :id
      row :title
      row :total_amount
      row :department
      row :request_type
      row :reason
      row("status") {|request|
        if request.status == "Open"
          status_tag(request.status)
        elsif request.status == "Approved"
          status_tag(request.status, :ok)
        else
          status_tag(request.status, class: 'reject' )
        end
      }
      row :date_approved
    end
    panel 'Requested Items Details' do
      table_for @items do
        column :Items do |request_item|
          link_to(request_item.item.name, admin_item_path(request_item.item))
        end
        column :quantity
        column :amount
        column :currency
        column :comment
      end
    end

    active_admin_comments
  end
  sidebar "User Information", only: [:show, :edit] do
    attributes_table_for request.user do
      row :Requester do
        link_to(image_tag(request.user.photo.url(:thumb)), admin_user_path(request.user))
      end
      row("fullname") {
        request.user.first_name + ' ' + request.user.last_name
      }
      row("Department") {
        request.user.department.name + ' - ' + request.user.department.station
      }
      row("Position") {
        request.user.position
      }
      row("Email") {
        request.user.email
      }
    end

  end
  sidebar "Approval", only: [:show] do
    if request.open?
      span render "approve"
      span render "reject"
    else
      attributes_table_for request do
      row("status") {
        if request.status == "Approved"
          status_tag(request.status, :ok)
        else
          status_tag(request.status, class: 'reject' )
        end
      }
      end
    end

  end

  member_action :approve, :method=>:post do

  end
  member_action :reject, :method => :post do

  end
  controller do
    def reject
      @request = Request.find(params[:id])
      if @request.reject
        redirect_to :back, alert: "Request Rejected"
      else
          redirect_to :back, alert: "Rejection not possible"
      end
    end

    def approve
      @request = Request.find(params[:id])
      if @request.approve
        redirect_to :back, notice: "Approved Succesfully"
      else
        reidrect_to :back, alert: "Unsuccessful Request Approval"
      end
    end

  end
end
