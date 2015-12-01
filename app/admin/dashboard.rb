ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => "Administrative Work List" do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to InsightInventory administrator page. This is the default admin index page."
        small "click on the links above to navigate and perform other task"
      end
    end

    div :class => "spacer"

  columns do
    column do
      panel "Most Recent Open Request / Purchases" do
        Request.recent.openrequest.map do |request|
          div :class => "recent_open" do
              span link_to(request.title, admin_request_path(request))

          end
        end
      end
    end

    column do
      panel "Most Recent Goods Receipt" do
        Purchase.recent.map do |purchase|
          div :class => "Recent goods Rececipt" do
            span link_to("#{purchase.request.id } - #{purchase.request.title}", admin_request_path(purchase.request))
          end
        end
      end
    end
  end
    columns do
      column do
        div do
          br
            render 'admin/charts'
        end
      end
    end
  end

end
