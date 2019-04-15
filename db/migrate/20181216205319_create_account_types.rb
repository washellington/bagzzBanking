class CreateAccountTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :account_types do |t|
      t.string :type
      t.timestamps
    end
  end
end
