class RequestsController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
    @requests = current_user.requests.recent
    @approved = current_user.requests.approved.count
    @rejected = current_user.requests.rejected.count
    @open = current_user.requests.open.count
  end

  def show
    @request = Request.find(params[:id])
    @request_items = @request.request_items
    @cal_total = cal(@request_items)
  end

  def new
    @request = Request.new
    @request.request_items.build
  end
  def create
    @request = current_user.requests.new(params[:request])
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
end

