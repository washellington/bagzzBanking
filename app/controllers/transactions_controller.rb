class TransactionsController < ApplicationController

  before_action :read_accounts
  
  def deposit 
    read_accounts
  end

  def index
    read_accounts
  end

  def search 
    
    search_params = params.require(:transaction).permit(:start_date, :description, :end_date)

    unless search_params.values.any?{|x| x.present?}
      flash[:error] = "Search contains no criterias"
      redirect_to account_path(id: @selected_account.id)
      return
    end
    
    @search_criteria = {}
    


    @search_criteria[:date_applied] = (Date.strptime(search_params[:start_date], '%m/%d/%Y'))..((Date.strptime(search_params[:end_date], '%m/%d/%Y') + 1).midnight) if search_params[:end_date].present? && search_params[:start_date].present?
    
    @transactions = Transaction.where(@search_criteria).where({account_id: @selected_account.id})

    @transactions = @transactions.where(["description like ?", "%#{search_params[:description]}%"] ) if search_params[:description].present?

    @search_criteria = @search_criteria.except(:description, :account_id).merge search_params


    @transactions = @transactions.where("date_applied < ?", (Date.strptime(search_params[:end_date], '%m/%d/%Y') + 1).midnight) if search_params[:end_date].present? && !search_params[:start_date].present?


    @transactions = @transactions.where("date_applied > ?", Date.strptime(search_params[:start_date], '%m/%d/%Y').midnight) if !search_params[:end_date].present? && search_params[:start_date].present?

    
  end

  def withdraw 
    read_accounts
  end

  def deposit_funds
    record =  perform_transaction(TransactionCategory::DEPOSIT)
    if record.persisted?
      flash[:success] = "Successfully deposited $#{sprintf('%0.2f', record.amount.to_s)}"
    else
      flash[:error] = error_messages(record)
    end 
    redirect_to user_account_path( id:  @selected_account.id, user_id:  @current_user.id)
  end

  def perform_transaction(transaction_type)
    read_accounts
    x = Transaction.new transaction_params
    record =  add_transaction(x, transaction_type)
  end

  def add_transaction(transaction, cateory_id)
    transaction.account = @selected_account
    transaction.transaction_category_id = cateory_id
    transaction.date_applied = Time.now
    transaction.save
    transaction
  end

  def withdraw_funds 
    record =  perform_transaction(TransactionCategory::WITHDRAW)
    if record.persisted?
      flash[:success] = "Successfully withdrawned $#{sprintf('%0.2f', record.amount.to_s)}"
    else
      flash[:error] = error_messages(record)
    end 
    redirect_to user_account_path( id:  @selected_account.id, user_id:  @current_user.id)
  end

  private
    def read_accounts
      @selected_account = Account.find params[:account_id]
    end 

    # Using a private method to encapsulate the permissible parameters is
    # a good pattern since you'll be able to reuse the same permit
    # list between create and update. Also, you can specialize this method
    # with per-user checking of permissible attributes.
    def transaction_params
      params.require(:transaction).permit(:amount, :description)
    end

    

end
