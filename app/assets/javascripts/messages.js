var myMessages = [ 'error','success'];

function hideAllMessages() {

    var messagesHeights = new Array(); // В данном массиве хранится высота для каждого сообщения

    for (i = 0; i < myMessages.length; i++) {
        messagesHeights[i] = $('.' + myMessages[i]).outerHeight();
        $('.' + myMessages[i]).css('top', -messagesHeights[i]); //Выводим элемент из окна просмотра
    }
}

function showMessage(type) {
    if ( $('.error.message p').text() !==''){
        hideAllMessages();
        $('.' + type).animate({top: "0"}, 500);
    }else{

    }
    if ( $('.success.message h3').text() !==''){
        hideAllMessages();
        $('.' + type).animate({top: "0"}, 500);
    }else{

    }
}

ready = function () {

    $(document).ajaxSuccess(function(event, response, settings)  {

        console.log(response)

        if (response.responseJSON.stat == 'succ'){
            $('.success.message h3').remove();

//            if ( $('.success.message h3').text() !==''){

                $('.success.message').append('<h3>Your comment was successfuly created!</h3>');
                $('.success.message').animate({top: '0'}, 500);
//            }

        }
        console.log(response);
        if (response.responseJSON.stat == 'error') {

            $('.error.message').css({
                "top": "0px",
                "display": "none"
            })

            error = (response.responseJSON.comment_error);
            $('.error.message').text('')
            $('.error.message').append('<h3>You comment cant be saved</h3>');

            $.each( error, function( key, value ) {

                $('.error.message').append( key + ": " + value + "<br>");
                $('.error.message').css('display', 'block');
            });
            ;
        }

//        if (response.responseJSON.comment_error) {
//            error = (response.responseJSON.comment_error)
//            $('.error.message').append('<h3>You comment cant be saved</h3>');
//            $.each( error, function( key, value ) {
//                $('.error.message').css("display", "block");//
//                $('.error.message').append( key + ": " + value + "<br>");
//            });
//        }

    });

    hideAllMessages();  // Изначально скрываем все

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

    // Когда пользователь нажимает на сообщение, скрываем его
    $('.message').click(function(event){
        $(this).animate({top: -$(this).outerHeight()}, 500);
        $('.success.message h3').remove();
        $('.error.message h3').remove();
        $('.error.message h3').html('');
    });

    // Скрываем сообщение SUCCESS после 3.5 секунд
    if ( $('.message h3').text() !==''){
        setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
        setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
    }

}

//$(document).ready(ready)
$(document).on('page:load', ready);

