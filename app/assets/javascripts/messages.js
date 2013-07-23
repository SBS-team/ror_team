var myMessages = [ 'error','success'];

function messageTimeOut() {
    // Скрываем сообщение SUCCESS после 3.5 секунд
    setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
    setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
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

    $(document).ajaxSuccess(function(event, response, settings)  {

        // если коммент добавило, выведем попапчик
        if (response.responseJSON.stat == 'succ'){
            $('body').prepend('<div class = "success message"></div>');
            // Вот это дерьмо снизу должно добавить новый созданный коммент
            $('.success.message').append('<h3>Your comment was successfuly created!</h3>');
            $('.success.message').animate({top: '0'}, 500);
            if (response.responseJSON.comment)
            {
                // init variables to paste in new comment block
                var comment = response.responseJSON.comment.description;
                var nickname = response.responseJSON.nickname;
                var email = response.responseJSON.email;
                var image = response.responseJSON.image;
                $('.comments').append('<blockquote><b><img src = ' +image+ ' class = "img-rounded"><span>'+nickname+'</span></b><br><small>'+email+'<br></small><b>'+comment+'</b></blockquote>');
            }
            messageTimeOut();
        }

        console.log(response);
        if (response.responseJSON.stat == 'error') {
            $('body').prepend('<div class = "error message"></div>');
            error = (response.responseJSON.comment_error);
            $('.error.message').append('<h3>You comment cant be saved</h3>');
            $.each( error, function( key, value ) {
                $('.error.message').append( key + ": " + value + "<br>");
                $('.error.message').css('display', 'block');
                $('.error.message').animate({top: '0'}, 500);
            });
        }
    });

    hideAllMessages();  // Изначально скрываем все

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

    // Когда пользователь нажимает на сообщение, скрываем его и очищаем содержимое блока
    $('body').on("click", '.message', function(){
        $(this).animate({top: -$(this).outerHeight()}, 500,function(){
            $('.error.message ').html('');
            $('.success.message ').remove();
        });

    });


}); // document ready


