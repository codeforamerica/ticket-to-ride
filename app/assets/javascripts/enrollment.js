$(document).ready(function () {

  // Show tooltips unless user is on a touch-enabled device
  if(isTouchDevice()===false) {
    $("[data-toggle=tooltip]").tooltip({placement: 'bottom'});
  }

  $("[data-toggle=popover]").popover({ 
    html : true, 
    placement: 'top',
    content: function() {
      return $('#content_popover').html();
    }
  });
  
  $('#lives_with_g2_slider').slider();
  $("#lives_with_g2_slider").on('slide', function(slideEvt) {
    $("#lives_with_g2_val").text(slideEvt.value);
  });

  $('#basicModal').modal(options);
    var options = { "backdrop" : "static", "keyboard" : true };

  $('#btnPrimaryRace').click(function (){
    var primaryRace = $('input[name="student_race[primary_race]"]:checked').val();
    var primaryRaceTitleized = primaryRace.toProperCase();
    var selectedRace = $('#primaryRaceSelected').text(primaryRaceTitleized);
    selectedRace.removeClass('enrollment-form-popover');
    selectedRace.addClass('enrollment-form-modal-selection');
  });      


 $('#guardian2_exists_question input:radio').change(function() {
   var radio = $(this).val();  
   toggleGuardian2Name(radio);
 });

  // Change the color of the birthdate field

  $("input[type=date]").change(function(){
    var birthdaySubmitted = $(this);
    if (birthdaySubmitted.val() != '') {
      birthdaySubmitted.css("color", "#6aba5b");
    }
  });


  function toggleGuardian1Address(radio){
    if (radio == 'true'){
      $('#guardian1_street_address_1').val('<%= @student.street_address1  %>')
      $('#guardian1_shared_street1').removeClass('hidden');
      $('#guardian1_shared_street2').removeClass('hidden');
      $('#guardian1_shared_city').removeClass('hidden');
      $('#guardian1_unshared_street1').addClass('hidden');
      $('#guardian1_unshared_street2').addClass('hidden');
      $('#guardian1_unshared_city').addClass('hidden');
    } else if (radio == 'false') {
      $('#guardian1_shared_street1').addClass('hidden');
      $('#guardian1_shared_street2').addClass('hidden');
      $('#guardian1_shared_city').addClass('hidden');
      $('#guardian1_unshared_street1').removeClass('hidden');
      $('#guardian1_unshared_street2').removeClass('hidden');
      $('#guardian1_unshared_city').removeClass('hidden');
    }
  };

  function toggleGuardian2Name(radio){
    if (radio == 'true') {
      $('#guardian2_first_name').removeClass('hidden');
      $('#guardian2_last_name').removeClass('hidden');
      $('#guardian2_relationship').removeClass('hidden');
      $('#guardian2_lives_with_question').removeClass('hidden');
        $('#guardian2_armed_service_status').removeClass('hidden'); // TODO Refactor to use class instead of ID
    } else if (radio == 'false') {
      $('#guardian2_first_name').addClass('hidden');
      $('#guardian2_last_name').addClass('hidden');
      $('#guardian2_relationship').addClass('hidden');
      $('#guardian2_lives_with_question').addClass('hidden');
        $('#guardian2_armed_service_status').addClass('hidden'); // TODO Refactor to use class instead of ID
    }
  };

  // Populate Guardian2's name after relationship to student is selected for question about living situation

  function get2ndGuardianFirstName(inputName){
    $("#btnGuardian1Relationship").click(function(){
      var first_name = $(inputName).val();
      $('#guardian2_first_name_input').append(first_name);
      $('#guardian2_first_name_input2').append(first_name);
    });
  }

  get2ndGuardianFirstName('#guardian2_firstname');


  $('#guardian2_lives_with_question input:radio').change(function() {
     var radio = $(this).val();
     toggleGuardian2Slider(radio);
   });

  getSelectionFromModal('#btnGuardian2Relationship', 'input[name="contact_person[relationship]"]:checked', '#guardian2RelationshipSelected');

  $('#btnGuardian2Relationship').click(function() {
    var otherRelationship = $('#other_relationship');
    if (otherRelationship.val()) {
      var selectedRelationship = $('#guardian2RelationshipSelected').text(otherRelationship.val());
    }
    selectedRelationship.removeClass('enrollment-form-popover');
    selectedRelationship.addClass('enrollment-form-modal-selection');
  });

  // checkForRadioSelection();

  // function checkForRadioSelection(btnName) {
  //   var radioClicked = $('input[name="contact_person[lives_with_student]"]:checked');
  //   if ($('#validation-errors')) {
  //     alert(radioClicked.val());
  //   }
  // }

  // close error message


 // Disable z-index so modal works on guardian1 page

  $('#guardian1RelationshipSelected').click(function(){
    $('#contact_table').removeClass('enableZindex');
  });

  $('#btnGuardian1Relationship').click(function(){
     $('#contact_table').addClass('enableZindex');
  });

  // Disable z-index so modal works on contact1 page

   $('#contact1RelationshipSelected').click(function(){
     $('#contact_table').removeClass('enableZindex');
   }); 

   $('#btnContact1Relationship').click(function(){
      $('#contact_table').addClass('enableZindex');
   });


  // Disable z-index so modal works on contact1 page

   $('#contact2RelationshipSelected').click(function(){
     $('.edit_contact_person').removeClass('edit_contact_person');
   });  
  

  $( 'a.toggle_error' ).on( "click", function( event ) {
    $( event.target ).closest( "li" ).addClass( "hidden" );
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

  function getSelectionFromModal(btnName, inputName, linkToUpdate) {
    $(btnName).click(function () {
      var selection = $(inputName).val().toProperCase();
      var showSelection = $(linkToUpdate).text(selection);
      showSelection.removeClass('enrollment-form-popover');
      showSelection.addClass('enrollment-form-modal-selection');
    });
  };

    /**
     * For modal dialog layers with radio buttons
     * and a single text input (all with the same `name` attribute), this
     * function registers a `click` action with the `Save` button on the dialog.
     *
     * Upon saving, the radio buttons and text input are checked such that the
     * first checked radio button value is captured and placed as a value into
     * the element with ID `inputToUpdate`. If no radio button is checked, the value
     * from the text input is placed there instead.
     *
     * @param btnName `Save` button selector
     * @param inputGroupName The name attribute for the radio buttons and text input
     * @param inputToUpdate The input tag that receives the value from radio buttons or text input
     */
    function getSelectionFromModalForInput(btnName, inputGroupName, inputToUpdate, processFunc) {
        $(btnName).click(function () {
            var value = '';

            // Find a selected value (checked or text entered, then exit the each()
            $(inputGroupName).each(function(){
                var thisObj = $(this);
                var thisVal = thisObj.val();

                // Capture value from radio buttons
                if(thisObj.attr('type') == 'radio' && thisObj.is(':checked')) {
                    value = thisVal;

                    if(processFunc) {
                        processFunc(thisVal);
                    }

                    return false;
                }

                // Capture value from text field
                else if(thisObj.attr('type') == 'text' && thisVal != "") {
                    value = thisVal;

                    if(processFunc) {
                        processFunc(thisVal);
                    }

                    return false;
                }
            });

            // Assign the found value to the designated input
            var showSelection = $(inputToUpdate).val(value);
            showSelection.removeClass('enrollment-form-popover');
            showSelection.addClass('enrollment-form-modal-selection');
        });
    };

    function getSelectionNoResize(btnName, inputGroupName, inputToUpdate, processFunc) {
        $(btnName).click(function () {
            var value = '';

            // Find a selected value (checked or text entered, then exit the each()
            $(inputGroupName).each(function(){
                var thisObj = $(this);
                var thisVal = thisObj.val();

                // Capture value from radio buttons
                if(thisObj.attr('type') == 'radio' && thisObj.is(':checked')) {
                    value = thisVal;
                    return false;
                }

                // Capture value from text field
                else if(thisObj.attr('type') == 'text' && thisVal != "") {
                    value = thisVal;
                    return false;
                }
            });

            // Assign the found value to the designated input
            var showSelection = $(inputToUpdate).val(value);
            showSelection.removeClass('enrollment-form-popover');
            showSelection.addClass('enrollment-form-modal-selection keep-same-width');
        });
    };

    /**
     * Registers a click action with element selected by `textInputSelector` to
     * unchecks a clicked radio button from the group with name `radioGroupName`.
     * Additionally, it removes the class `active` from the radio buttons parent
     * `label` element.
     *
     * @param textInputSelector jQuery selector for the element that the `click` action is attached to
     * @param radioGroupName The `name` attribute for the group of radio buttons to unselect upon click
     */
    function clearRadioGroupUponTextEntry(textInputSelector, radioGroupName) {
        $(textInputSelector).click( function(){
            var radioInputSelector = 'input[name="' + radioGroupName + '"]:checked';
            var checkedElement = $(radioInputSelector);
            checkedElement.prop('checked', false);
            checkedElement.parent().removeClass('active');
        });
    }

    /**
     * Registers a click action with a group of radio buttons (and their parent
     * `label` elements) to clear the value of a designated text input element
     * (as indicated by the jQuery selector `textInputSelector`) when they are clicked/selected.
     *
     * @param textInputSelector jQuery selector for the text input that should be cleared
     * @param radioGroupName The `name` attribute for the group of radio buttons to register the event with
     */
    function clearTextInputUponRadioCheck(textInputSelector, radioGroupName) {
        $('input[name="' + radioGroupName + '"]').each(function(){
           if($(this).attr('type') == 'radio') {
               $(this).click(function(){
                   $(textInputSelector).val('');
               });

               var parentLabel = $('#' + $(this).attr('id')).parent();
               parentLabel.click(function(){
                   $(textInputSelector).val('');
               });
           }
        });
    }

  String.prototype.toProperCase = function() {
    var words = this.split('_');
    var results = [];
    for (var i=0; i < words.length; i++) {
      var letter = words[i].charAt(0).toUpperCase();
      results.push(letter + words[i].slice(1));
    }
    return results.join(' ');
  };

    // Modal Dialog Behavior for Language selection
    getSelectionFromModalForInput('#btnFirstLanguage', 'input[name="choose_student_first_language"]', '#firstLanguageSelected', function(val){firstLanguage = val; }); // TODO - Make this code cleaner
    clearRadioGroupUponTextEntry('#choose_student_guardian_language_input_text', 'choose_student_guardian_language');
    clearTextInputUponRadioCheck('#choose_student_first_language_input_text', 'choose_student_first_language');

    getSelectionFromModalForInput('#btnHomeLanguage', 'input[name="choose_student_home_language"]', '#homeLanguageSelected', function(val){homeLanguage = val; }); //TODO - Make this code cleaner
    clearRadioGroupUponTextEntry('#choose_student_first_language_input_text', 'choose_student_first_language');
    clearTextInputUponRadioCheck('#choose_student_home_language_input_text', 'choose_student_home_language');

    getSelectionFromModalForInput('#btnGuardianLanguage', 'input[name="choose_student_guardian_language"]', '#guardianLanguageSelected', function(val){guardianLanguage = val; }); //TODO - Make this code cleaner
    clearRadioGroupUponTextEntry('#choose_student_home_language_input_text', 'choose_student_home_language');
    clearTextInputUponRadioCheck('#choose_student_guardian_language_input_text', 'choose_student_guardian_language');

    // Modal Dialog Behavior for Guardian/Student relationship selection
    getSelectionFromModalForInput('#btnGuardian1Relationship', 'input[name="choose_relationship"]', '#guardian1RelationshipSelected');
    clearRadioGroupUponTextEntry('#choose_relationship_input_text', 'choose_relationship');
    clearTextInputUponRadioCheck('#choose_relationship_input_text', 'choose_relationship');

    // Modal Dialog Behavior for Contact1/Student relationship selection
    getSelectionNoResize('#btnContact1Relationship', 'input[name="choose_relationship"]', '#contact1RelationshipSelected');
    clearRadioGroupUponTextEntry('#choose_relationship_input_text', 'choose_relationship');
    clearTextInputUponRadioCheck('#choose_relationship_input_text', 'choose_relationship');

    // Modal Dialog Behavior for Contact1/Student relationship selection
    getSelectionFromModalForInput('#btnContact2Relationship', 'input[name="choose_relationship"]', '#contact2RelationshipSelected');
    clearRadioGroupUponTextEntry('#choose_relationship_input_text', 'choose_relationship');
    clearTextInputUponRadioCheck('#choose_relationship_input_text', 'choose_relationship');

    // Shade (mark as checked) all checked radio button labels (radio buttons nested inside label tags)
    $('input[type="radio"]:checked').each(function(){  $(this).parent().addClass('active')  });


    // Auto formatting of phone numbers so guardian doesn't have to type dashes or parentheses
    jQuery(function($){
       $("input[type='tel']").mask("999-999-9999",{placeholder:" "});
    });

    // Disable tooltips on touch-enabled devices otherwise tooltip will interfere with button functionality
    function isTouchDevice() {
      return true == ("ontouchstart" in window || window.DocumentTouch && document instanceof DocumentTouch);
    }

});

// function toggleGuardian2Slider(){
//   if('#guardian_2_lives_with_yes').val()) {
//     alert('yes');
//     // $('#guardian2_lives_with_frequency').removeClass('hidden');
//     // $('#guardian2_lives_with_slider').removeClass('hidden');
//     // $('#guardian2_lives_guardian2_slider_result').removeClass('hidden');
//   } else {
//     alert('no');
//     // $('#guardian2_lives_with_frequency').removeClass('hidden');
//     // $('#guardian2_lives_with_slider').addClass('hidden');
//     // $('#guardian2_lives_guardian2_slider_result').addClass('hidden');
//     // $('.slider-result').addClass('hidden');
//   }
// };