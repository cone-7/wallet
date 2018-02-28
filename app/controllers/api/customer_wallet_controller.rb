class Api::CustomerWalletController < Api::BaseController
	before_action :authenticate_customer
	#include ApplicationHelper
	
	def index
		item = CustomerWallet.where(customer_id: current_customer.id)
		respond_with item
	end

	def create
		begin
			if(params[:customer_wallet][:debitcard] == nil || params[:customer_wallet][:creditcard] == nil || params[:customer_wallet][:debitcard] == '' || params[:customer_wallet][:creditcard] == '')
				render :json => {status: "error", message: 'Al menos debe haber una tarjeta agregada'}
				return 
			end
			newWallet = item_params
			newWallet[:customer_id] = current_customer.id
			newWallet[:balance] = 0
			newWallet[:typewallet] = 'customer'
			customer = CustomerWallet.create(newWallet)
			render :json => {status: "created", customer: customer}
		rescue Mongo::Error => e
  			if e.message.include? 'E11000'
				render :json => {status:"Already exists a wallet for this user"}
			end
		end
	end 

	def destroy 
		begin
			CustomerWallet.find(params["id"]).remove	
			render :json => {status: "Deleted"}
		rescue Mongoid::Errors::DocumentNotFound => e
			if e.message.include? 'not found'
				render :json => {status:'Wallet no encontrada'}
			end
		end
	end 

	def update 
		item = CustomerWallet.find(params["id"])
		attributesToUpdate = item_params
		if(params[:typeupdate]=='found')
			attributesToUpdate[:balance] = item[:balance].to_f + params[:found].to_f
		end
		if(params[:typeupdate]=='info')
			attributesToUpdate[:debitcard] = item[:debitcard]
			attributesToUpdate[:creditcard] = item[:creditcard]
		end
		if(params[:typeupdate]=='withdrawal')
			if(params[:found].to_f > item.balance.to_f)
				render :json => {status:"error", message:"Saldo insuficiente"}
				return
			end
			attributesToUpdate[:balance] = item[:balance].to_f - params[:found].to_f
		end
		item.update_attributes(attributesToUpdate)
		render :json => {status:"Updated", item: item}
	end 

	private def item_params 
		params.require(:customer_wallet).permit(:creditcard, :typewallet, :debitcard, :balance, :securityNumber) 
	end 
end


