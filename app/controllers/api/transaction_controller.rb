class Api::TransactionController < Api::BaseController
	before_action :authenticate_customer
	
	def create
		begin
			if(verifyTransactionWithSecurityNumber(params['securityNumber']))
				customerWallet = CustomerWallet.where(customer_id: current_customer.id)
				typeComission = getTypeCommission(item_params[:mountToTransfer])
				comissionCalculated = calculateComision(typeComission, item_params[:mountToTransfer].to_f).to_f
				# puts verifyTransactionWithSecurityNumber(params['securityNumber'])
				# puts "#{item_params['receptorWallet']} receptor"
				# puts "#{current_customer.id} id"
				# puts "#{customerWallet[0]["balance"].to_s} balance"
				# puts "#{item_params[:mountToTransfer]} mount to trans"
				# puts "#{comissionCalculated} comission"
				if (canTransfer(customerWallet[0][:balance], comissionCalculated, item_params[:mountToTransfer].to_f))
					newTransaction = Transaction.new(item_params)
					if newTransaction.save
						chargeComission(customerWallet, item_params[:mountToTransfer].to_f, comissionCalculated)
						
						walletRecep = CustomerWallet.where(id: item_params["receptorWallet"])
						transferMountToRecep(walletRecep, item_params[:mountToTransfer].to_f)

						walletGeneral = CustomerWallet.where(typewallet: "general")
						transferMountToRecep(walletGeneral, comissionCalculated)

						render :json => {status: "created", customer: newTransaction, balance: customerWallet[0]['balance']}
					else
						render :json => {status: "error", message: newTransaction.errors}
					end
				end
			else
				render :json => {status: "error", message: "Wrong securityNumber"}
			end
		rescue Mongo::Error => e
  		if e.message.include? 'E11000'
				render :json => {status:"Already exists the email"}
			end
		end
	end 

	def getTypeCommission(mount)
		case mount.to_f
		when 0 .. 1000 
			{ "porcent" => 0.03, "fixed" => 8}
		when 1001 .. 5000
			{ "porcent" => 0.025, "fixed" => 6}
		when 5001 .. 10000
			{ "porcent" => 0.02, "fixed" => 4}
		else
			{ "porcent" => 0.01, "fixed" => 3}
		end
	end

	def verifyTransactionWithSecurityNumber(securityNumber)
		if(securityNumber.to_i == current_customer.securityNumber.to_i)
			true
		else
			false
		end
	end

	def canTransfer(balance, comission, mount)
		mountPlusComission = comission + mount
		balance > mountPlusComission
	end

	def calculateComision(comission, mount)
		mountPlusComission = mount + (mount * comission['porcent']) + comission['fixed']
	end

	def chargeComission(customerWallet, mount, comission)
		newBalance = customerWallet[0]['balance'] - comission
		customerWallet.update(:balance => newBalance)
		customerWallet[0]['balance']
	end

	def transferMountToRecep(customerWallet, mount)
		newBalance = customerWallet[0]['balance'] + mount
		customerWallet.update(:balance => newBalance)
		customerWallet[0]['balance']
	end

	private def item_params 
		params.require(:transaction).permit(:mountToTransfer, :receptorWallet, :emisorWallet, :comisionP, :comisionB) 
	end 

end
