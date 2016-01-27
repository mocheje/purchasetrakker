class MessagesController < ApplicationController
  skip_authorization_check
  before_filter :get_mailbox
  before_filter :set_count

  def new
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end


  def set_count
    @inbox_count = @mailbox.inbox.count
    @sentbox_count = @mailbox.sentbox.count
    @trash_count = @mailbox.trash.count
  end
end
