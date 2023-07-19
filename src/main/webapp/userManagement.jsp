<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<%@ page import="com.helper.User" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Available Flights</title>
    
    <link rel="stylesheet" type="text/css" href="assets/portPage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="icon" href="assets/webicon.ico">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery-ui.min.js"></script>
    
    <style>
        <%@include file="assets/portPage.css" %>
        <%@include file="assets/flightCard.css" %>
        <%@include file="assets/new.css" %>
        
        .<%= activePage = "usermanagement"%> {
        background-color: #007bff;
        }
    </style>
    <style>
    .tempDisplay {
        color: black;
    }
    </style>
    <script>
    window.addEventListener('DOMContentLoaded', (event) => {
        <% 
        String signupResult = (String) request.getSession().getAttribute("signupResult");
        if (signupResult != null) { %>
        
        const registerElement = document.querySelector('.register');
        if (registerElement) {
            registerElement.style.boxShadow = '<%= signupResult.equals("Signup Failed") ? "0 0 250px red" : "0 0 250px black" %>';
        }
            alert("<%= signupResult %>");
        <% } %>
    });
    </script>
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
    
    
    <div class="passenger-info-container">
        <h2 class="passInf">User Management</h2>
         <form id="addUserForm" action="AddUserServlet" method="post" class="form">
                <div class="form__field">
                    <input type="email" name="mailAdress" placeholder="Email" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="password" name="password" placeholder="Password" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="password" name="password2" placeholder="Confirm Password" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="submit" value="Add User" class="submit-button">
                </div>
                <input type="hidden" name="action" value="addUser">
            </form>

            
            <form id="deleteUserForm" action="DeleteUserServlet" method="post" class="form">
                <div class="form__field">
                    <input type="email" name="mailAdress" placeholder="Email" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="submit" value="Delete User" class="submit-button">
                </div>
                <input type="hidden" name="action" value="deleteUser">
            </form>
             </div>
             <% 
            request.getSession().removeAttribute("signupResult");

            %>
<div id="responseMessage"></div>

</body>
</html>
