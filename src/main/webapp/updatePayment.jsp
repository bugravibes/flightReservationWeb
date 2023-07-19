<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.helper.updatePayment" %>

<%
    String PNR = request.getParameter("PNR");
    updatePayment.cancelPayment(PNR);
%>
