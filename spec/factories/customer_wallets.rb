FactoryBot.define do

  factory :customer_wallet do
    creditcard {{"number": "1234123312341234","company": "visa"}}
    debitcard {{"number": "4987098709870987","company": "visa"}}
    typewallet "customer"
    balance 1000
    customer_id "5a91a46268c7361102709c0d"
    # after :create do |customer|
    #   create :customer
    # end
  end

end
