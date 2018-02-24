require 'rails_helper'

RSpec.describe CustomerWallet, type: :model do
  before(:all) do
	@custw = create(:customer_wallet)
  end

  it "creates a wallet" do
  	create(:customer_wallet) do |customer_wallet|
  		expect(@custw).to be_valid
  	end
  end

  it "is invalid without a type" do
  	build(:customer_wallet, typewallet: nil) do |customer_wallet|
    	expect(customer_wallet).to be_invalid
    end
  end

  it "is invalid without a balance" do
    build(:customer_wallet, balance: nil) do |customer_wallet|
      expect(customer_wallet).to be_invalid
    end
  end

  it "embed customer" do
    is_expected
      .to embed_one :customer
  end

  it "unique emails" do
    is_expected
      .to have_index_for("customer.id": 1)
  end

end
