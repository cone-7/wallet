var Body = createReactClass({
	login() {
		return fetch('http://localhost:3000/api/login', {
		  method: 'POST',
		  headers: {
		    'Content-Type': 'application/json'
		  },
		  body: JSON.stringify({
				"auth": {
					"password": "cone",
					"email": "asd@as.com"
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
				Email:<input id="email" type="text"></input>
				Password<input id="password" type="password"></input>
				<ButtonComponent onClick={this.login}>Enviar</ButtonComponent>
				<Link to="/singup">Singup</Link>
			</div> 
		) 
	} 
});