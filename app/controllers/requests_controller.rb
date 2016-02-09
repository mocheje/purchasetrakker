class RequestsController < InheritedResources::Base
  load_and_authorize_resource except: [:search]

  def index
    if params[:search]
      @requests = Request.search(params[:search])
      @query = true
    else
      @requests = current_user.requests.recent.page(params[:page]).per(15)
    end
    @approved = current_user.requests.approved.count
    @rejected = current_user.requests.rejected.count
    @open = current_user.requests.openrequest.count
    @unread = current_user.mailbox.inbox(:unread => true).count(:id, :distinct => true)
    @openrequest = Request.recent.openrequest.where(:approver_id == current_user).page(params[:page]).per(15)
  end

  def show
    @request = Request.find(params[:id])
    @request_items = @request.request_items
    @cal_total = cal(@request_items)
    @goods_receipt = @request.purchases
  end

  def new
    @request = Request.new
    @request.request_items.build
  end
  def create
    @request = current_user.requests.new(params[:request])
    params.inspect
    if @request.save
      redirect_to @request, notice: "Successfully sent Request."
    else
      render :new
    end
  end
  def cal(arr)
    #initialize amount
    amount = 0
    return 0 if arr.count == 0
    arr.each do |request|
      amount += (request.amount * request.quantity)
    end
    return amount
  end

  def copy
    @source = Request.find(params[:id])
    @request = @source.dup
    @request.request_items = @source.request_items.each {|a| a.id = nil}
    render 'new'
  end

  def search
    @query = params[:s]
    @controller = params[:c]
    @request = Request.find_by_request_number(@query.downcase)
    @purchase = Purchase.new
    @issue = Issue.new
    if @controller == "issues" and @request
      @issued = @request.issues
    end
  end

  def approve
    @request = Request.find(params[:id])
    if @request.approver_id == current_user.id
      if @request.approve
        redirect_to :back, notice: "Approved Succesfully"
      else
        redirect_to :back, alert: "Unsuccessful Request Approval"
      end
    else
      redirect_to :back, alert: "Only the default approver, the admin or the selected approver can approve this request"
    end
  end

  def reject
    @request = Request.find(params[:id])
    #ensure person performing the action is the right person
    if @request.approver_id == current_user.id
      if @request.reject(params[:reason])
        redirect_to :back, alert: "Request Rejected"
      else
        redirect_to :back, alert: "Rejection not possible"
      end
    else
      redirect_to :back, alert: "Only the default approver, the admin or the selected approver can reject this request"
    end
  end
end

