ActiveAdmin.register User do
  menu :priority => 6
  config.per_page = 10
  menu :label => "Staff"
  show do |user|
    attributes_table do
      row :image do
        image_tag(user.photo.url(:medium))
      end
      row :first_name
      row :last_name
      row :position
      row :department
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  index do
    column :photo do |user|
      link_to(image_tag(user.photo.url(:thumb)), admin_user_path(user))
    end
    column :first_name
    column :last_name
    column :email
    column :position
    column :department do |user|
      link_to("#{user.department.name} - #{user.department.station}", admin_department_path(user.department)) if user.department
    end
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  filter :first_name
  filter :last_name
  filter :email
  filter :position
  filter :department


  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "New Staff", :multipart => true do
      f.input :first_name
      f.input :last_name
      f.input :position
      f.input :department, :as => :select, :collection => Department.all.map{|u| ["#{u.name} - #{u.station}", u.id]}
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :photo, :as => :file, :hint => f.object.photo.nil? ? f.template.content_t(:span, "no photo yet"): f.template.image_tag(f.object.photo.url(:medium))


    end
    f.buttons
  end
  controller do
    def update
      @user = User.find(params[:id])
      if params[:user][:password].blank?
        @user.update_without_password(params[:user])
      else
        @user.update_attributes(params[:user])
      end
      if @user.errors.blank?
        redirect_to admin_users_path, :notice => "User updated successfully."
      else
        render :edit
      end
    end
  end


end
