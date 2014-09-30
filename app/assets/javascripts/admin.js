// This is a manifest file that'll be compiled into admin.js, which will include all the files
// listed below.
//= require jquery
//= require checkboxradio
//= require select.jquery

// TODO Rename some of these functions to be clearer which pages they impact

jQuery(function($) {
    $( document ).bind( "enhance", function(){
	$( "body" ).removeClass( "no-js" );
	$( "body" ).addClass( "enhanced" );
    });

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