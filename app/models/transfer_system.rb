class TransferSystem
  include Mongoid::Document

  field :numberCard, type: Integer
  validates :numberCard, :presence => true

  field :company, type: String
  validates :company, :presence => true

  field :securityNumber, type: String
  validates :securityNumber, :presence => true

end
