var ButtonComponent = createReactClass( {
	render(){
	  return (
	    <button disabled={this.props.disabled} onClick={() => this.props.onClick()}>
	    	{this.props.children}
	    </button>
	  )
	}
});