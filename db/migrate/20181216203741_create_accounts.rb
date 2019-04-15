class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user
      t.references :account_type
      t.datetime :date_created
      t.timestamps
    end
  end
end
