require 'rails_helper'

RSpec.describe Customer, type: :model do
  before(:all) do
		@cust = create(:customer)
  end

  it "creates a customer" do
  	create(:customer) do |customer|
  		expect(@cust).to be_valid
  	end
  end

  it "is invalid without a name" do
  	build(:customer, name: nil) do |customer|
    	expect(customer).to be_invalid
    end
  end

	it "is invalid without a email" do
  	build(:customer, email: nil) do |customer|
    	expect(customer).to be_invalid
    end
  end

  it "is invalid without a pass" do
  	build(:customer, password: nil) do |customer|
    	expect(customer).to be_invalid
    end
  end

  it "is invalid without a securityNumber" do
  	build(:customer, securityNumber: nil) do |customer|
    	expect(customer).to be_invalid
    end
  end

  it "unique emails" do
    is_expected
      .to have_index_for(email: 1)
      .with_options(unique: true)
  end

end
