ActiveAdmin.register Request, :namespace => :admin do
  # controller.authorize_resource
  config.per_page = 10
  menu :priority => 3
  scope(:open){|request| request.openrequest  }
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
  filter :request_number
  filter :title, :as => :string
  filter :total_amount
  filter :user, label: "staff", as: :select, collection: proc { User.all.map{|user| ["#{user.first_name } #{user.last_name}", user.id] }}
  filter :department,:as => :select, :collection => Department.all
  filter :status, :as => :select, :collection => ["Approved", "Rejected", "Open"]
  filter :created_at
  filter :date_approved

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Request Header", :multipart => true do
      f.input :user_id, :label => "Staff", :as => :select, :collection => User.all.map{|u| ["#{u.last_name} #{u.first_name}", u.id]}
      f.input   :title
      f.input  :total_amount, :input_html => { :disabled => true }
      f.input  :department
      f.input     :reason
    end
    f.inputs "Request Items" do
      f.has_many :request_items, allow_destroy: true, new_record: true do |a|
        a.input :item, :label => "Item", :as => :string, :input_html => {
                         class: 'autocomplete',
                         name: '',
                         value: a.object.item.try(:name),
                         data: {
                             url: autocomplete_admin_items_path
                         }
                     }
        a.input :item_id, as: :hidden
        a.input   :request_type, :as => :select, :collection => ["New", "Replacemeent", "Damaged", "others"]
        a.input :quantity
        a.input :amount
        a.input :currency, :as => :select, :collection => ["NGN"]
      end
    end
    f.buttons
  end
  index do
    selectable_column
    column :Requester do |request|
      link_to(image_tag(request.user.photo.url(:thumb)), admin_user_path(request.user)) if request.user
    end
    column("request") {|request| link_to(truncate("#{request.request_number.upcase if request.request_number} - #{request.title}", :lenght => 20), admin_request_path(request))}
    column :total_amount
    column("department") { |request|
      link_to("#{request.user.department.name} - #{request.user.department.station.name}", admin_department_path(request.user.department)) if request.user.department
    }
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
      row :request_number
      row :title
      row :total_amount
      row("department"){
        link_to("#{request.user.department.name} - #{request.user.department.station.name}", admin_department_path(request.user.department)) if request.user.department
      }
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
        column("Unit Price") { |item|
          item.amount
        }
        column("Amount") { |item|
          "#{item.currency } #{item.quantity * item.amount}"
        }
        column :request_type
        column("comment"){|item|
          truncate("#{item.comment}", length: 20)
        }
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
        request.user.department.name + ' - ' + request.user.department.station.name
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

  collection_action :data, :method => :get do
    respond_to do |format|
      format.json {
        render :json => [1,2,3,4,5]
      }
    end
  end

  controller do

    actions :all, :except => [:edit, :destroy]

    def reject
      @request = Request.find(params[:id])
      if @request.reject(params[:reason])
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

  collection_action :autocomplete, method: :get do
    requests = Request.where('LOWER(request_number) LIKE ?', "#{params[:term]}%")
    render json: requests, each_serializer: RequestAutocompleteSerializer, root: false
  end
end
