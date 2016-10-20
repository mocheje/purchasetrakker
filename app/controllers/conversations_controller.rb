class ConversationsController < ApplicationController
  before_filter :get_mailbox
  before_filter :get_conversation, except: [:index, :empty_trash]
  before_filter :get_box, only: [:index]
  before_filter :set_count
  skip_authorization_check

  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox.page(params[:page]).per(10)
      @inbox = "active"
      @in_count
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox.page(params[:page]).per(10)
      @sent = "active"
    else
      @conversations = @mailbox.trash.page(params[:page]).per(10)
      @trash = "active"
    end


  end

  def show
    @conversation.mark_as_read(current_user)
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end

  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end

  def move_to_trash
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
  end

  private

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end

  def set_count
    @inbox_count = @mailbox.inbox.count
    @sentbox_count = @mailbox.sentbox.count
    @trash_count = @mailbox.trash.count
  end
end
