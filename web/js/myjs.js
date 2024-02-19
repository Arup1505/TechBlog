function doLike(pid, uid) {
    console.log(pid + "," + uid);
    const d = {
        pid: pid,
        uid: uid,
        operation: 'like'
    };
    $.ajax({

        url: "AddLike",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if (data.trim() === "true") {
                let c = $('.like-counter').html();
                c++;
                $('.like-counter').html(c);
                $('.like-btn').addClass('liked');
                $('.like-btn i').removeClass('fa-thumbs-o-up').addClass('fa-thumbs-up');
//                $('.like-btn').addClass('liked').html('LIKED'); // Change button text to "LIKED"
                $('.like-btn').prop('onclick', null).off('click'); // Disable the click event
            }
//            } else if (data.trim() === "already_liked") {
//                alert("You have already liked this post.");
//            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        }

    });
}