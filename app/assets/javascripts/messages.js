    // When we delete comment
    var target;
    var link;
    $('.icon-remove').click(function(event){
        target = $(event.currentTarget).closest('blockquote');
        link = $(event.currentTarget).closest('a').attr('href');

        target.toggle(500,function(){
            target.remove();
        });

    });

    // Edit comment
    var comment;
    $('.icon-pencil').click(function(event){
        var comment = $(this).parent().find('.comment_description').html();
        $.trim(comment);
        console.log(comment);
        $(this).parent().find('.comment_description').replaceWith("<input id = 'comment_description' class = 'comment_field' type = 'text' value='"+comment+"'>");
        $(this).parent().append('<input class ="btn-success" type = "button" value = "Apply">');
        $(this).parent().append('<input class ="btn-danger" type = "button" value = "Cancel">');

    });


    // delete just created comment
    function remove_comment(even){
        var target = $(even).closest('blockquote');
        target.toggle(500,function(){
            target.remove();
        });
    }