$.fn.editableform.buttons = 
  '<button type="submit" class="btn btn-success btn-sm editable-submit">'+
    '<i class="glyphicon glyphicon-ok"></i>'+
  '</button>'+
  '<button type="button" class="btn btn-default btn-sm editable-cancel">'+
    '<i class="glyphicon glyphicon-remove"></i>'+
  '</button>';   

$(document).ready(function () {
    $("[data-toggle=tooltip]").tooltip({placement: 'bottom'});
    $('#lives_with_g2_slider').slider();
    $("#lives_with_g2_slider").on('slide', function(slideEvt) {
      $("#lives_with_g2_val").text(slideEvt.value);
    });

    $('#basicModal').modal(options);
      var options = { "backdrop" : "static", "keyboard" : true };

    $('#btnPrimaryRace').on("click", function (){
        var primaryRace = $('input[name="student_race[primary_race]"]:checked').val();
        $('#primaryRaceSelected').text(primaryRace);
    });      

    $('#btnAdditionalRace').on("click", function (){
        var primaryRace = $('input[name="student_race[additional_races]"]:checked').val();
        $('#additionalRaceSelected').text(primaryRace);
    }); 
    $('#btnGuardian1Relationship').on("click", function (){
        var relationship = $('input[name="guardian[relationship]"]:checked').val();
        $('#guardian1RelationshipSelected').text(relationship);
    });




    $("[data-toggle=popover]").popover({ 
        html : true, 
        placement: 'top',
        content: function() {
          return $('#content_popover').html();
        }
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