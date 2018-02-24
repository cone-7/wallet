class Api::CustomerController < Api::BaseController
	before_action :authenticate_customer, except: :create
	#include ApplicationHelper
	
	def index
		respond_with Customer.all
	end

	def create
		# customer = item_params
		# customer[:pass] = encrypt(customer[:pass])
		begin
			customer = Customer.create(item_params)
			respond_with :api, json: {status: "created", customer: customer}
		rescue Mongo::Error => e
  		if e.message.include? 'E11000'
				render :json => {status:"Already exists the email"}
			end
		end
	end 

	def destroy 
		respond_with Customer.destroy(params[:id]) 
	end 

	def update 
		item = Customer.find(params["id"]) 
		item.update_attributes(item_params) 
		respond_with item, json: item 
	end 

	private def item_params 
		params.require(:customer).permit(:name, :password, :email, :securityNumber) 
	end 
end
