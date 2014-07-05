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
        var primaryRaceTitleized = primaryRace.toProperCase();
        var selectedRace = $('#primaryRaceSelected').text(primaryRaceTitleized);
        selectedRace.removeClass('enrollment-form-popover');

    });      

    $('#btnAdditionalRace').on("click", function (){
        var primaryRace = $('input[name="student_race[additional_races]"]:checked').val();
        var selectedAdditionalRace = $('#additionalRaceSelected').text(primaryRace);
        selectedAdditionalRace.removeClass('enrollment-form-popover');
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

   // String.prototype.toProperCase = function () {
   //     return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
   // };
   String.prototype.toProperCase = function() {
     var words = this.split('_');
     var results = [];
     for (var i=0; i < words.length; i++) {
         var letter = words[i].charAt(0).toUpperCase();
         results.push(letter + words[i].slice(1));
     }
     return results.join(' ');
   };
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