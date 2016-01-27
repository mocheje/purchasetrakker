class WelcomeController < ApplicationController
  skip_authorization_check
  def index
    @unread = current_user.mailbox.inbox(:unread => true).count(:id, :distinct => true)
  end
end
