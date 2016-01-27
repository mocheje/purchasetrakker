ActiveAdmin.register_page "Dashboard", :namespace => :admin do

  #controller.skip_authorization_check
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }, url: '/'

  content :title => "Administrative Work List" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to Purchase Trakker administrator page. This is the default admin index page."
        small "click on the links above to navigate and perform other task"
      end
    end

    div :class => "spacer"

  columns do
    column do
       panel "Most Recent Open Request / Purchases" do
         table_for Request.recent.openrequest.map do
           column("Status")   {|request| status_tag(request.status)                                    }
           column("Staff"){|request| link_to(request.user.first_name + " "  + request.user.last_name, admin_user_path(request.user)) }
           column("Request") {|request| link_to(request.title + " -" + request.user.department.name + "-" + request.user.department.station.name, admin_request_path(request))}
           column("Total")   {|request| "NGN #{request.total_amount} "}
         end
       end
    end

    column do
      panel "Most Recent Goods Receipt" do
        Purchase.recent.map do |purchase|
          div :class => "Recent goods Rececipt" do
           # span link_to("#{purchase.request.request_number } - #{purchase.request.title}", admin_request_path(purchase.request))
          end
        end
      end
    end
  end
    columns do
      column do
        div do
          render 'admin/dashboard/bar'
        end
      end
    end
  end

end
