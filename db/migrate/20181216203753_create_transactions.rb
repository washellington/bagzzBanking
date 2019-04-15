class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.datetime :date_applied
      t.references :account
      t.references :transaction_category
      t.timestamps
    end
  end
end
