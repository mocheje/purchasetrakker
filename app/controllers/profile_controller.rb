class ProfileController < ApplicationController
  def index
    @profile = current_user
    authorize! :update, User
  end
end
