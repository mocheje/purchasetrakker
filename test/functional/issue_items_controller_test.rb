require 'test_helper'

class IssueItemsControllerTest < ActionController::TestCase
  setup do
    @issue_item = issue_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue_item" do
    assert_difference('IssueItem.count') do
      post :create, issue_item: { comment: @issue_item.comment, item_id: @issue_item.item_id, quantity: @issue_item.quantity, request_id: @issue_item.request_id }
    end

    assert_redirected_to issue_item_path(assigns(:issue_item))
  end

  test "should show issue_item" do
    get :show, id: @issue_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue_item
    assert_response :success
  end

  test "should update issue_item" do
    put :update, id: @issue_item, issue_item: { comment: @issue_item.comment, item_id: @issue_item.item_id, quantity: @issue_item.quantity, request_id: @issue_item.request_id }
    assert_redirected_to issue_item_path(assigns(:issue_item))
  end

  test "should destroy issue_item" do
    assert_difference('IssueItem.count', -1) do
      delete :destroy, id: @issue_item
    end

    assert_redirected_to issue_items_path
  end
end
