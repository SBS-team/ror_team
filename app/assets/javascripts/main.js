jQuery(document).ready(function(){

    windov_height = document.documentElement.clientHeight;
    console.log(windov_height);

    jQuery('.welcome_l-1').css("minHeight", windov_height);
    jQuery('.welcome_l-2').css("minHeight", windov_height);
    jQuery('.welcome_l-3').css("minHeight", windov_height);

    jQuery('.Contacts_l-1').css("minHeight", windov_height);
    jQuery('.Contacts_l-2').css("minHeight", windov_height);
    jQuery('.Contacts_l-3').css("minHeight", windov_height);

    jQuery('#team').css("minHeight", windov_height);

    jQuery('#Portfolio').css("minHeight", windov_height);
    jQuery('#why_sbs').css("minHeight", windov_height);

    skrollr.init({
        forceHeight: false
    });

//    navigation
    jQuery("#nav a").click(function(e){
        var container;
        var destination;
        if(jQuery.browser.webkit){
            container = 'body';
        } else {
            container = 'html';
        }
        if(jQuery(this).attr("data-rel") == "Welcome"){
            destination = 0;
        } else{
            elementClick = jQuery('#'+jQuery(this).attr("data-rel"));
            destination = jQuery(elementClick).offset().top;
        }

        jQuery(container).animate({ scrollTop: destination}, 1500 );
        return false;
    })
    var offset;
    jQuery('#What_we_do .content_area .row').each(function(e){
        offset = jQuery(this).offset();
        jQuery(this).attr('data-height',offset.top);
    });

//    jQuery(window).scroll(function() {
//        scrollTop = (jQuery(document).scrollTop());
//        scrollTopPL = (jQuery(document).scrollTop()) + windov_height;
//        jQuery('.content_area .row').each(function(e){
//            if(jQuery(this).attr("data-height") < scrollTopPL - 140){
//                jQuery(this).css("opacity","1");
//            };
//            if(jQuery(this).attr("data-height") < scrollTop + 140){
//                jQuery(this).css("opacity","0.1");
//            };
//            if(jQuery(this).attr("data-height") > scrollTopPL - 140){
//                jQuery(this).css("opacity","0.1");
//            };
//
//        });
//
//
//    });

// Open modal on AJAX callback
    jQuery('.manual-ajax').click(function(event) {
        event.preventDefault();
        jQuery.get(this.href, function(html) {
//          add fixBody class for remove scroll
            jQuery("body").addClass("fixBody");
        });
    });

//  Validation of resume form fields
    jQuery(document).on ('click', '#new_resume .check_errors', function() {
      return jQuery("#new_resume").validate({
        rules: {
          "resume[email]": {
            required: true,
            email: true
          },
          "resume[name]": {
            required: true,
            maxlength: 30,
            minlength: 4
          },
          "resume[phone]": {
            required: true,
            digits: true,
            maxlength: 31
          },
          "resume[description]": {
            required: true,
            minlength: 2,
            maxlength: 3000
          },
          "recaptcha_response_field": {
            required: true
          }
        },
        messages: {
          "recaptcha_response_field": {
            required: "Captcha is required"
          }
        },
        errorPlacement: function(error, element) {
          if (element.attr('name') === 'recaptcha_response_field') {
            return error.insertAfter('#recaptcha_area');
          } else {
            return error.insertAfter(element);
          }
        }
      });
    });

//    function on modal close
    jQuery(document).on('modal:close', function(){
//      add fixBody class for remove scroll
        jQuery("body").removeClass("fixBody");
    });

    jQuery('.send_resume').click(function(event) {
        event.preventDefault();
        jQuery.get(this.href, function(html) {
//            add fixBody class for remove scroll
              jQuery("body").addClass("fixBody");
        });
    });

    jQuery('.close_send_resume').on('click', function(e) {
        e.preventDefault();
        jQuery("body").removeClass("fixBody");
    });

    var data_new;
    var new_span;

    jQuery(document).on('ajax:error', 'form#new_resume', function(data, status, xhr) {
        jQuery('.user_resume_errors').remove();
        data_new = jQuery.parseJSON(status.responseText);
        new_span = '';
        jQuery.each(data_new.errors, function(key, value) {
          return new_span += "<li>" + value + "</li>";
        });
        jQuery('#send_new_resume').prepend("<ul class='user_resume_errors'>" + new_span + "</ul>");
        Recaptcha.reload();
    });

});