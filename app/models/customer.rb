require 'bcrypt'

class Customer
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :name, type: String
  validates :name, :presence => true

  field :password, type: String
  validates :password, :presence => true
  has_secure_password
  
  field :email, type: String
  validates :email, :presence => true
  
  field :securityNumber, type: String
  validates :securityNumber, :presence => true

  field :password_digest, :type => String

  embeds_one :customer_wallet
  index({ email: 1 }, { unique: true })
end
