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

$(document).ready(function () {

    hideAllMessages();  // Изначально скрываем все

    for(var i = 0; i < myMessages.length; i++)
    {
        showMessage(myMessages[i]);
    }

   // Когда пользователь нажимает на сообщение, скрываем его
    $('.message').click(function(event){

        $(this).animate({top: -$(this).outerHeight()}, 500);
    });

    // Скрываем сообщение SUCCESS после 3.5 секунд
    if ( $('.message h3').text() !==''){
        setTimeout('$(".success.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
        setTimeout('$(".info.message").animate({top: -$(this).outerHeight()}, 500)', 3500)
    }

});

