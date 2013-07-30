$(document).ready(function(){

    $('#all_comments').on('click', function(){
        id = $('.img img').attr('class')

    $.ajax({
        url: '/comment_load',
        data:
          {id: id},
        type: 'post',
        dataType:'json',
        success: function(response){
            $('#all_comments').replaceWith("<div id = 'close_comments'>Hide all comments</div>");
            var comments = response.comments;
            var i = 0;
            $('.comments').slideDown(500, function(){
                $.each( comments, function( key, value ) {
                    $('.comments').prepend('' +
                        '<blockquote id = '+i+'>' +
                        '   <a><span class = "icon-remove"></span></a>' +
                        '   <a><span class = "icon-pencil"></span></a>' +
                        '   <b>' +
                        '   <img src = ' +value.user.image+ ' class = "img-rounded comment_img" width = "50" height = "50">' +
                        '   <span class = "comment_nick"> '+value.user.nickname+' </span></b>' +
                        '   <small class = "comment_email"> '+value.user.email+'</small><br>' +
                        '   <span class = "comment_description">'+value.comment.description+'</span><br>' +
                        '   <small class = "comment_time">'+value.time_ago+' ago</small><hr></blockquote>');
                i++;
                });

            });
            $('#close_comments').click(function(){
                var count = $('blockquote').length;
                var i = 0;
                while ( i <= count){
                    $('#'+i+'').slideToggle(500, function(){
                          $(this).remove();
                    });
                    i++;
                }

                $('#close_comments').replaceWith("<div id = 'all_comments'>Look previous comments</div>");

            });
        }
    });

    });


}); // document ready
