var Wallet = createReactClass({
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
	},
	render() { 
		return ( 
			<div style={{textAlign:"center"}}> 
				<ButtonComponent onClick={this.login}>Crear Cartera</ButtonComponent>
			</div> 
		) 
	} 
});
