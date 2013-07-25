var myMessages = [ 'error','success'];

function messageTimeOut() {
    // Это для блоков генерируеммых .append
    // Скрываем сообщение SUCCESS после 3.5 секунд
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

    var messagesHeights = new Array(); // В данном массиве хранится высота для каждого сообщения

    for (i = 0; i < myMessages.length; i++) {
        messagesHeights[i] = $('.' + myMessages[i]).outerHeight();
        $('.' + myMessages[i]).css('top', -messagesHeights[i]); //Выводим элемент из окна просмотра
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

        // если коммент добавило, выведем попапчик
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
            if ($('.error.message')){
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

    hideAllMessages();  // Изначально скрываем все

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

    // Скрываем сообщение SUCCESS после 3.5 секунд
    // Это для блоков написаных в верстке
    setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500);
    setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500);

    // Когда пользователь нажимает на сообщение, скрываем его и очищаем содержимое блока
    $('body').on("click", '.message', function(){
        $(this).animate({top: -$(this).outerHeight()}, 500,function(){
            $('.error.message ').remove();
            $('.success.message ').remove();
        });

    });


}); // document ready
