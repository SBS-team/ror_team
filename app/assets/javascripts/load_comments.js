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
    var comment, nickname, email, image

    $(document).ajaxSuccess(function(event, response, settings)  {

        if (response.responseJSON.stat == 'succ'){

            if ($('.error_messages')){
                $('#comment_description').css('box-shadow', 'none');
                $('.error_messages').remove();
            }

            if (response.responseJSON.comment)
            {
                // Init variables and add new comment
                comment = response.responseJSON.comment.description;
                nickname = response.responseJSON.nickname;
                email = response.responseJSON.email;
                image = response.responseJSON.image;
                time = response.responseJSON.created_at;
                console.log(comment.id);
                $('.comments').append('<blockquote style ="display:none;">' +
                    '<span class = "comment_description">'+comment+'</span><br>' +
                    '<hr></blockquote>');
                $('.comments blockquote').slideDown('slow');
            }

            $('#comment_description').val('');
        }

        if (response.responseJSON.stat == 'error') {
            error = (response.responseJSON.error);
            $('#comment_description').css('box-shadow', '0 0 5px red');
            $.each( error, function( key, value ) {
                $('#comment_description').parent().append('<span class = "error_messages"><b>'+value+'</b></span><br>');
            });

        }
    });



}); // document ready