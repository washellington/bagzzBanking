class UsersController < ApplicationController

  before_action :user_session, only: [:dashboard]
  def new
  end

  def create
    @user = User.create(user_params)
    if (@user.persisted?)
      login_user(@user)
    else
      flash[:error] = error_messages(@user)
      redirect_to welcome_index_path
    end
  end

  

  def sign_in
    if user_params[:password].blank? || user_params[:email].blank?
      flash[:error] = "Email and Password are required"
      redirect_to root_url
      return
    end
    login_user(User.where(password: user_params[:password], email: user_params[:email]).first)
  end

  def logout 
    # Remove the user id from the session
    @current_user = session[:current_user_id] = nil
    redirect_to root_url
  end


  def dashboard
    puts @current_user.accounts.inspect
  end

  private
    # Using a private method to encapsulate the permissible parameters is
    # a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :address, :state, :password, :password_confirmation)
    end

    def login_user(user)
      if user 
        session[:current_user_id] = user.id
        @current_user = user
        redirect_to dashboard_user_path(id: user.id)
      else 
        flash[:error] = "Could not find user"
        redirect_to root_url
      end
    end

    
end
