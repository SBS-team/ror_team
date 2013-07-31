$(document).ready(function(){
    $('#close_comments').hide();

    $('#all_comments').on('click', function(){
        id = $('.img img').attr('class')

    $.ajax({
        url: '/comment_load',
        data:
          {id: id},
        type: 'post',
        dataType:'json',
        success: function(response){
            $('#all_comments').hide();
            $('#close_comments').show();
            var comments = response.comments;
            var i = 0;
            $('.comments').slideDown(500, function(){
                $.each( comments, function( key, value ) {
                    $('.comments').prepend('' +
                        '<blockquote style ="display:none;" id = '+i+'>' +
                        '   <b>' +
                        '   <img src = ' +value.user.image+ ' class = "img-rounded comment_img" width = "50" height = "50">' +
                        '   <span class = "comment_nick"> '+value.user.nickname+' </span></b>' +
                        '   <small class = "comment_email"> '+value.user.email+'</small><br>' +
                        '   <span class = "comment_description">'+value.comment.description+'</span><br>' +
                        '   <small class = "comment_time">'+value.time_ago+' ago</small><hr></blockquote>');
                $('.comments blockquote').slideDown('slow');
                i++;
                });

            });
            $('#close_comments').on('click', function(){
                var count = $('blockquote').length;
                var i = 0;
                while ( i <= count){
                    $('#'+i+'').slideToggle(500, function(){
                          $(this).remove();
                    });
                    i++;
                }

                $('#all_comments').show();
                $('#close_comments').hide();

            });
        }
    });

    });


}); // document ready