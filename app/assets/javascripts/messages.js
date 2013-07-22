var myMessages = [ 'error','success'];

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

ready = function () {

    // костыль - скрыть выпавший эррор блок
//    $('.error.message').css("display", "none");

    $(document).ajaxSuccess(function(event, response, settings)  {

        // if (response.responseJSON.comment_error){
        // если коммент добавило, выведем попапчик
        if (response.responseJSON.stat == 'succ'){
            // Вот это дерьмо снизу должно добавить новый созданный коммент
            $('.comments').append("<blockquote><b><img src = '#{escape_javascript @comment.commentable.image}' class = 'img-rounded'><span>#{escape_javascript @comment.commentable.nickname}</span></b><br><small>#{escape_javascript @comment.commentable.email}<br></small><b>#{escape_javascript @comment.description}</b></blockquote>");

            $('.success.message').append('<h3>Your comment was successfuly created!</h3>');
            $('.success.message').animate({top: '0'}, 500);

        }

        console.log(response);

        if (response.responseJSON.stat == 'error') {

            $('body').prepend('<div class = "error message"></div>');
            error = (response.responseJSON.comment_error);
//            $('.error.message').text('')
            $('.error.message').append('<h3>You comment cant be saved</h3>');

            $.each( error, function( key, value ) {

                $('.error.message').append( key + ": " + value + "<br>");
                $('.error.message').css('display', 'block');
                $('.error.message').animate({top: '0'}, 500);
            });
        }

       // }

    });

    hideAllMessages();  // Изначально скрываем все

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

    // Когда пользователь нажимает на сообщение, скрываем его и очищаем содержимое блока
    $('body').on("click", '.message', function(){
        console.log('123');
        $(this).animate({top: -$(this).outerHeight()}, 500,function(){
            $('.error.message ').html('');
            $('.success.message ').html('');
        });

    });

    // Скрываем сообщение SUCCESS после 3.5 секунд
    if ( $('.message h3').text() !==''){
        setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
        setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
//        $('.error.message ').html('');
//        $('.success.message ').html('');
    }

}

//$(document).ready(ready)

//$(document).on('page:load', ready2)


