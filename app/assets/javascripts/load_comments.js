$(document).ready(function(){
    // LOAD COMMENTS
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
                      $('.comments').prepend('<blockquote style ="display:none;" id = '+i+'>' +
                          '<b><span class ="comment_nickname text-primary">'+comments[key].nickname+'</span></b><br>' +
                          '<span class = "comment_description">'+comments[key].description+'</span><br>' +
                          '<hr></blockquote>');
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

    //CREATE NEW COMMENT
    var comment, nickname

    $(document).ajaxSuccess(function(event, response, settings)  {

        if (response.responseJSON.stat == 'succ'){
            // IF BEFORE WE GOT INVALID ERRORS CLEAN THEM BEFORE
            if ($('.error_messages')){
                $('#comment_description').css('box-shadow', 'none');
                $('#comment_nickname').css('box-shadow', 'none');
                $('.error_messages').remove();
            }

            if (response.responseJSON.comment)
            {
                // Init variables and add new comment
                comment = HtmlEncode(response.responseJSON.comment.description);
                nickname = response.responseJSON.comment.nickname;
                $('.comments').append('<blockquote style ="display:none;">' +
                    '<b><span class ="comment_nickname text-primary">'+nickname+'</span></b><br>' +
                    '<span class = "comment_description">'+comment+'</span><br>' +
                    '<small class = "comment_time">just now</small>' +
                    '<hr></blockquote>');
                $('.comments blockquote').slideDown('slow');
            }

            $('#comment_description').val('');
        }
        // IF AJAX QUERY WAS FAILED SHOW VALID ERRORS
        if (response.responseJSON.stat == 'error') {
            if (response.responseJSON.error.name){
                var name_error = response.responseJSON.error.name;
                $('#comment_nickname').parent().append('<span class = "error_messages"><b>'+name_error+'</b></span><br>');
                $('#comment_nickname').css('box-shadow', '0 0 5px red');
            }
            if (response.responseJSON.error.comment){
                var comment_error = (response.responseJSON.error.comment);
                $('#comment_description').css('box-shadow', '0 0 5px red');
                $('#comment_description').parent().append('<span class = "error_messages"><b>'+comment_error+'</b></span><br>');
            }
        }
    });

}); // document ready

function HtmlEncode(val){
    return $("<div/>").text(val).html();
}

function HtmlDecode(val){
    return $("<div/>").html(val).text();
}
