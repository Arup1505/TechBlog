<%@page import="arup.entity.Post"%>
<%@page import="java.util.List"%>
<%@page import="arup.helper.ConnectionProvider"%>
<%@page import="arup.dao.AddPostDao"%>
<div class="row">

    <%
        Thread.sleep(1200);
        AddPostDao po = new AddPostDao(ConnectionProvider.createConnection());
        int cid=Integer.parseInt(request.getParameter("cid"));
        List<Post> post = null;
        if (cid==0) {
        post = po.getAllPosts();
        }
        else{
        post=po.getPostByCategories(cid);
        }
        if (post.isEmpty()) {
                out.println("<h3 class='display-3 text-center'>Sorry no posts yet!</h3>");
                return;
            }
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