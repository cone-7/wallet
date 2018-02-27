class Wallet extends React.Component {

	constructor(props) {
	    super(props);
	    this.state = {
	    	walletInfo: {}
	    }
	    this.getWalletInfo = this.getWalletInfo.bind(this);
 	}

	createWallet() {
		return fetch('http://localhost:3000/api/customer_wallet', {
		  method: 'POST',
		  headers: {
		    'Content-Type': 'application/json', 
		    'Authorization': 'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MTk3OTYxODYsInN1YiI6eyIkb2lkIjoiNWE5MWE0NjI2OGM3MzYxMTAyNzA5YzBkIn19.IHmUI0qBiYuwGc_sTGTTQvJjsJywQJnutaRkvAReNr0'
		  },
		  body: JSON.stringify({
				"auth": {
					"creditcard": {"number": "1234123312341234","company": "visa"}
				}
			})
		}).then(function(response){
			return response.json();
		}).then(function(data){
			console.log(data);
		})
	}

	componentDidMount(){
		this.getWalletInfo()
	}

	getWalletInfo(){
		fetch('http://localhost:3000/api/customer_wallet/', {
		  method: 'GET',
		  headers: {
		    'Content-Type': 'application/json', 
		    'Authorization': 'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1MTk4MDAxMDAsInN1YiI6eyIkb2lkIjoiNWE5MWE0NjI2OGM3MzYxMTAyNzA5YzBkIn19.2mLdXqjVSUnzJ0Riv7US4ZAGAnnS0bWT8P8-Ktwvclw'
		  }
		}).then(function(response){
			return response.json();
		}).then(function(data){
			console.log(data)
			// this.setState(walletInfo: data)
		})
	}

	render() { 
		return ( 
			<div style={{textAlign:"center"}}> 
			
				<ButtonComponent onClick={this.createWallet}>Crear Cartera</ButtonComponent>
			</div> 
		) 
	} 
}
