class Transaction
  include Mongoid::Document

  field :mountToTransfer, type: Float
  validates :mountToTransfer, :presence => true
  
  field :comisionP, type: Float
  validates :comisionP, :presence => true
  
  field :comisionB, type: Float
  validates :comisionB, :presence => true

  field :receptorWallet, type: String
  validates :receptorWallet, :presence => true

  field :emisorWallet, type: String
  validates :emisorWallet, :presence => true

  # embeds_one :customer, as: :emisor
  # embeds_one :customer, store_as: "receptor"
end
