class WelcomeController < ApplicationController
  def index
    redirect_to dashboard_user_path(id: @current_user.id) if @current_user.present?
  end
end
