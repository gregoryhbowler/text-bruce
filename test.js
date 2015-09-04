$.ajax({
  type: "POST",
  url: "http://localhost:3000/sms/reply",
  dataType: "json",
  data:{
    ToCountry:"US",
    ToState:"CA",
    SmsMessageSid:"SM4cab0f269b87974dcb9d1b0d456acb1d",
    NumMedia:"0",
    ToCity:"LOS ANGELES",
    FromZip:"90068",
    SmsSid:"SM4cab0f269b87974dcb9d1b0d456acb1d",
    FromState:"CA",
    SmsStatus:"received",
    FromCity:"LOS ANGELES",
    Body:"Ricky- u there",
    FromCountry:"US",
    To:"+13235034566",
    ToZip:"90015",
    NumSegments:"1",
    MessageSid:"SM4cab0f269b87974dcb9d1b0d456acb1d",
    AccountSid:"AC3c474e5003b5d4c98c186467a0c9b0bd",
    From:"+13233016764",
    ApiVersion:"2010-04-01"
  },
  success: function(res) {
    console.log("success updating chat subscription");
    console.log(res);

  },
  error: function(res) {
    console.log("failure updating chat subscription");
    console.log(res);
  }
});
