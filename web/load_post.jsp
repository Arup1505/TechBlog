<%@page import="arup.entity.Post"%>
<%@page import="java.util.List"%>
<%@page import="arup.helper.ConnectionProvider"%>
<%@page import="arup.dao.AddPostDao"%>
<div class="row">

    <%
        
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
            </div>
            <div class="card-footer">
                <a href="read_post.jsp?posts_id=<%= posts.getpId()%>" class="btn btn-outline-primary btn-sm">Read More...</a>
                <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-thumbs-o-up"></i><span>11</span></a>
                <a href="#" class="btn btn-outline-primary btn-sm"><i class="fa fa-commenting-o"></i><span>21</span></a>
            </div>


        </div>

    </div>

    <%
        }

    %>


</div>