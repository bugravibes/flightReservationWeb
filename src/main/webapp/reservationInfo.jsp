<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<%@ page import="com.helper.User" %>
<%@ page import="com.helper.Reservation" %>
<%@ page import="java.util.*" %>
<%@ page import="com.helper.fetchReservations" %>
<%@ page import="com.helper.updatePayment" %>

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
        .<%= activePage = "pnrsearch"%> {
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
<%
String PNR = request.getParameter("PNR");

List<Reservation> reservations = new ArrayList<>();
reservations = fetchReservations.getReservationsByPNR(PNR);
reservations.toString();
%>
<div class="reservation-list">
    
    <% java.math.BigDecimal totalPrice=new BigDecimal("0.00");
    if (reservations.isEmpty()) { %>
        <p>No reservations found.</p>
    <% } else { %>
    <h2>PNR:  <%=  reservations.get(0).getPnr() %> </h2>
        <% for (Reservation reservation : reservations) { %>
        
            <div class="reservation-item">
                <table>
    <thead>
        <tr>
            <th colspan="8">Flight Info</th>
            <th colspan="5">Passenger Info</th>
            <th colspan="2">Price</th>
        </tr>
    </thead>
    <tbody>
        <tr>
        	<td><%=  reservation.getFlightNo() %></td>
            <td><%=  reservation.getFlightDate() %></td>
            <td><%=  reservation.getFlightTime() %></td>
            <td><%=  reservation.getCompany() %></td>
            <td><%=  reservation.getFromPort() %></td>
            <td><%=  reservation.getToPort() %></td>
            <td><%=  reservation.getFlightTime() %></td>
             <td><%=  reservation.getFlightClass() %></td>
            
            <td><%=  reservation.getName() %></td>
            <td><%=  reservation.getSurname() %></td>
            <td><%=  reservation.getBirthDate() %></td>
            <td><%=  reservation.getGender().toUpperCase() %></td>
            <td><%=  reservation.getCategory().toUpperCase() %></td>
            
            <td>$ <%=  reservation.getPrice() %></td>
            <td><%=  updatePayment.getPayment(PNR) %></td>
            
        </tr>

    </tbody>

</table>
			<% java.math.BigDecimal priceTemp = new BigDecimal(reservation.getPrice().toString());
               totalPrice = totalPrice.add(priceTemp); %>
        <% } %>
    <% } %>
    </div>
    <div class="totalPrice">
            <h2>$<%=  totalPrice %> <%=  updatePayment.getPayment(PNR) %></h2>
        </div>
            <div class="payment">
    <button type="button" onclick="showCancelConfirmation()">Cancel</button>
</div>

<script>
    function showCancelConfirmation() {
        var confirmation = confirm("Do you want to cancel your reservation?");
        if (confirmation) {
            var PNR = "<%= PNR %>";

            $.ajax({
                type: "POST",
                url: "updatePayment.jsp", 
                data: { PNR: PNR },
                success: function(response) {
                    alert("Reservation canceled successfully!");
                    var url = "selectPorts.jsp?PNR=" + encodeURIComponent(PNR);
                    window.location.href = url;
                },
                error: function(error) {
                    alert("An error occurred while canceling the reservation.");
                }
            });
        }
    }
</script>


</div>
        
</body>
</html>
