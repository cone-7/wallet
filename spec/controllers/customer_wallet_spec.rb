require 'rails_helper'
  
RSpec.describe Api::CustomerWalletController, :type => :controller do

  before(:all) do
    @cust = create(:customer)

    token = Knock::AuthToken.new(payload: { sub: @cust.id }).token
    @tokentest = { "Authorization" => "JWT #{token}"}

  end

  describe "GET index denied without authentication" do
    it "has a 401 status code" do
      get :index, params: {:id => @cust.id }
      expect(response.status).to eq(401)
    end
  end

  describe "POST " do
    it "to index without authentication response 401 status code" do
      post :create, params: {:customer_wallet => @cust }
      expect(response.status).to eq(401)
    end

    it "with valid info has to create it" do
      request.headers.merge!(@tokentest)
      createWallet = attributes_for(:customer_wallet)
      post :create, params: {:customer_wallet => createWallet }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "created"
    end

    it "with no cards has not to create it" do
      request.headers.merge!(@tokentest)
      createWallet = attributes_for(:customer_wallet, debitcard: nil, creditcard: nil )
      post :create, params: {:customer_wallet => createWallet }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "error"
    end

  end

  describe "PUT" do
    it "index without authentication response 401 status code" do
      post :update, params: {:id => @cust.id, :customer_wallet => @cust.attributes }
      expect(response.status).to eq(401)
    end

    it "and update info with login" do
      updateCustomerW = create(:customer_wallet)
      updateCustomerW['debitcard']['number'] = '1234123312341234'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomerW.id, :customer_wallet => updateCustomerW.attributes, :typeupdate => 'info' }
      res = JSON.parse(response.body)
      walletUpdated = CustomerWallet.find(updateCustomerW.id)
      expect(res['status']).to eq "Updated"
    end

    it "and found with login" do
      updateCustomerW = create(:customer_wallet)
      updateCustomerW['debitcard']['number'] = '1234123312341234'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomerW.id, :customer_wallet => updateCustomerW.attributes, :typeupdate => 'found', :found => 2000 }
      res = JSON.parse(response.body)
      walletUpdated = CustomerWallet.find(updateCustomerW.id)
      expect(walletUpdated.balance).to eq updateCustomerW.balance + 2000
    end

    it "and withdrawal with login" do
      updateCustomerW = create(:customer_wallet)
      updateCustomerW['debitcard']['number'] = '1234123312341234'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomerW.id, :customer_wallet => updateCustomerW.attributes, :typeupdate => 'withdrawal', :found => 500 }
      walletUpdated = CustomerWallet.find(updateCustomerW.id)
      expect(walletUpdated.balance).to eq updateCustomerW.balance - 500
    end

    it "and withdrawal more with login" do
      updateCustomerW = create(:customer_wallet)
      updateCustomerW['debitcard']['number'] = '1234123312341234'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomerW.id, :customer_wallet => updateCustomerW.attributes, :typeupdate => 'withdrawal', :found => 1500 }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "error"
    end

  end

  describe "DELETE" do
    it "index without authentication response 401 status code" do
      post :destroy, params: {:id => @cust.id}
      expect(response.status).to eq(401)
    end

    it "and delete it with login" do
      updateCustomerW = create(:customer_wallet)
      request.headers.merge!(@tokentest)
      post :destroy, params: {:id => updateCustomerW.id}
      res = JSON.parse(response.body)
      expect(res['status']).to eq "Deleted"
    end
  end

end
