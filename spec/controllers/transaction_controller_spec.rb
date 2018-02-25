require 'rails_helper'

RSpec.describe Api::TransactionController, type: :controller do

	before(:all) do
    @cust = create(:customer)

    token = Knock::AuthToken.new(payload: { sub: @cust.id }).token
    @tokentest = { "Authorization" => "JWT #{token}"}

  end

  describe "POST" do
    it "has a 401 status code without login" do
      post :create, params: {:id => @cust.id }
      expect(response.status).to eq(401)
    end
  end

end
