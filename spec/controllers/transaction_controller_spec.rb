require 'rails_helper'

RSpec.describe Api::TransactionController, type: :controller do

	before(:all) do
    @cust = create(:customer)
    @cust2 = create(:customer, email: 'test2@asd.com')
    custG = create(:customer, email: 'general@asd.com', name: 'general')
    @wallet = create(:customer_wallet, customer_id: @cust.id)
    @wallet2 = create(:customer_wallet, customer_id: @cust2.id)
    walletG = create(:customer_wallet, customer_id: custG.id, typewallet: 'general')

    token = Knock::AuthToken.new(payload: { sub: @cust.id }).token
    @tokentest = { "Authorization" => "JWT #{token}"}

  end

  describe "POST" do
    it "has a 401 status code without login" do
      trans = create(:transaction)
      post :create, params: {:transaction => trans }
      expect(response.status).to eq(401)
    end

    it "creates with login and securityNumber correct" do
      trans = attributes_for(:transaction, receptorWallet: @wallet2.id, emisorWallet: @wallet.id)
      request.headers.merge!(@tokentest)
      post :create, params: {:transaction => trans, :securityNumber => '1234' }
      res = JSON.parse(response.body)
      expect(res['status']).to eq("created")
    end

    it "try to create with login and securityNumber wrong" do
      trans = attributes_for(:transaction, receptorWallet: @wallet2.id, emisorWallet: @wallet.id)
      request.headers.merge!(@tokentest)
      post :create, params: {:transaction => trans, :securityNumber => '12345' }
      res = JSON.parse(response.body)
      expect(res['status']).to eq("error")
    end

    it "creates and comission is charge to emisor" do
      balanceInitial = @wallet2['balance']
      trans = attributes_for(:transaction, receptorWallet: @wallet2.id, emisorWallet: @wallet.id)
      request.headers.merge!(@tokentest)
      post :create, params: {:transaction => trans, :securityNumber => '1234' }
      res = JSON.parse(response.body)
      expect(res['balance']).to eq balanceInitial.to_f - 111
    end

  end

end
