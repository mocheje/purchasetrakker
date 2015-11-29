require 'test_helper'

class RequestItemsControllerTest < ActionController::TestCase
  setup do
    @request_item = request_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:request_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request_item" do
    assert_difference('RequestItem.count') do
      post :create, request_item: { item_id: @request_item.item_id, quantity: @request_item.quantity, request_id: @request_item.request_id }
    end

    assert_redirected_to request_item_path(assigns(:request_item))
  end

  test "should show request_item" do
    get :show, id: @request_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @request_item
    assert_response :success
  end

  test "should update request_item" do
    put :update, id: @request_item, request_item: { item_id: @request_item.item_id, quantity: @request_item.quantity, request_id: @request_item.request_id }
    assert_redirected_to request_item_path(assigns(:request_item))
  end

  test "should destroy request_item" do
    assert_difference('RequestItem.count', -1) do
      delete :destroy, id: @request_item
    end

    assert_redirected_to request_items_path
  end
end
