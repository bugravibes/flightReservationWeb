<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<%@ page import="com.helper.User" %>
<%@ page import="com.helper.Flight" %>
<%@ page import="java.util.*" %>
<%@ page import="com.helper.fetchFlights" %>

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
        .<%= activePage = "reservation"%> {
        background-color: #007bff;
    	}
    </style>
    <style>
    .tempDisplay {
        color: black;
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
    <div class="passenger-info-container">
 <h2 class="passInf">Passenger Information</h2>
<div class="passenger-info" >
   
<form action="SubmitPassengerInfoServlet" method="POST">
    <% for (int i = 1; i <= Integer.parseInt(request.getParameter("adultCount")); i++) { %>
        <div class="passenger-details">
                    
            <h3>Adult <%= i %></h3>
            
            <label for="nameAdult<%= i %>">Name:</label>
            <input type="text" id="nameAdult<%= i %>" name="nameAdult<%= i %>" required>

            <label for="surnameAdult<%= i %>">Surname:</label>
            <input type="text" id="surnameAdult<%= i %>" name="surnameAdult<%= i %>" required>


            <label for="passportAdult<%= i %>">Passport No:</label>
            <input type="text" id="passportAdult<%= i %>" name="passportAdult<%= i %>" required>

            <label for="birthDateAdult<%= i %>">Birth Date:</label>
            <input type="date" id="birthDateAdult<%= i %>" name="birthDateAdult<%= i %>" required>
            <script>
            flatpickr("#birthDateAdult<%= i %>", {});
        </script>

            <label for="genderAdult<%= i %>">Gender:</label>
            <select id="genderAdult<%= i %>" name="genderAdult<%= i %>" required>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </div>
    <% } %>


    <% for (int i = 1; i <= Integer.parseInt(request.getParameter("childCount")); i++) { %>
        <div class="passenger-details">
            <h3>Child <%= i %></h3>
            <label for="nameChild<%= i %>">Name:</label>
            <input type="text" id="nameChild<%= i %>" name="nameChild<%= i %>" required>

            <label for="surnameChild<%= i %>">Surname:</label>
            <input type="text" id="surnameChild<%= i %>" name="surnameChild<%= i %>" required>

            <label for="passportChild<%= i %>">Passport No:</label>
            <input type="text" id="passportChild<%= i %>" name="passportChild<%= i %>" required>

            <label for="birthDateChild<%= i %>">Birth Date:</label>
            <input type="date" id="birthDateChild<%= i %>" name="birthDateChild<%= i %>" required>
                        <script>
            flatpickr("#birthDateChild<%= i %>", {});
        </script>

            <label for="genderChild<%= i %>">Gender:</label>
            <select id="genderChild<%= i %>" name="genderChild<%= i %>" required>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>

        </div>
    <% } %>


    <% for (int i = 1; i <= Integer.parseInt(request.getParameter("infantCount")); i++) { %>
        <div class="passenger-details">
            <h3>Infant <%= i %></h3>
            <label for="nameInfant<%= i %>">Name:</label>
            <input type="text" id="nameInfant<%= i %>" name="nameInfant<%= i %>" required>

            <label for="surnameInfant<%= i %>">Surname:</label>
            <input type="text" id="surnameInfant<%= i %>" name="surnameInfant<%= i %>" required>

            <label for="passportInfant<%= i %>">Passport No:</label>
            <input type="text" id="passportInfant<%= i %>" name="passportInfant<%= i %>" required>

            <label for="birthDateInfant<%= i %>">Birth Date:</label>
            <input type="date" id="birthDateInfant<%= i %>" name="birthDateInfant<%= i %>" required>
                        <script>
            flatpickr("#birthDateInfant<%= i %>", {});
        </script>
        
            <label for="genderInfant<%= i %>">Gender:</label>
            <select id="genderInfant<%= i %>" name="genderInfant<%= i %>" required>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </div>
    <% } %>

        <input type="hidden" name="flightId" value="<%= request.getAttribute("flightId") %>">
        <input type="hidden" name="classValue" value="<%= request.getAttribute("classValue") %>">
        <input type="hidden" name="adultCount" value="<%= request.getAttribute("adultCount") %>">
        <input type="hidden" name="childCount" value="<%= request.getAttribute("childCount") %>">
        <input type="hidden" name="infantCount" value="<%= request.getAttribute("infantCount") %>">
        <button type="submit">Submit</button>
    </form>
</div>
</div>





</body>
</html>
