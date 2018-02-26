FactoryBot.define do
  
  factory :transaction do
  	mountToTransfer 100
  	comisionB 8
  	comisionP 3
  	emisorWallet "5a91a46268c7361102709c0d"
  	receptorWallet "5a91a46268c7361102709c0d"
  end

end
