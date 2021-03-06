

var Signup = React.createClass({
  getInitialState: function() {
    return {
      verifying_phone_number : false
      // , csrf_token : this.props.csrf_token
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
    else if (event.target.name == "user[phone_pin]"){
      this.setState({
          phone_pin: event.target.value
      });
      console.log(this.state.phone_pin);
    }
    else if (event.target.name == "user[password]"){
      this.setState({
          password: event.target.value
      });
      console.log(this.state.password);
    }
    else if (event.target.name == "user[confirm_password]"){
      this.setState({
          confirm_password: event.target.value
      });
      console.log(this.state.confirm_password);
    }

  },
  handlePinSubmit: function(e) {
    e.preventDefault();
    console.log("submitted");

    if (this.state.phone_pin && this.state.password && this.state.confirm_password
      && this.state.password == this.state.confirm_password){
      //throw an ajax request
      $.ajax({
        type: "POST",
        beforeSend: $.rails.CSRFProtection,
        url: "/users/" + this.state.user.id + "/verify_phone.json",
        data:{
          user:{
            phone_pin: this.state.phone_pin,
            password_digest: this.state.password
          }
        },
        success: function(res) {
          console.log("success updating chat subscription");
          console.log(res);
          window.location.replace("/login");

        }.bind(this),
        error: function(res) {
          console.log("failure updating chat subscription");
          console.log(res);
        }
      });

    }
    else{
      console.log("something is blank");
    }
  },
  handleSubmit: function(e) {
    e.preventDefault();
    console.log("submitted");

    if (this.state.name && this.state.phone_number){
      //throw an ajax request
      console.log("ajax request");
      $.ajax({
        type: "POST",
        url: "/users.json",
        data:{
          user:{
            name: this.state.name,
            phone_number: this.state.phone_number
          }
        },
        success: function(res) {
          console.log("success updating chat subscription");
          console.log(res);
          this.setState({
            verifying_phone_number : true,
            user: res,
            phone_number_error: ""
          });
        }.bind(this),
        error: function(res) {
          console.log("failure updating chat subscription");
          console.log(res);
          this.setState({
            phone_number_error: res["responseText"]
          })
        }.bind(this)
      });

    }
    else{
      console.log("something is blank");
    }
  },
  render: function(){

    return(
      <div id="signup">
        <h3>Sign Up</h3>
          <form onSubmit={this.handleSubmit}>
            <p>{this.state.phone_number_error}</p>
            <div className="field">
              <label for="user_name"></label><br/>
              <input type="text" placeholder="Your Name" name="user[name]" id="user_name" onChange={this.handleChange}/>
            </div>
            <div className="field">
              <label for="user_phone_number"></label><br/>
              <input type="text" placeholder="Your Phone Number" name="user[phone_number]" id="user_phone_number" onChange={this.handleChange}/>
            </div>
            <br/>
            <button className='btn'>Submit</button>
          </form>

          <form className={this.state.verifying_phone_number? "" : "hidden"} onSubmit={this.handlePinSubmit}>
            <div className="field">
              <label for="phone_pin">Phone Pin</label><br/>
              <input type="text" name="user[phone_pin]" id="phone_pin" onChange={this.handleChange}/>
            </div>
            <div className="field">
              <label for="password">Password</label><br/>
              <input type="password" name="user[password]" id="password" onChange={this.handleChange}/>
            </div>
            <div className="field">
              <label for="confirm_password">Confirm Password</label><br/>
              <input type="password" name="user[confirm_password]" id="confirm_password" onChange={this.handleChange}/>
            </div>
            <button className='btn'>Submit</button>
          </form>

      </div>
    );
  }
});
