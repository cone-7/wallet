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
      post :create, params: {:customer => createWallet }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "created"
    end

  end

  describe "PUT" do
    it "index without authentication response 401 status code" do
      post :update, params: {:id => @cust.id, :customer => @cust.attributes }
      expect(response.status).to eq(401)
    end

    it "and update it with login" do
      updateCustomerW = create(:customer_wallet)
      updateCustomerW['debitcard']['number'] = '1234123312341234'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomerW.id, :customer => updateCustomerW.attributes }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "Updated"
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
      puts updateCustomerW.id
      post :destroy, params: {:id => updateCustomerW.id}
      res = JSON.parse(response.body)
      expect(res['status']).to eq "Deleted"
    end

  end

  # describe "POST a customer" do
  #   

  #   it "when the email is already registered has to be error" do
  #     createCustomer2 = attributes_for(:customer)
  #     build(:customer)
  #     post :create, params: {:customer => createCustomer2 }
  #     res = JSON.parse(response.body)
  #     expect(res['status']).to eq "Already exists the email"
  #   end

  #   it "and update it without login" do
  #     updateCustomer = create(:customer)
  #     updateCustomer.name = 'unittest'
  #     post :update, params: {:id => updateCustomer.id, :customer => updateCustomer.attributes }
  #     expect(response.status).to eq(401)
  #   end

  # end

end
