<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>crane</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="assets/new.css" />
<link rel="icon" href="assets/webicon.ico">
<style>
        .submit-button {
    display: block;
    margin-top: 20px;
    margin-left: 130px;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    background-color: rgb(255, 255, 255);
    color: black;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease; 
}

.submit-button:hover {
    background-color: rgb(128, 128, 128); 
}</style>
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
<body class="align">
    <div class="grid align__item">
        <div class="register">
            <svg xmlns="http://www.w3.org/2000/svg" class="site__logo" width="300" height="100">
                <defs>
                    <linearGradient id="a" x1="0%" y1="0%" y2="0%">
                        <stop offset="0%" stop-color="#8ceabb"/>
                        <stop offset="100%" stop-color="#378f7b"/>
                    </linearGradient>
                </defs>
                <image xlink:href="assets/crane.png" width="100%" height="100%" preserveAspectRatio="xMidYMid meet" />
            </svg>

            <form id="loginForm" action="SignupServlet" method="post" class="form">
                <div class="form__field">
                    <input type="text" name="name" placeholder="Name" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="text" name="surname" placeholder="Surname" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="email" name="email" placeholder="Email" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="text" name="phoneNumber" placeholder="Phone Number" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="password" name="password" placeholder="Password" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="submit" value="Sign Up" class="submit-button">
                </div>
            </form>
            <p>Already have an account? <a href="loginRevised.jsp">Login</a></p>

            <% 
            request.getSession().removeAttribute("signupResult");

            %>
        </div>
    </div>
</body>
</html>
