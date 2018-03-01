require 'rails_helper'

RSpec.describe TransferSystem, type: :model do
  before(:all) do
  	@transfer_system = create(:transfer_system)
  end

  it "creates a wallet" do
  	create(:transfer_system) do |transfer_system|
  		expect(@transfer_system).to be_valid
  	end
  end

  it "is invalid without a number" do
  	build(:transfer_system, number: nil) do |transfer_system|
    	expect(transfer_system).to be_invalid
    end
  end

	it "is invalid without a securityNumber" do
  	build(:transfer_system, securityNumber: nil) do |transfer_system|
    	expect(transfer_system).to be_invalid
    end
  end

  it "is invalid without a company" do
  	build(:transfer_system, company: nil) do |transfer_system|
    	expect(transfer_system).to be_invalid
    end
  end

end
