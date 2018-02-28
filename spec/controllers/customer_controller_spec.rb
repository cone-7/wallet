require 'rails_helper'
  
RSpec.describe Api::CustomerController, :type => :controller do

  before(:all) do
    @cust = create(:customer)

    token = Knock::AuthToken.new(payload: { sub: @cust.id }).token
    @tokentest = { "Authorization" => "JWT #{token}"}

  end

  describe "GET index denied without authentication" do
    it "has a 401 status code" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe "POST a customer" do
    it "with valid info has to create it" do
      createCustomer = attributes_for(:customer)
      post :create, params: {:customer => createCustomer }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "created"
    end

    it "when the email is already registered has to be error" do
      createCustomer2 = attributes_for(:customer)
      build(:customer)
      post :create, params: {:customer => createCustomer2 }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "Already exists the email"
    end

    it "and update it without login" do
      updateCustomer = create(:customer)
      updateCustomer.name = 'unittest'
      post :update, params: {:id => updateCustomer.id, :customer => updateCustomer.attributes }
      expect(response.status).to eq(401)
    end

    it "and update it with login" do
      updateCustomer = create(:customer)
      updateCustomer.name = 'unittest'
      request.headers.merge!(@tokentest)
      post :update, params: {:id => updateCustomer.id, :customer => updateCustomer.attributes }
      res = JSON.parse(response.body)
      expect(res['status']).to eq "Updated"
    end

  end

end
