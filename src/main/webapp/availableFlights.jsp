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

    <% fetchFlights flightsList = new fetchFlights(); 
	String adultCountParam = request.getParameter("adultCount");
	String childCountParam = request.getParameter("childCount");
	String infantCountParam = request.getParameter("infantCount");

	int adultCount = (adultCountParam != null && !adultCountParam.isEmpty()) ? Integer.parseInt(adultCountParam)
			: 1;
	int childCount = (childCountParam != null && !childCountParam.isEmpty()) ? Integer.parseInt(childCountParam)
			: 0;
	int infantCount = (infantCountParam != null && !infantCountParam.isEmpty()) ? Integer.parseInt(infantCountParam)
			: 0;
    List<Flight> flights = flightsList.getFlights(request.getParameter("fromPort"), request.getParameter("toPort"), request.getParameter("flightDate"),adultCount,childCount,infantCount);

    if (flights != null && !flights.isEmpty()) {
    %>
    <ul>
        <% for (int i=0; i<flights.size(); i++) { %>
        <div class="flight-card">
            <div class="flight-card-header">
                <div class="table">
                    <div class="table-row">
                        <div class="table-cell">
                            <label for="businessRadio<%= i %>">Business</label>
                        </div>
                        <div class="table-cell">
                            <label for="economyRadio<%= i %>">Economy</label>
                        </div>
                    </div>
                    <div class="table-row">
                        <div class="table-cell">
                            <input type="radio" id="businessRadio<%= i %>" name="class<%= i %>" value="business">
                        </div>
                        <div class="table-cell">
                            <input type="radio" id="economyRadio<%= i %>" name="class<%= i %>" value="economy" checked>
                        </div>
                    </div>
                </div>

                <div class="flight-logo">
                    <img src="https://book.jetblue.com/assets/header/img/jetblue-white-reg.png" alt="">
                </div>
                <div class="flightDate">
                    <span class="title">Flight Date</span>
                    <span class="detail"><%= flights.get(i).getFlightDate() %></span>
                </div>
                <div class="flight-data">
                    <div class="passanger-depart">
                        <span class="title">Depart</span>
                        <span class="detail"><%= flights.get(i).getFlightTime() %></span>
                    </div>
                    <div class="passanger-arrives">
                        <span class="title">Arrives</span>
                        <span class="detail"><%= flights.get(i).getArrivalTime() %></span>
                    </div>
                </div>
            </div>

            <div class="flight-card-content">
                <div class="flight-row">
                    <div class="flight-from">
                        <span class="from-code"><%= flights.get(i).getFromPortCode() %></span>
                        <span class="from-city"><%= flights.get(i).getFromPort() %></span>
                    </div>
                    <div class="plane">
                        <img src="https://cdn.onlinewebfonts.com/svg/img_537856.svg" alt="">
                    </div>
                    <div class="flight-to">
                        <span class="to-code"><%= flights.get(i).getToPortCode() %></span>
                        <span class="to-city"><%= flights.get(i).getToPort() %></span>
                    </div>
                </div>
                <div class="flight-details-row">
                    <div class="flight-operator">
                        <span class="title">OPERATOR</span>
                        <span class="detail"><%= flights.get(i).getCompany() %></span>
                    </div>
                    <div class="flight-number">
                        <span class="title">PLANE</span>
                        <span class="detail"><%= flights.get(i).getPlane() %></span>
                    </div>
                    <div class="flight-class">
                        <span class="title">PRICE</span>
                        <span class="detail"><span id="price<%= i %>">$<%= flights.get(i).getEconomyPriceAdult() %></span></span>
                    </div>
                </div>
                <div class="flightSubmit">


                </div>
                <div class="flightSubmit">
    <form action="reservationServlet" method="POST">
    <%
%>
        <input type="hidden" name="flightIndex" value="<%= i %>">      
        <input type="hidden" id="classValue<%= i %>" name="classValue<%= i %>" value="">
        <input type="hidden" name="flightId" value="<%= flights.get(i).getFlightId() %>">
        <input type="hidden" name="adultCount" value="<%= adultCount %>">
        <input type="hidden" name="childCount" value="<%= childCount %>">
        <input type="hidden" name="infantCount" value="<%= infantCount %>">
        <button class="continueButton" type="submit" onclick="setClassValue('<%= i %>')">CONTINUE</button>
    </form>
</div>
            </div>
        </div>

        <script>
            var businessRadio<%= i %> = document.getElementById("businessRadio<%= i %>");
            var economyRadio<%= i %> = document.getElementById("economyRadio<%= i %>");
            var price<%= i %> = document.getElementById("price<%= i %>");

            businessRadio<%= i %>.addEventListener("change", function() {
                price<%= i %>.textContent = "$<%= flights.get(i).getBusinessPriceAdult() %>";
            });

            economyRadio<%= i %>.addEventListener("change", function() {
                price<%= i %>.textContent = "$<%= flights.get(i).getEconomyPriceAdult() %>";
            });

            function setClassValue(index, economyPrice, businessPrice) {
                var businessRadio = document.getElementById("businessRadio" + index);
                var economyRadio = document.getElementById("economyRadio" + index);
                var classValue = document.getElementById("classValue" + index);
                var price = document.getElementById("price" + index);

                if (businessRadio.checked) {
                    classValue.value = "Business";
                    price.textContent = "$" + businessPrice; 
                } else if (economyRadio.checked) {
                    classValue.value = "Economy";
                    price.textContent = "$" + economyPrice;
                }
            }
        </script>
        <% } %>
    </ul>

    <% } else { %>
    <p class="noflightmessage">No Flights Available</p>
    <% } %>

</body>
</html>
