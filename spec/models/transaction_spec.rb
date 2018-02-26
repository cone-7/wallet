require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:all) do
  	@transaction = create(:transaction)
  end

  it "creates a wallet" do
  	create(:transaction) do |transaction|
  		expect(@transaction).to be_valid
  	end
  end

  it "is invalid without a emisorWallet" do
  	build(:transaction, emisorWallet: nil) do |transaction|
    	expect(transaction).to be_invalid
    end
  end

	it "is invalid without a receptorWallet" do
  	build(:transaction, receptorWallet: nil) do |transaction|
    	expect(transaction).to be_invalid
    end
  end

  it "is invalid without a mountToTransfer" do
  	build(:transaction, mountToTransfer: nil) do |transaction|
    	expect(transaction).to be_invalid
    end
  end

  it "is invalid without a comisionB" do
  	build(:transaction, comisionB: nil) do |transaction|
    	expect(transaction).to be_invalid
    end
  end

  it "is invalid without a comisionP" do
  	build(:transaction, comisionP: nil) do |transaction|
    	expect(transaction).to be_invalid
    end
  end

end
