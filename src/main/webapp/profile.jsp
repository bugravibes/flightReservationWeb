<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<%@ page import="com.helper.User" %>
<%@ page import="com.helper.Flight" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    
    <link rel="stylesheet" type="text/css" href="assets/portPage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="icon" href="assets/webicon.ico">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery-ui.min.js"></script>
    
    <style>
        <%@include file="assets/portPage.css" %>
        .<%= activePage = "profile"%> {
        background-color: #007bff;
    	}
    </style>
    <style>
*{
  margin: 0;
  padding: 0;
  font-family: "Open Sans",sans-serif;
  box-sizing: border-box;
  text-decoration: none;
}
body {
	background-color: #354152;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

h2 {
	padding-bottom: 10px;
	color:#fff;
}
h6 {
	margin: 10px 0;
	color:#fff;
}
p {
	font-size: 15px;
	line-height: 21px;
	margin: 15px;
}

.card-container {
  background-color: #354152;
  border-radius: 20px;
  box-shadow: 0 0 250px #000;
  color: white;
  padding-top: 30px;
  position: relative;
  width: 350px;
  max-width: 100%;
  text-align: center;
}

.card-container .pro {
	color: #354152;
	background-color: #354152;
	border-radius: 3px;
	font-size: 20px;
	font-weight: bold;
	padding: 3px 7px;
	position: absolute;
	top: 30px;
	left: 30px;
}

.card-container .round {
	border: 1px solid #fff;
	border-radius: 50%;
	padding: 9px;
	margin-bottom: 10px;
	width: 45%;
	color: #354152;

}


.social-media{
	position: absolute;
	width: 100%;
	top: 305px;
	left: 0;
	z-index: 1;
  }

  .social-media i {
    width: 50px;
    height: 50px;
    background: #565d5c;
    border-radius: 50%;
    color: #f1f1f1;
    font-size: 20px;
    line-height: 50px !important;
    margin: 0px 7px;
    position: relative;
}

  .social-media i:after{
	content: "";
	width: 100%;
	height: 100%;
	position: absolute;
	background: #fff;
	left: 0;
	top: 0;
	box-sizing: border-box;
	border-radius: 50%;
	z-index: -1;
	transition: 0.4s linear;
  }

  .social-media i:hover:after{
	transform: scale(1.4);
	opacity: 0;
  }


button.primary {
	background-color: #fff;
	border: 1px solid #fff;
	border-radius: 3px;
	color: #231E39;
	font-family: Montserrat, sans-serif;
	font-weight: 500;
	padding: 10px 25px;
	margin: 20px 0px;
	transition: 0.3s;
}

button.primary.ghost {
	background-color: transparent;
	color: #fff;
	margin-top: 80px;
	transition: 0.6s;
}

button.primary.ghost:hover {
    background-color: grey;
    color: #fff;
    border-color: #565d5c;
}

.skills {
  background-color: navy;
  text-align: left;
  padding: 15px;
  margin-top: 10px;
  border-radius: 0 0px 20px 20px;
}

.skills ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.skills ul li {
	border: 1px solid #fff;
	border-radius: 2px;
	display: inline-block;
	font-size: 12px;
	margin: 0 7px 7px 0;
	padding: 7px;
}

.skills ul li:hover {
    color: #fff;
}
</style>
    </head>
<body>
    <% User user = (User) request.getSession().getAttribute("loggedInUser"); %>
    <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
        <div class="container-fluid d-flex flex-column p-0">
            <a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                <img src="assets/crane.png" alt="Logo" class="sidebar-logo">
            </a>
            <hr class="sidebar-divider my-0" />
            <ul id="accordionSidebar" class="navbar-nav text-light">
                <li class="nav-item <%= activePage.equals("profile") ? "active" : "" %>">
                    <a class="nav-link" href="profile.jsp"><i class="fas fa-user"></i><span>Profile</span></a>
                </li>
                <li class="nav-item <%= activePage.equals("reservation") ? "active" : "" %>">
                    <a class="nav-link" href="selectPorts.jsp"><i class="fas fa-tachometer-alt"></i><span>Reservation</span></a>
                </li>
                <li class="nav-item <%= activePage.equals("pnrsearch") ? "active" : "" %>">
                    <a class="nav-link" href="pnrSearch.jsp"><i class="fas fa-table"></i><span>Pnr Search</span></a>
                </li>
                <li class="nav-item <%= activePage.equals("usermanagement") ? "active" : "" %>">
                    <a class="nav-link" href="userManagement.jsp"><i class="far fa-user-circle"></i><span>User Management</span></a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="card-container">
      <span class="pro"><i class="message fas fa-envelope"></i></span>
      <img decoding="async" class="round" src="https://img.freepik.com/free-icon/user_318-644324.jpg" alt="user" />
      <h2><%= (user != null) ? user.getName() : "GuestName" %> <%= (user != null) ? user.getSurname() : "GuestSurname" %></h2>
      <p>About <br/>You</p>
      <div class="buttons">
        <div class="bottom-section">
          <div class="social-media">
            <a href="#"><i class="fab fa-facebook">logo1</i></a>
            <a href="#"><i class="fab fa-twitter">logo2</i></a>
            <a href="#"><i class="fab fa-instagram">logo3</i></a>
            <a href="#"><i class="fas fa-link">logo4</i></a>
          </div>
      </div>
        <button class="primary ghost">
          GET PREMIUM
        </button>
      <div class="skills">

        <h6>Airports Travelled</h6>
        <ul>
          <li>IST</li>
          <li>SAW</li>
          <li>AMS</li>
          <li>ATL</li>

        </ul>
      </div>
    </div>
    </div>
    
</body>
</html>
