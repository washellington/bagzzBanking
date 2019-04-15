class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_variables
  before_action :current_user
  
  
  private

  def set_variables
    @action_name = action_name
  end
 
  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

  def is_logged_in
    @current_user.present?
  end

  def user_session
    @current_user = User.where(id: session[:current_user_id])&.first
    redirect_to root_url if @current_user.nil?
  end

  def error_messages(record)
    "The following errors occured: #{record.errors.full_messages.join('\n')}"
  end
end
