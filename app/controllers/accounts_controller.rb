class AccountsController < ApplicationController

  before_action :read_account, only: [:destroy, :show] 

  def new

  end

  def create
  @account = Account.create account_params.merge ({user_id: @current_user.id, date_created: Time.now})
    
    if @account.persisted?
      flash[:success] = "Successfully created account"
      redirect_to dashboard_user_path(id: @current_user) 
    else
      flash[:error] =  error_messages(@account)
      redirect_back fallback_location: dashboard_user_path(id: @current_user) 
    end
    
  end

  def destroy
    @selected_account.destroy
    flash[:success] = "Successfully destroyed account"
    redirect_to dashboard_user_path(id: @current_user.id)
  end

  def show
    @transactions = @selected_account.transactions
  end

  private
    # Using a private method to encapsulate the permissible parameters is
    # a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def account_params
      params.require(:account).permit(:name, :account_type_id)
    end

    def read_account
      @selected_account = Account.find params[:id]
    end

end
