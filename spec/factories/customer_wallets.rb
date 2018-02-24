FactoryBot.define do

  factory :customer_wallet do
    creditcard {{"number": "1234123312341234","company": "visa"}}
    debitcard {{"number": "4987098709870987","company": "visa"}}
    typewallet "customer"
    balance 0
    after :create do |customer|
      create_list :customer, 1
    end
  end

end
