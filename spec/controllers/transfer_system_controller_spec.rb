require 'rails_helper'

RSpec.describe Api::TransferSystemController, type: :controller do

	before(:all) do
    @card = create(:transfer_system)
    # @card2 = create(:transfer_system, numberCard: '6789678967896789', securityNumber: 367)
  end

  describe "Validate" do

  	it "has to return true with valid information" do
  		card = attributes_for(:transfer_system)
  		post :create, params: {:transfer_system => card }
  		res = JSON.parse(response.body)
  		expect(res['isValid']).to eq(true)
  	end

  	it "has to return false with invalid securityNumber" do
  		card = attributes_for(:transfer_system, securityNumber: 345)
  		post :create, params: {:transfer_system => card }
  		res = JSON.parse(response.body)
  		expect(res['isValid']).to eq(false)
  	end

  	it "has to return false with invalid company" do
  		card = attributes_for(:transfer_system, company: 'visa')
  		post :create, params: {:transfer_system => card }
  		res = JSON.parse(response.body)
  		expect(res['isValid']).to eq(false)
  	end

  end

end
