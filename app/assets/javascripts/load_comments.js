$(document).ready(function(){

    $('#all_comments').click(function(){
        id = $('.img img').attr('class')

    $.ajax({
        url: '/comment_load',
        data:
          {id: id},
        type: 'post',
        dataType:'json',
        success: function(response){
            var comments = response.comments;
                $.each( comments, function( key, value ) {
                    $('.comments').append('' +
                        '<blockquote>' +
                        '   <a><span class = "icon-remove"></span></a>' +
                        '   <a><span class = "icon-pencil"></span></a>' +
                        '   <b>' +
                        '   <img src = ' +value.user.image+ ' class = "img-rounded comment_img" width = "50" height = "50">' +
                        '   <span class = "comment_nick"> '+value.user.nickname+' </span></b>' +
                        '   <small class = "comment_email"> '+value.user.email+'</small><br>' +
                        '   <span class = "comment_description">'+value.comment.description+'</span><br>' +
                        '   <small class = "comment_time">just now</small><hr></blockquote>');

               });
            }

    });
    });

}); // document ready