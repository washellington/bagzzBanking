class Transaction < ApplicationRecord
  belongs_to :account

  belongs_to :transaction_category

  attr_accessor :start_date, :end_date

  validates :amount, :date_applied, presence: true

  validates :amount, numericality: {greater_than: 0}

  def net_amount
    transaction_category.id == TransactionCategory::DEPOSIT ? amount : amount * -1
  end

  def account_balance 
    account.balance_on(date_applied) + net_amount  
  end
  
end
