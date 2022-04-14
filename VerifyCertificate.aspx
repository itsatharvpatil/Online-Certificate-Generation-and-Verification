<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/VerifyCertificate.aspx.cs" Inherits="VerifyCertificate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link href="assets/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .login-block {
	background: #DE6262;
	/* fallback for old browsers */
	background: -webkit-linear-gradient(to bottom, #FFB88C, #DE6262);
	/* Chrome 10-25, Safari 5.1-6 */
	background: linear-gradient(to bottom, #FFB88C, #DE6262);
	/* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
	float: left;
	width: 100%;
    height:100vh;
	padding: 50px 0;
}

.banner-sec {
	background: url(https://static.pexels.com/photos/33972/pexels-photo.jpg) no-repeat left bottom;
	background-size: cover;
	min-height: 500px;
	border-radius: 0 10px 10px 0;
	padding: 0;
}

.container {
	background: #fff;
	border-radius: 10px;
	box-shadow: 15px 20px 0px rgba(0, 0, 0, 0.1);
}

.carousel-inner {
	border-radius: 0 10px 10px 0;
}

.carousel-caption {
	text-align: left;
	left: 5%;
}

.login-sec {
	padding: 50px 30px;
	position: relative;
}

.login-sec .copy-text {
	position: absolute;
	width: 80%;
	bottom: 20px;
	font-size: 13px;
	text-align: center;
}

.login-sec .copy-text i {
	color: #FEB58A;
}

.login-sec .copy-text a {
	color: #E36262;
}

.login-sec h2 {
	margin-bottom: 30px;
	font-weight: 800;
	font-size: 30px;
	color: #DE6262;
}

.login-sec h2:after {
	content: " ";
	width: 100px;
	height: 5px;
	background: #FEB58A;
	display: block;
	margin-top: 20px;
	border-radius: 3px;
	margin-left: auto;
	margin-right: auto
}

.btn-login {
	background: #DE6262;
	color: #fff;
	font-weight: 600;
}

.banner-text {
	width: 70%;
	position: absolute;
	bottom: 40px;
	padding-left: 20px;
}

.banner-text h2 {
	color: #fff;
	font-weight: 600;
}

.banner-text h2:after {
	content: " ";
	width: 100px;
	height: 5px;
	background: #FFF;
	display: block;
	margin-top: 20px;
	border-radius: 3px;
}

.banner-text p {
	color: #fff;
}

    </style>
</head>
<body>
    <form runat="server">
      <section class="login-block" >
          <div  style="padding-bottom:1%">

               <img  src="logoo.png" style="padding-left:40%;" >

            
          </div>
          <div style="text-align:center;border:1px solid white; ">
              <h3> Verfiy your certificate</h3>
              <h5> Enter your certificate number here</h5>
              <div class="row">
                  <div class="col-md-6" style="text-align:end">
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtParticipation" ErrorMessage="Enter Participation ID" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtParticipation" runat="server"/>
                  </div>
                  <div class="col-md-6" style="text-align:left"> 
                      <asp:Button ID="btnVerify" runat="server" Text="Verify" CssClass="btn btn-primary" OnClick="btnVerify_Click"/>
                  </div>
              </div>
          </div>
      </section>
    </form>
</body>
</html>
