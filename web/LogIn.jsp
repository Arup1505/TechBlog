<%-- 
    Document   : LogIn
    Created on : 30-Jan-2024, 7:00:25 pm
    Author     : arupb
--%>

<%@page import="arup.entity.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background {
                clip-path: polygon(64% 3%, 83% 0, 100% 0, 100% 93%, 80% 90%, 50% 100%, 20% 90%, 0 100%, 0 16%, 31% 16%);
            }
        </style>
    </head>
    <body>
        <%@include file="index_navbar.jsp" %>

        <main class="d-flex align-items-center primary-background banner-background" style="height:70vh ">
            <div class=container>
                <div class="row">
                    <div class="col-md-4 offset-md-4">

                        <div class="card">

                            <div class="card-header text-dark text-center" style="background:#18ffff">
                                <span class="fa fa-user-circle-o fa-3x"></span>
                                <p>Log In here</p>

                            </div>
                            <div class="text-center p-3">
                            <%
                                Message ms = (Message)session.getAttribute("msg");
                                if (ms != null) {
                            %>
                            <div class="<%= ms.getCssClass() %>" role="alert">
                                <%= ms.getContent() %>
                            </div> 
                            <%  
                                session.removeAttribute("msg");}

                            %>
                            </div>

                            <div class="card-body">

                                <form action="LogInServlet" method="post">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label> <input
                                            name="email" required  type="email" class="form-control" id="exampleInputEmail1"
                                            aria-describedby="emailHelp" placeholder="Enter email">
                                        <small id="emailHelp" class="form-text text-muted">We'll
                                            never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label> <input
                                            name="password" required type="password" class="form-control"
                                            id="exampleInputPassword1" placeholder="Password">
                                    </div>

                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-primary">LogIn</button>
                                    </div>
                                </form>

                            </div> <!-- card-body -->

                        </div>

                    </div>

                </div>
            </div>

        </main>

        <!-- javaScript -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
                integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    </body>
</html>
