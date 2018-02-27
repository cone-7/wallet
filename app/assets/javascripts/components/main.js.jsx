var Main = createReactClass({ 
	render() { 
		// return ( 
		// 	<div> 
		// 		<Header/>
		// 		<Body/>
		// 	</div> 
		// )
		return (
			<div>
				<Header/>
				<Router history={browserHistory}>
					<Route path="/" component={Body}/>
					<Route path="/Singup" component={Singup}/>
				</Router>
			</div>
		)
	} 
});
