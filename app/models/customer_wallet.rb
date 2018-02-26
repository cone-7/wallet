class CustomerWallet
  include Mongoid::Document

  field :creditcard, type: Hash

  field :debitcard, type: Hash
  
  field :typewallet, type: String
  validates :typewallet, :presence => true

  field :balance, type: Float, default: 0
  validates :balance, :presence => true
  
  # embeds_one :customer
  field :customer_id, type: String
  validates :customer_id, :presence => true


  index "customer.id" => 1
end
