<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String activePage = (String) request.getAttribute("activePage"); %>
<%@ page import="com.helper.User" %>

<!DOCTYPE html>
<html>
<head>
    <title>Select Port</title>
    
    <link rel="stylesheet" type="text/css" href="assets/portPage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="icon" href="assets/webicon.ico">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery-ui.min.js"></script>
    
    <style>
        <%@include file="assets/portPage.css" %>
        .<%= activePage = "reservation"%> {
        background-color: #007bff;
    }
    </style>
    
    <style>
        .form-row {
            display: flex;
            align-items: center;
        }

        .form-row .selectorMain {
            flex: 1;
            margin-right: 10px;
        }

        .form-row .search-button {
            flex: 0;
            margin-top: 27px;
            margin-left: 80px;
        }
    </style>
    <script>
        $(document).ready(function() {
            $("#fromPort").change(function() {
                var selectedDeparturePort = $(this).val();
                $("#toPort option").each(function() {
                    var arrivalPort = $(this).val();
                    if (selectedDeparturePort === arrivalPort) {
                        $(this).prop("disabled", true);
                    } else {
                        $(this).prop("disabled", false);
                    }
                });
            });
        });
        $(document).ready(function() {
            $("#toPort").change(function() {
                var selectedArrivalPort = $(this).val();
                $("#fromPort option").each(function() {
                    var departurePort = $(this).val();
                    if (selectedArrivalPort === departurePort) {
                        $(this).prop("disabled", true);
                    } else {
                        $(this).prop("disabled", false);
                    }
                });
            });
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


<h2>Welcome <%= (user != null) ? user.getName() : "Guest" %>,</h2>



<form action="availableFlightsServlet" method="post">
    <div>
        <label>
            <input type="radio" name="flightType" value="oneWay"> One Way
            <input type="radio" name="flightType" value="roundTrip"> Round Trip
        </label>
    </div>

<div class="inline">
    <label for="fromPort">Departure Port:</label>
    <select id="fromPort" name="fromPort" class="selectorMain">
        <option value="" disabled selected>Select Departure Port</option>
<option value="Istanbul">Istanbul</option>
<option value="Amsterdam Schiphol">Amsterdam Schiphol</option>
<option value="London Heathrow">London Heathrow</option>
<option value="Hartsfield-Jackson Atlanta">Hartsfield-Jackson Atlanta</option>
<option value="Guangzhou Baiyun">Guangzhou Baiyun</option>
<option value="Charles de Gaulle">Charles de Gaulle</option>
<option value="Denver International">Denver International</option>
<option value="Dallas/Fort Worth">Dallas/Fort Worth</option>
<option value="Dubai International">Dubai International</option>
<option value="Frankfurt am Main">Frankfurt am Main</option>
<option value="Tokyo Haneda">Tokyo Haneda</option>
<option value="Incheon International">Incheon International</option>
<option value="John F. Kennedy International">John F. Kennedy International</option>
<option value="Los Angeles International">Los Angeles International</option>
<option value="Madrid Barajas">Madrid Barajas</option>
<option value="Munich Airport">Munich Airport</option>
<option value="Chicago O'Hare">Chicago O'Hare</option>
<option value="Beijing Capital">Beijing Capital</option>
<option value="Singapore Changi">Singapore Changi</option>
<option value="Sydney Kingsford-Smith">Sydney Kingsford-Smith</option>

    </select>
</div>

<div class="inline">
    <label for="toPort">Arrival Port:</label>
    <select id="toPort" name="toPort" class="selectorMain">
        <option value="" disabled selected>Select Arrival Port</option>
<option value="Istanbul">Istanbul</option>
<option value="Amsterdam Schiphol">Amsterdam Schiphol</option>
<option value="London Heathrow">London Heathrow</option>
<option value="Hartsfield-Jackson Atlanta">Hartsfield-Jackson Atlanta</option>
<option value="Guangzhou Baiyun">Guangzhou Baiyun</option>
<option value="Charles de Gaulle">Charles de Gaulle</option>
<option value="Denver International">Denver International</option>
<option value="Dallas/Fort Worth">Dallas/Fort Worth</option>
<option value="Dubai International">Dubai International</option>
<option value="Frankfurt am Main">Frankfurt am Main</option>
<option value="Tokyo Haneda">Tokyo Haneda</option>
<option value="Incheon International">Incheon International</option>
<option value="John F. Kennedy International">John F. Kennedy International</option>
<option value="Los Angeles International">Los Angeles International</option>
<option value="Madrid Barajas">Madrid Barajas</option>
<option value="Munich Airport">Munich Airport</option>
<option value="Chicago O'Hare">Chicago O'Hare</option>
<option value="Beijing Capital">Beijing Capital</option>
<option value="Singapore Changi">Singapore Changi</option>
<option value="Sydney Kingsford-Smith">Sydney Kingsford-Smith</option>
    </select>
</div>

    <div>
        <label for="flightDate">Flight Date:</label>
        <input type="text" id="flightDate" name="flightDate" placeholder="Select Date" />
        <script>
            flatpickr("#flightDate", {});
        </script>
    </div>

    <div class="form-row">
        <div>
        <label for="adultCount" title="12+ years">Adult Count:</label>
            <select id="adultCount" name="adultCount" class="selectorMain">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
<div>
    <label for="childCount" title="2 - 12 years">Child Count:</label>
    <select id="childCount" name="childCount" class="selectorMain" >
        <option value="" disabled selected>0</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
    </select>
</div>

        <div>
            <label for="infantCount" title="0 - 2 years">Infant Count:</label>
            <select id="infantCount" name="infantCount" class="selectorMain">
            <option value="" disabled selected>0</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
        <div class="search-button">
            <input type="submit" value="Search" />
        </div>
    </div>
</form>


</body>
</html>
