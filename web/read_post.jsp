<%@page import="arup.entity.Comments"%>
<%@page import="arup.dao.CommentDao"%>
<%@page import="arup.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="arup.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="arup.entity.Categories"%>
<%@page import="arup.entity.Post"%>
<%@page import="arup.helper.ConnectionProvider"%>
<%@page import="arup.dao.AddPostDao"%>
<%@page errorPage="error_page.jsp" %>
<%@page import="arup.entity.Users"%>
<%
    Users user = (Users) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("LogIn.jsp");
    }
    int pid = Integer.parseInt(request.getParameter("posts_id"));
    AddPostDao addpost = new AddPostDao(ConnectionProvider.createConnection());
    Post p = addpost.getPostsByPostId(pid);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%></title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(64% 3%, 83% 0, 100% 0, 100% 93%, 80% 90%, 50% 100%, 20% 90%, 0 100%, 0 16%, 31% 16%);
            }
        </style>
        <style>
            body{
                background: url(images/abstract-background-278.jpg);
                background-size: cover;
                background-attachment: fixed;
            }

        </style>
        <link rel="stylesheet" href="css/mystyle.css"/>
    </head>
    <body>

        <!--navbar-->

        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-braille"></span> ENGINEERING BLOG</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#"><span class="fa fa-flash"></span> Get's Started <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-users"></span> Contact</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-hand-o-down"></span> JAVA Tutorial
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Core java</a>
                            <a class="dropdown-item" href="#">JDBC</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Advanced java</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="#"><span class="fa fa-reorder"></span> More</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-plus"></span> Create Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a href="#!" class="nav-link disabled" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link disabled" href="LogOutServlet"><span class="fa fa-user-plus"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>

        <!--end of navbar-->

        <!--main content of the page-->

        <div class="container">
            <div class="row my-4">

                <div class="col-md-8 offset-md-2">

                    <div class="card" style="">

                        <div class="card-header text-center primary-background text-white">
                            <h3><u><%= p.getpTitle()%></u></h3>

                        </div>
                        <div class="card-body">
                            <img class="card-img-top" src="post_pic/<%=p.getpPic()%>" alt="Card image cap" height="400">

                            <div class="row my-3" style="border: 1px solid brown; padding: 2px ; font-size: 20px">
                                <div class="col-md-6">
                                    <%
                                        UserDao ud = new UserDao(ConnectionProvider.createConnection());
                                    %>
                                    <p>Posted by: <a href="#"><%= ud.getPostByUserIdDetils(p.getUser_id()).getName()%></a></p>
                                </div>
                                <div class="col-md-6">
                                    <p>Posted on:<%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>

                            <b> <%=p.getpContent()%></b>
                            <br><!-- comment -->
                            <br>
                            <div style="background: cornsilk;font-size: 25px;font-family: sans-serif">
                                <code><%= p.getpCode()%></code>
                            </div>

                            <div class="card-footer">

                                <% LikeDao ld = new LikeDao(ConnectionProvider.createConnection()); %>
                                
                                <a href="#" onclick="doLike(<%= p.getpId()%>,<%= user.getId()%>)" class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ld.countLikes(p.getpId()) %></span></a>
                                <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>21</span></a>

                                <form action="AddComment" id="comment-form">
                                    <textarea class="form-control mt-2" placeholder="Enter your comment here" rows="1" cols="8" name="comment"></textarea>
                                    <input type="hidden" name="pid" value="<%= p.getpId()%>">
                                    <input type="hidden" name="uid" value="<%= user.getId()%>">
                                    <button type="submit" class="btn btn-warning mt-1"><i class="fa fa-commenting-o"></i></button>
                                </form>

                            </div>
                            <div class="card-footer">

                                <h4>Comments...</h4>

                                <%
                                    CommentDao commentDao = new CommentDao(ConnectionProvider.createConnection());
                                    ArrayList<Comments> comm = commentDao.getAllComments(p.getpId());
                                    UserDao cdao = new UserDao(ConnectionProvider.createConnection());
                                    
                                    for (Comments comments : comm) {
                                    Users cuser = cdao.getPostByUserIdDetils(comments.getIdusers());
                                %>
                                <div id="comments-section">
                                    <div class="container" style="border: 1px solid gold">
                                        <h5><%= cuser.getName() %></h5>
                                        <p><%= comments.getcContent()%></p>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>

                    </div>

                </div> 
                <!--end of row-->


            </div>

            <!--end of main content of the page-->

            <!--Start mdal-->
            <!-- Button trigger modal -->


            <!-- Modal -->
            <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header primary-background text-white">
                            <h5 class="modal-title" id="exampleModalLabel">Engineering Blog</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="container text-center">
                                <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 80%;max-width: 140px">

                                <h5 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%></h5>
                                <!--profile in table-->
                                <div id="profile-table">
                                    <table class="table table-striped">

                                        <tbody>
                                            <tr>
                                                <th scope="row">ID</th>
                                                <td><%= user.getId()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">EMAIL</th>
                                                <td><%=user.getEmail()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">GENDER</th>
                                                <td><%=user.getGender()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">ABOUT</th>
                                                <td><%=user.getAbout()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">JOIN DATE</th>
                                                <td><%=user.getDateTimestamp().toString()%></td>

                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div id="profile-edit" style="display: none">
                                    <h3 class="mt-3">Edit details below</h3>
                                    <form action="EditServlet" method="post" enctype="multipart/form-data">
                                        <table class="table">
                                            <tr>
                                                <td>ID</td>
                                                <td><%= user.getId()%></td>
                                            </tr>
                                            <tr>
                                                <td>Email</td>
                                                <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail()%>" </td>
                                            </tr>
                                            <tr>
                                                <td>Name</td>
                                                <td><input type="text" name="user_name" class="form-control" value="<%= user.getName()%>" </td>
                                            </tr>
                                            <tr>
                                                <td>Password</td>
                                                <td><input type="password" name="user_pass" class="form-control" value="<%= user.getPassword()%>" </td>
                                            </tr>
                                            <tr>
                                                <td>Gender</td>
                                                <td><%= user.getGender().toUpperCase()%></td>
                                            </tr>
                                            <tr>
                                                <td>About</td>
                                                <td>
                                                    <textarea name="about" class="form-control" rows="3"><%= user.getAbout()%></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>New Pic:</td>
                                                <td>
                                                    <input type="file" name="image" class="form-control">
                                                </td>
                                            </tr>

                                        </table>
                                        <div class="container">
                                            <button type="submit" class="btn btn-outline-primary">SAVE</button>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button id="profile-edit-button" type="button" class="btn btn-primary">EDIT</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--End of modal-->

            <!--add post modal-->

            <!-- Modal -->
            <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Create your post here</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!--modal for add post-->

                        <div class="modal-body">
                            <form action="AddPostServlet" method="post" id="add-post">
                                <div class="form-group">
                                    <select class="form-control" name="cat_id">
                                        <option selected disabled>Select category</option>
                                        <%
                                            AddPostDao ad = new AddPostDao(ConnectionProvider.createConnection());
                                            ArrayList<Categories> c = ad.getAllCategorieses();
                                            for (Categories ca : c) {
                                        %>
                                        <option value="<%= ca.getCatId()%>"><%= ca.getcName()%></option>
                                        <%}%>
                                    </select>

                                </div>
                                <div class="form-group">
                                    <input type="text" name="pTitle" class="form-control" placeholder="Enter yout post title">
                                </div>

                                <div class="form-group">
                                    <textarea class="form-control" name="pContent" placeholder="Enter your content here"></textarea>
                                </div>

                                <div class="form-group">
                                    <textarea class="form-control" name="pCode" placeholder="Enter your code if any"></textarea>
                                </div>

                                <div class="form-group">
                                    <label>Choose your picture</label>
                                    <br> 
                                    <input type="file" name="pPic">
                                </div>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-outline-primary">POST</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--end of post modal-->


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
            <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
            <script src="js/myjs.js"></script>
            <script>
                                    $(document).ready(function () {
                                        let editStatus = false;
                                        $('#profile-edit-button').click(function () {

                                            if (editStatus == false) {
                                                $('#profile-table').hide();
                                                $('#profile-edit').show();
                                                editStatus = true;
                                                $(this).text("BACK")
                                            } else {
                                                $('#profile-table').show();
                                                $('#profile-edit').hide();
                                                editStatus = false;
                                                $(this).text("EDIT")
                                            }

                                        });
                                    })
            </script>

            <script>
                $(document).ready(function (e) {

                    //get your form
                    $("#add-post").on("submit", function (event) {
                        event.preventDefault();
                        console.log("submitted");
                        //getting form data
                        let f = new FormData(this);

                        //calling ajax
                        $.ajax({
                            url: "AddPostServlet",
                            type: 'POST',
                            data: f,
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                //                            succss
                                if (data.trim() == 'Done') {
                                    swal("SAVED!", "your post has been recordeed", "success");
                                } else {
                                    swal("Error!", "Sorry Something went Wrong!", "error");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //error code
                                swal("Error!", "Sorry Something went Wrong!", "error");
                            },
                            processData: false,
                            contentType: false
                        })

                    })
                });
            </script>

            <!--add comment ajax-->
            <script>
                $(document).ready(function () {

                    console.log("page ready");

                    $("#comment-form").on('submit', function (event) {
                        event.preventDefault();
                        var f = $(this).serialize();
                        console.log(f);

                        $.ajax({
                            url: "AddComment",
                            data: f,
                            type: 'POST',
                            success: function (data, textStatus, jqXHR) {
                                console.log(data);
                                $("#comments-section").append("<div class='container' style='border: 1px solid gold'><p>" + data + "</p></div>");
                                $("#comment-form textarea").val("");
                                window.location.reload();
                            },
                            error: function (jqXHR, textStatus, errorThrown) {

                            }

                        })
                    })
                })
            </script>



    </body>
</html>
