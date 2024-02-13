<%@page import="arup.entity.Post"%>
<%@page import="java.util.List"%>
<%@page import="arup.helper.ConnectionProvider"%>
<%@page import="arup.dao.AddPostDao"%>
<div class="row">

    <%
        AddPostDao po = new AddPostDao(ConnectionProvider.createConnection());
        List<Post> post = po.getAllPosts();
        for (Post posts : post) {
    %>

    <div class="col-md-6 mt-2">

        <div class="card">
            <img class="card-img-top" src="post_pic/<%=posts.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%=posts.getpTitle()%></b>
                <p><%=posts.getpContent()%></p>
                <code><%=posts.getpCode()%></code>

            </div>


        </div>

    </div>

    <%
        }

    %>


</div>