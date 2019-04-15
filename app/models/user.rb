class User < ApplicationRecord
  has_many :accounts

  validates :email, :password, presence: true
  
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

  validates :password, confirmation: true
end
