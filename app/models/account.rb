class Account < ApplicationRecord

  has_many :transactions, -> { order("date_applied DESC")}

  validates :name, :account_type_id, :date_created, presence: true
  
  def self.total(transactions)
    transactions.sum(&:net_amount)
  end

  def balance_on(date)
    transactions.where('date_applied < ?', date ).sum(&:net_amount)
  end
end
