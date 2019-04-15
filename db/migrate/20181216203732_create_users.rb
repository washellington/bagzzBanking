class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.string :address
      t.datetime :date_created
      t.timestamps
    end
  end
end
