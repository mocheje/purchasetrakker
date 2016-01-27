class RolesUsers < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :role_id, :user_id
end
