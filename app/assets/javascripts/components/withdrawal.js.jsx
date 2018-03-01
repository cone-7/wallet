class Withdrawal extends React.Component {

	constructor(props) {
	    super(props);
	    this.state = {
	    	transaction: {},
	    	walletInfo: {}
	    }
	    this.handleChange = this.handleChange.bind(this);
	    this.makeWithdrawal = this.makeWithdrawal.bind(this);
	    this.getWalletInfo = this.getWalletInfo.bind(this);
 	}

 	handleChange(propertyName, event) {
    	const transactions = this.state.transaction;
    	transactions[propertyName] = event.target.value;
    	this.setState({ transaction: transactions });
  	}

  	componentDidMount(){
		this.getWalletInfo()
	}

	getWalletInfo(){
		self = this;
		fetch('http://localhost:3000/api/customer_wallet/', {
		  method: 'GET',
		  headers: {
		    'Content-Type': 'application/json', 
		    'Authorization': 'JWT ' + self.props.location.state.jwt //JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MTk4MDAxMDAsInN1YiI6eyIkb2lkIjoiNWE5MWE0NjI2OGM3MzYxMTAyNzA5YzBkIn19.2mLdXqjVSUnzJ0Riv7US4ZAGAnnS0bWT8P8-Ktwvclw'
		  }
		}).then(function(response){
			return response.json();
		}).then(function(data){
			self.setState({walletInfo: data[0], 
				idW: data[0]._id.$oid
			})
		})
	}

	makeWithdrawal() {
		return fetch('http://localhost:3000/api/transaction', {
		  method: 'POST',
		  headers: {
		    'Content-Type': 'application/json',
		    'Authorization': 'JWT ' + this.props.location.state.jwt
		  },
		  body: JSON.stringify({
				"transaction": {
					"mountToTransfer": this.state.transaction.mountToTransfer,
					"receptorWallet": this.state.transaction.receptorWallet
				},
				"securityNumber": this.state.transaction.securityNumber
			})
		}).then(function(response){
			return response.json();
		}).then(function(data){
			if(data.status==='error'){
				alert(data.message)
				return false;
			}
			else
				browserHistory.push({pathname:"/wallet", state: { jwt: self.props.location.state.jwt }})
		})
	}

	
	render() { 
		return ( 
			<div className="body"> 
			{this.state.walletInfo.balance}
				<div className="singleElement">
				Transaction
				</div>
				<div className="singleElement">
				Tarjeta de credito: <input id='mountToTransfer' onChange={this.handleChange.bind(this, 'credit.number')} 
					value={this.state.walletInfo.creditcard ? this.state.walletInfo.creditcard.number : 0} type="text"></input>
				</div>
				<div className="singleElement">	
				Tarjeta de debito: <input id='receptorWallet' onChange={this.handleChange.bind(this, 'credit.number')} 
					value={this.state.walletInfo.debitcard ? this.state.walletInfo.debitcard : 0 } type="text"></input>
				</div>
				<div className="singleElement">
				<ButtonComponent onClick={this.makeTransaction}>Transferir</ButtonComponent>
				</div>
			</div> 
		) 
	} 
}
