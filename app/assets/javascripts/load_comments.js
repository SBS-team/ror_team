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
            $('#all_comments').replaceWith("<div id = 'close_comments'>Hide all comments</div>");
            var comments = response.comments;
            var i = 0;
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
                        '   <small class = "comment_time">just now</small><hr></blockquote>');
                    i++;
                    });
            $('#close_comments').click(function(){
                console.log('vakavaka');
                var count = $('blockquote').length;
                console.log(count -= 3);
                var i = 0;
                while ( i <= count){
                    console.log(i);
                    $('#'+i+'').remove();
                    i++;
                }

            });
        }
    });
        //$('#all_comments').html('Close all comments');

        //$('.comments_block').append("<div id = 'close_comments'>Hide all comments</div>");
        //if ($('#all_comments').html() == 'Close all comments'){

    });


}); // document ready

//function HideComments(){
//    if ($('#close_comments')){
//        $('#close_comments').click(function(){
//            console.log('vakavaka');
//            $('.comments').remove();
//
//        });
//    }
//};