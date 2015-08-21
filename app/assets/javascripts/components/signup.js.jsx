var Signup = React.createClass({
  getInitialState: function() {
    return {

    };
  },
  componentDidMount: function(){

  },
  handleChange: function(event) {
    if (event.target.name == "user[name]"){
      this.setState({
          name: event.target.value
      });
      console.log(this.state.name);
    }
    else if (event.target.name == "user[phone_number]"){
      this.setState({
          phone_number: event.target.value
      });
      console.log(this.state.phone_number);
    }

  },
  handleSubmit: function(e) {
    e.preventDefault();
    console.log("submitted");

    if (this.state.name && this.state.phone_number){
      
    }
    else{
      console.log("something is blank");
    }
  },
  render: function(){

    return(
      <div>
        <h3>Hello world</h3>
          <form onSubmit={this.handleSubmit}>
            <div className="field">
              <label for="user_name">Name</label><br/>
              <input type="text" name="user[name]" id="user_name" onChange={this.handleChange}/>
            </div>
            <div className="field">
              <label for="user_phone_number">Phone number</label><br/>
              <input type="text" name="user[phone_number]" id="user_phone_number" onChange={this.handleChange}/>
            </div>
            <button>Submit</button>
          </form>
      </div>
    );
  }
});
