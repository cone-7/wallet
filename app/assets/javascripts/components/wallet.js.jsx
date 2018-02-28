class Wallet extends React.Component {

	constructor(props) {
	    super(props);
	    this.state = {
	    	cards: {},
	    	walletInfo: {},
	    	idW: '',
	    }
	    this.getWalletInfo = this.getWalletInfo.bind(this);
	    this.createWallet = this.createWallet.bind(this);
	    this.fondear = this.fondear.bind(this);
	    this.redirectToTrans = this.redirectToTrans.bind(this)
 	}

 	handleChange(propertyName, event) {
    	const cards = this.state.cards;
    	cards[propertyName] = event.target.value;
    	this.setState({ cards: cards });
  	}

	createWallet() {
		return fetch('http://localhost:3000/api/customer_wallet', {
		  method: 'POST',
		  headers: {
		    'Content-Type': 'application/json',
		    'Authorization': 'JWT ' + this.props.location.state.jwt
		  },
		  body: JSON.stringify({
				"customer_wallet": {
					"creditcard": {"number": this.state.cards.creditcard,"company": "visa"},
					"debitcard": {"number": this.state.cards.creditcard,"company": "visa"}
				}
			})
		}).then(function(response){
			return response.json();
		}).then(function(data){
			self.setState({walletInfo: data.customer_wallet})
		})
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
			self.setState({walletInfo: data[0], idW: data[0]._id.$oid})
		})
	}

	fondear(){
		fetch('http://localhost:3000/api/customer_wallet/'+this.state.idW, {
		  method: 'PUT',
		  headers: {
		    'Content-Type': 'application/json', 
		    'Authorization': 'JWT ' + self.props.location.state.jwt
		  },
		  body: JSON.stringify({
				"customer_wallet": {
					"balance": 2000,
					"typeUpdate": 'fondeo'
				}
			})
		}).then(function(response){
			return response.json();
		}).then(function(data){
			console.log(data);
		})

	}

	redirectToTrans(){
		console.log(this.state.jwt+"ssssssss")
		browserHistory.push({pathname:"/transaction", state: { jwt: self.props.location.state.jwt }})
	}

	render() { 
		return ( 
			<div style={{textAlign:"center"}}> 
				{ JSON.stringify(this.state.walletInfo) === JSON.stringify({}) ? (
					<div>
						Credit Card: <input id='creditcard' onChange={this.handleChange.bind(this, 'creditcard')} 
						value={this.state.cards.creditcard} type="number"></input>
						Debit Card: <input id='debitcard' onChange={this.handleChange.bind(this, 'debitcard')} 
						value={this.state.cards.debitcard} type="number"></input>
						<ButtonComponent onClick={this.createWallet}>Crear Cartera</ButtonComponent>
					</div>
					) : 
						(
						<div>
							<div>Tiene {this.state.walletInfo.balance}</div>
							<ButtonComponent onClick={this.fondear}>Fondear</ButtonComponent>	
						</div>
					)
				}
				{this.state.walletInfo.balance > 0 ? (
					//<Link to="/Transaction" params={{ jwt: this.state.jwt }}>Hacer Transaccion</Link>
					<a style={{cursor:'pointer', textDecoration: 'underline'}} onClick={this.redirectToTrans} >Hacer Transaccion</a>
					) : 
					<div></div>
				}
			</div> 
		) 
	} 
}
