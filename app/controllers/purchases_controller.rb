class PurchasesController < InheritedResources::Base
  load_and_authorize_resource

  def index
    @purchases = Purchase.all
  end
end

