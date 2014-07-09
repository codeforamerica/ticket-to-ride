$(document).ready(function () {
  $("[data-toggle=tooltip]").tooltip({placement: 'bottom'});

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

  getSelectionFromModal('#btnAdditionalRace', 'input[name="student_race[additional_races]"]:checked', '#additionalRaceSelected');

  getSelectionFromModal('#btnFirstLanguage', 'input[name="student[first_language]"]:checked', '#firstLanguageSelected');

  getSelectionFromModal('#btnHomeLanguage', 'input[name="student[home_language]"]:checked', '#homeLanguageSelected');

  getSelectionFromModal('#btnGuardianLanguage', 'input[name="student[guardian_language]"]:checked', '#guardianLanguageSelected');

  $("form input:radio").change(function() {
    if ($(this).val() == 'true'){
      $('#guardian1_shared_street').removeClass('hidden');
      $('#guardian1_shared_city').removeClass('hidden');
      $('#guardian1_unshared_street').addClass('hidden');
      $('#guardian1_unshared_city').addClass('hidden');
    } else if ($(this).val() == 'false') {
      $('#guardian1_shared_street').addClass('hidden');
      $('#guardian1_shared_city').addClass('hidden');
      $('#guardian1_unshared_street').removeClass('hidden');
      $('#guardian1_unshared_city').removeClass('hidden');
    }
  });

  /* start TODO: Make these cancel each other out. Guardian name and address */

  getSelectionFromModal('#btnGuardian1Relationship', 'input[name="contact_person[relationship]"]:checked', '#guardian1RelationshipSelected');

  $('#btnGuardian1Relationship').click(function() {
    var otherRelationship = $('#other_relationship');
    if (otherRelationship.val()) {
      var selectedRelationship = $('#guardian1RelationshipSelected').text(otherRelationship.val());
    }
    selectedRelationship.removeClass('enrollment-form-popover');
    selectedRelationship.addClass('enrollment-form-modal-selection');
  });

    // if ($('#other_relationship'.val()) { 
    //   $(':radio').attr('disabled', true);
    // }
    // else
    // {
    //  $(':radio').attr('disabled', false);
    // }

    // $('input:radio').change(function(e) {
    //  e.preventDefault;
    //   $('input[type="text"]').attr('disabled', true);
    // })

    // $('input[name="guardian[relationship]"]').change(function(e) {
    //   e.preventDefault;
    //   $('input[type="text"]').attr('disabled', true);
    // });

    // $('input[type="text"]').change(function() {
    // alert("Change called");
    // e.preventDefault;

  /* end TODO Guardian name and address */

  getSelectionFromModal('#btnGuardian2Relationship', 'input[name="contact_person[relationship]"]:checked', '#guardian2RelationshipSelected');

  $('#btnGuardian2Relationship').click(function() {
    var otherRelationship = $('#other_relationship');
    if (otherRelationship.val()) {
      var selectedRelationship = $('#guardian2RelationshipSelected').text(otherRelationship.val());
    }
    selectedRelationship.removeClass('enrollment-form-popover');
    selectedRelationship.addClass('enrollment-form-modal-selection');
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
      var selection = $(inputName).val();
      var showSelection = $(linkToUpdate).text(selection);
      showSelection.removeClass('enrollment-form-popover');
      showSelection.addClass('enrollment-form-modal-selection');
    });
  };

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