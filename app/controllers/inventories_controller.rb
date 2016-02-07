class InventoriesController < ApplicationController
  def index
    @station = current_user.department.station
    @inventories = @station.item_inventories.page(params[:page]).per(8)
  end

  def show
    @inventory = ItemInventory.find(params[:id])
    @purchases = Purchase.where(:item_id => @inventory.item_id, :station_id => @inventory.station_id).page(params[:page]).per(10)
    @issues = IssueItem.where(:item_id => @inventory.item_id{
                                |issue_item| return issue_item.issue.request.department.station_id == @inventory.station_id
                              }).page(params[:page]).per(10)
  end
end
