// This is a manifest file that'll be compiled into admin.js, which will include all the files
// listed below.
//= require jquery
//= require custominput.jquery
//= require select.jquery

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

function resendInvite(callingElement, personId) {
    callingElement.innerText = 'Sent again!';
    // TODO make this do a REST call to the backend to resend the e-mail
}

function clearSupplementalMaterialLink() {
    if( $('#supplemental_material_file').val() != '' ) {
        $('#supplemental_material_link_url').val('')
    }
}