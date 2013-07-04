//= require active_admin/base


 $(document).ready(function(){

     $("#post_description").focus(function() {
         $(this).after("<span class='maxsymbolsbody'>*max symbols - 500</span>");
         $(".maxsymbolsbody").css('color','blue').fadeIn(800).delay(800).fadeOut(800);
     });
     $("#post_description").focusout(function() {
         $(this).after("<span class='maxsymbolsbody'>*max symbols - 500</span>");
         $(".current_symbols").hide();
     });
     $("#post_description").keyup(function() {
         $('.current_symbols').remove();
         $(".maxsymbolsbody").hide();
         $(".current_symbols").css('color','blue').fadeIn(800);
         $(this).after("<span class='current_symbols'></span>");
         $('.current_symbols').text("current quantity :"+$(this).val().length);

     });


 })
