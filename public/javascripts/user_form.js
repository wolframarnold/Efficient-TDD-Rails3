$(function(){
    window.docForm = $('.address:last').clone();
    window.nextIdx = $('.address').length;
    $('.add_one_link').click(function(){
       var copy = window.docForm.clone();
       var nextIdx = window.nextIdx;
       copy.find('input,select,textarea').each(function(){
         switch ($(this).attr('type')) {
           case 'radio':
              $(this).removeAttr('checked');
              break;
           case 'hidden':
           case 'checkbox':
              break;
           default:
              $(this).val('');
              break;
         }
         var name = $(this).attr('name').replace(/[0-9]+/,nextIdx);
         $(this).attr('name',name);
         var id = $(this).attr('id').replace(/[0-9]+/,nextIdx);
         $(this).attr('id',id);
       });
       copy.find('label').each(function(){
         var label_for = $(this).attr('for').replace(/[0-9]+/,nextIdx);
         $(this).attr('for',label_for);
       });
       ++window.nextIdx;
       copy.insertBefore($('.add_one_link')).slideDown(1000);
    });
    $('.delete_link').live('click', function(){
        $(this).parent().find('input[name*=_destroy]').val('1');
        $(this).parent().slideUp(1000); // don't remove it--it still needs to get to the server
    });
});