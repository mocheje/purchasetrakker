class ProfileController < ApplicationController
  before_filter :authenticate_user!
  def index
    @profile = current_user
  end
end
