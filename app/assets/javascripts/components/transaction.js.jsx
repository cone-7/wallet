class Transaction extends React.Component {

	constructor(props) {
	    super(props);
	    this.state = {
	    	transaction: {}	    	
	    }
	    this.handleChange = this.handleChange.bind(this);
	    this.makeTransaction = this.makeTransaction.bind(this);
 	}

 	handleChange(propertyName, event) {
    	const transactions = this.state.transaction;
    	transactions[propertyName] = event.target.value;
    	this.setState({ transaction: transactions });
  	}

	makeTransaction() {
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
				<div className="singleElement">
				Transaction
				</div>
				<div className="singleElement">
				Monto: <input id='mountToTransfer' onChange={this.handleChange.bind(this, 'mountToTransfer')} 
					value={this.state.transaction.mountToTransfer} type="text"></input>
				</div>
				<div className="singleElement">	
				Wallet receptora: <input id='receptorWallet' onChange={this.handleChange.bind(this, 'receptorWallet')} 
					value={this.state.transaction.receptorWallet} type="text"></input>
				</div>
				<div className="singleElement">
				Numero de Seguridad: <input id='securityNumber' onChange={this.handleChange.bind(this, 'securityNumber')} 
					value={this.state.transaction.securityNumber} type="number"></input>
				</div>
				<div className="singleElement">
				<ButtonComponent onClick={this.makeTransaction}>Transferir</ButtonComponent>
				</div>
			</div> 
		) 
	} 
}
