class Api::TransferSystemController < Api::BaseController
	
	def create
		begin
			card = TransferSystem.where(numberCard: item_params[:numberCard])
			correctNumber = item_params['securityNumber'].to_i == card[0]['securityNumber'].to_i
			correctCompany = item_params['company'] == card[0]['company']
			if(correctNumber && correctCompany)
				render :json => {status: "sucess", isValid: true}
			else
				render :json => {status: "error", isValid: false}
			end
		rescue Mongo::Error => e
  		if e.message.include? 'E11000'
  				render :json => {status:"Already exists the email"}
			end
		end
	end

	private def item_params
		params.require(:transfer_system).permit(:company, :numberCard, :securityNumber)
	end 

end
