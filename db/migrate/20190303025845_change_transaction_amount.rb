class ChangeTransactionAmount < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :amount, :float
  end
end
