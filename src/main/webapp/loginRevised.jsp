<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head >
    <meta charset="UTF-8">
    <title>crane</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="assets/new.css" />
    <link rel="icon" href="assets/webicon.ico">
    <style>
        <% 
        String loginResult = (String) request.getSession().getAttribute("loginResult");
        if (loginResult != null && loginResult.equals("Login Failed")) { %>
            .register {
                box-shadow: 0 0 250px red;
            }
        <% } else { %>
            .register {
                box-shadow: 0 0 250px black;
            }
        <% } %>
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
}
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            <% 
            if (loginResult != null && loginResult.equals("Login Failed")) { %>
                alert("Failed to Login");
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

            <form id="loginForm" action="LoginServlet" method="post" class="form">
                <div class="form__field">
                    <input type="text" name="mail" placeholder="info@mail.com" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="password" name="password" placeholder="***********" onfocus="clearPlaceholder(this)" onblur="restorePlaceholder(this)">
                </div>
                <div class="form__field">
                    <input type="submit" value="Log In" class="submit-button">
                </div>
            </form>
            <p>Don't have an account? <a href="signUp.jsp">Sign Up</a></p>
<% 
String signupResult = (String) request.getSession().getAttribute("signupResult");
if (signupResult != null) { %>
    <script>
        window.addEventListener('DOMContentLoaded', (event) => {
            alert("<%= signupResult %>");
        });
    </script>
<% } %>
            <% 
            request.getSession().removeAttribute("loginResult");
            %>
        </div>
    </div>
</body>
</html>
