class Transaction
  include Mongoid::Document

  field :monto, type: Integer
  validates :monto, :presence => true
  
  field :comisionP, type: Integer
  validates :comisionP, :presence => true
  
  field :comisionB, type: Integer
  validates :comisionB, :presence => true

  embeds_one :customer, as: emisor
  embeds_one :customer, as: receptor
end
