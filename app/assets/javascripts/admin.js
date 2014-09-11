// This is a manifest file that'll be compiled into admin.js, which will include all the files
// listed below.
//= require jquery
//= require custominput.jquery
//= require select.jquery

// TODO Rename some of these functions to be clearer which pages they impact

$( document ).bind( "enhance", function(){
    $( "body" ).addClass( "enhanced" );
    $( "input[type=radio]" ).customInput();
    $( "input[type=checkbox]" ).customInput();
    $( "body" ).addClass( "custom-input" );
});

$(document).ready(function(){
    $('body').removeClass('no-js');
    $('.is-branch').hide();
    $( document ).trigger( "enhance" );
});


function toggleDeleteButton() {
    var disabled = $('#confirm-delete-input-text').val().toLowerCase() != 'delete';
    $('#confirm-delete-button').attr('disabled', disabled);
}

function toggleApplicationEditing(areFieldsDisabled) {
    var val = areFieldsDisabled ? 'disabled' : '';
    $('#application-detail-form input').prop('disabled', val);
    $('#application-detail-form select').prop('disabled', val);
}

function resendInvite(callingElement, personId) {
    callingElement.innerText = 'Sent again!';
    // TODO make this do a REST call to the backend to resend the e-mail
}

function chooseSupplementalMaterialFile() {
    if( $('#supplemental_material_file').val() != '' ) {
        $('#supplemental_material_link_url').val('');
        $('#supplemental_material_bring_documentation').attr('checked', false);
    }
}

function chooseSupplementalMaterialLink() {
    if( $('#supplemental_material_link_url').val() != "") {
        $('#supplemental_material_file').val('');
        $('#supplemental_material_bring_documentation').attr('checked', false);
    }
}

function chooseSupplementalMaterialBringDoc() {
    if( $('#supplemental_material_bring_documentation').prop('checked') ) {
        $('#supplemental_material_link_url').val('');
        $('#supplemental_material_file').val('');
    }
}

function areAllCheckboxesChecked() {
    var allChecked = true;

    $('input:checkbox').each(function(){
       if( $(this).prop('checked') != true ) {
           allChecked = false;
       }
    });

    return allChecked;
}