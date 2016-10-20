class PurchasesController < InheritedResources::Base
  load_and_authorize_resource

  def index
    @purchases = Purchase.all
  end
  def create
    @purchase = Purchase.new(params[:purchase])
    if @purchase.save
      flash[:notice] = "Succesfully Received goods"
    else
      @request = Request.find(params[:purchase][:request_id])
      @purchase = Purchase.new
      @issue = Issue.new
      if @request
        @issued = @request.issues
      end
    end


  end
end

