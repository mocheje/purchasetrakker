class ChangeRequesterToUserId < ActiveRecord::Migration
  def change
    rename_column :purchases, :requester, :user_id
  end
end
