class Api::TransactionController < Api::BaseController
	before_action :authenticate_customer
	#include ApplicationHelper
	
	def create
		# customer = item_params
		# customer[:pass] = encrypt(customer[:pass])
		begin
			customer = Transaction.create(item_params)
			render :json => {status: "created", customer: customer}
		rescue Mongo::Error => e
  		if e.message.include? 'E11000'
				render :json => {status:"Already exists the email"}
			end
		end
	end 

end
