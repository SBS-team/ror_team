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
                var str;
                var i = 0;
                $('.comments').slideDown(500, function(){
                    $.each( comments, function( key, value ) {
                          str = HtmlEncode(comments[key].description);
                          $('.comments').prepend('<blockquote style ="display:none;" id = '+i+'>' +
                              '<b><span class ="comment_nickname text-primary">'+comments[key].nickname+'</span></b><br>' +
                              '<span class = "comment_description">'+str+'</span><br>' +
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

    $("#go_comment").click(function() {
        return $("#new_comment").validate({
            rules: {
                "comment[nickname]": {
                    required: true,
                    maxlength: 40,
                    minlength: 2
                },
                "comment[description]": {
                    required: true,
                    maxlength: 2048,
                    minlength: 2
                }
            }
        });
    });


    //CREATE NEW COMMENT
    var comment, nickname

    $(document).ajaxSuccess(function(event, response, settings)  {

        if (response.responseJSON.stat == 'success'){
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

    });

}); // document ready

function HtmlEncode(val){
    return $("<div/>").text(val).html();
}

function HtmlDecode(val){
    return $("<div/>").html(val).text();
}
