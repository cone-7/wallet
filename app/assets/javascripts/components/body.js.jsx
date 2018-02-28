class Body extends React.Component {
	constructor(props) {
		super(props);
		    this.state = {
		      loginInfo: {}
		    };
		 this.login = this.login.bind(this);
		 this.handleChange = this.handleChange.bind(this);
  	}

	login() {
		return fetch('http://localhost:3000/api/login', {
		  method: 'POST',
		  headers: {
		    'Content-Type': 'application/json'
		  },
		  body: JSON.stringify({
				"auth": {
					"password": this.state.loginInfo.pass,
					"email": this.state.loginInfo.email
				}
			})
		}).then(function(response){
			return response.json();
		}).then(function(data){
			browserHistory.push({pathname:"/wallet", state: { jwt: data.jwt }})
		})
	}

	handleChange(propertyName, event) {
    	const dataLogin = this.state.loginInfo;
    	dataLogin[propertyName] = event.target.value;
    	this.setState({ loginInfo: dataLogin });
  	}

	render() { 
		return ( 
			<div style={{textAlign:"center"}}> 
				Email:<input id='email' onChange={this.handleChange.bind(this, 'email')} 
					value={this.state.loginInfo.email} type="text"></input>
				Password<input id='pass' onChange={this.handleChange.bind(this, 'pass')} 
					value={this.state.loginInfo.pass} type="password"></input>
				<ButtonComponent onClick={this.login}>Enviar</ButtonComponent>
				<Link to="/singup">Singup</Link>
			</div> 
		) 
	} 
}