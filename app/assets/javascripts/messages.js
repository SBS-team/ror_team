var myMessages = [ 'error','success'];

function messageTimeOut() {
    // this is for block generic by .append
    // Hide this message SUCCESS after 3.5 sec
    setTimeout($(".success.message").delay(2000).animate({top: -$(this).outerHeight()}, {
            duration: 2500,
            specialEasing: {
                width: 'linear',
                height: 'easeOutBounce'
            },
            complete: function() {
               $('.success.message').delay(1000).remove();
            }
    }), 3500);

    setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500);
}

function hideAllMessages() {

    var messagesHeights = new Array(); // In this array store height for message

    for (i = 0; i < myMessages.length; i++) {
        messagesHeights[i] = $('.' + myMessages[i]).outerHeight();
        $('.' + myMessages[i]).css('top', -messagesHeights[i]);
    }
}

function showMessage(type) {
    hideAllMessages();
    $('.' + type).animate({top: "0"}, 500);
}

$(document).ready(function(){
    // init variables to paste in new comment block
    var comment, nickname, email, image

    $(document).ajaxSuccess(function(event, response, settings)  {

        // if comment created, popup block
        if (response.responseJSON.stat == 'succ'){
            if ($('.error.message').length > 0)
            {
                $('.error.message').animate({top: -$(this).outerHeight()}, 500,function(){
                $('.error.message ').remove();
            })};

            $('body').prepend('<div class = "success message"></div>');

            $('.success.message').append('<h3>Your comment was successfuly created!</h3>');
            $('.success.message').css({'top': '-100px'});
            $('.success.message').animate({'top': '0'}, 500);
            if (response.responseJSON.comment)
            {
                // Init variables and add new comment
                comment = response.responseJSON.comment.description;
                nickname = response.responseJSON.nickname;
                email = response.responseJSON.email;
                image = response.responseJSON.image
                $('.comments').append('<blockquote><b><img src = ' +image+ ' class = "img-rounded" width = "50" height = "50"><span>'+nickname+'</span></b><br><small>'+email+'<br></small><b>'+comment+'</b></blockquote>');
            }
            $('#comment_description').val('');
            messageTimeOut();
        }

        if (response.responseJSON.stat == 'error') {
            error = (response.responseJSON.comment_error);
            // if alredy isset error block, then if invalid again delete old block and add new one
            if ($('.error.message')){
                $('.error.message').remove();
                $('body').prepend('<div class = "error message"></div>');
            }
            else{

                $('body').prepend('<div class = "error message"></div>');
            }
            $('.error.message').html('<h3>You comment cant be saved</h3>');
            $.each( error, function( key, value ) {
                $('.error.message').append( key + ": " + value + "<br>");
            });
            $('.error.message').css({"display": "block", "top": "-100px"});
            $('.error.message').animate({top: '0'}, 500);
        }
    });

    hideAllMessages();  // before Hide all

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

    // Hide message SUCCESS after 3.5 секунд
    // This is for blocks entered in html
    setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500);
    setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500);

    // Then user click on a message, hide him and remove block
    $('body').on("click", '.message', function(){
        $(this).animate({top: -$(this).outerHeight()}, 500,function(){
            $('.error.message ').remove();
            $('.success.message ').remove();
        });

    });


}); // document ready
