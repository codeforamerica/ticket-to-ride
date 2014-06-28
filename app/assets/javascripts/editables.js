$.fn.editableform.buttons = 
  '<button type="submit" class="btn btn-success btn-sm editable-submit">'+
    '<i class="glyphicon glyphicon-ok"></i>'+
  '</button>'+
  '<button type="button" class="btn btn-default btn-sm editable-cancel">'+
    '<i class="glyphicon glyphicon-remove"></i>'+
  '</button>';   

$(document).ready(function () {
    $("[data-toggle=tooltip]").tooltip({placement: 'bottom'});
    $('#basicModal').modal(options);
      var options = { "backdrop" : "static", "keyboard" : true }

    $("[data-toggle=popover]").popover({ 
        html : true, 
        placement: 'top',
        content: function() {
          return $('#content_popover').html();
        });

    $('.madlib-editable').focus(function (event) {
    
            $(this).bind("mouseup",function(event){
                event.preventDefault();
                $(this).unbind("mouseup")        
                }) 

        selectElementContents(document.getElementById($(this).attr("id")))
    });

    function selectElementContents(el) {
    var range = document.createRange();
    range.selectNodeContents(el);
    var sel = window.getSelection();
    sel.removeAllRanges();
    sel.addRange(range);
}
});


// $(function(){
     
//     $("span[contenteditable=true]").blur(function(){
//         var field = $(this).attr("id") ;
//         var value = $(this).text() ;
//         $.post('http://localhost/your_ajaxhandler_page' , field + "=" + value, function(data){
//             // display your result data here
//         });
//     });
 
// });

// Passing edited value contenteditable field from view to controller in Rails
var form = $('#editable_fields');
var element;
$('[contenteditable=true]').each(function(){
  element = $(this);
  form.append($('<input/>', {
    type:'hidden',
    name:element.attr('id'),
    value:element.html()
  }));
});