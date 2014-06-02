
$(document).ready(function () {

    // Reset mad libs fields (for example, when going BACK in the flow)
    $('#hidden-form-fields input').each(function(){
        var value = $(this).val();
        if(value != null || value != ""){
            var aId = '#a_' + $(this).attr('id');
            $(aId).text(value);
        }
    });

    $(function () {
        // Field configurations
        $('#a_guardian_first_name').editable();

        $('#a_guardian_last_name').editable();

        $('#a_student_first_name').editable();

        $('#a_student_last_name').editable();

        $('#a_student_home_city').editable({
            source: [
                {value: 1, text: 'Cranston'},
                {value: 2, text: 'Newport'},
                {value: 3, text: 'Warwick'},
                {value: 4, text: 'West Warwick'}
            ]
        });

        $('#a_student_gender').editable({
            source: [
                {value: 1, text: 'He'},
                {value: 2, text: 'She'}
            ]
        });

        $('#a_student_birthday').editable();

        $('#a_student_birth_country').editable();

        $('#a_student_is_hispanic').editable({
            source: ["is", "isn't"],
            emptytext: "blarg"
        });

        $('#a_student_race_race').editable({
            source: [
                {value: 1, text: 'White'},
                {value: 2, text: 'Black/African American'},
                {value: 3, text: 'Asian'},
                {value: 4, text: 'American Indian/Alaska Native'},
                {value: 5, text: 'Native Hawaiian/other Pacific Islander'}
            ]
        });

        $('#a_student_first_language').editable({
            // Languages spoken by more than 0.6% of the population of RI (80% speak English, 20% other, all other than Mon-Khmer are above 1%)
            source: ["English", "Spanish",  "Portugese", "Italian", "French", "Mon-Khmer"].sort()
        });

        $('#a_student_second_language').editable({
            // Languages spoken by more than 0.6% of the population of RI (80% speak English, 20% other, all other than Mon-Khmer are above 1%)
            source: ["English", "Spanish",  "Portugese", "Italian", "French", "Mon-Khmer", "(No Other Language)"].sort()
        });

        $('#a_student_home_street_address_1').editable();

        $('#a_student_home_city').editable();

        $('#a_student_home_zip_code').editable();

        $('#a_student_alt_home_status').editable({
            source: ["lives", "doesn't live"]
        }).on('hidden', function(){
            var currentId = $(this).closest().context.id;
            var value = $('#'+currentId).text();
            var altAddressDiv = $('#alt-address-div');
            if(value === "lives"){
                altAddressDiv.show();
            }
            else {
                altAddressDiv.hide();
                //TODO: Clear the alt address form fields
            }
        });

        $('#a_student_alt_home_street_address_1').editable();

        $('#a_student_alt_home_city').editable();

        $('#a_student_alt_home_zip_code').editable();

        // Enables auto progression of fields
        $('.editable').on('hidden', function (e, reason) {
            if (reason === 'save' || reason === 'nochange') {
                // Get info about the currently selected editable field
                var currentId = $(this).closest().context.id;
                var hashCurrentId = '#' + currentId;

                // Copy value to form field
                copyATextToInputValue(hashCurrentId);

                // Get the index of the next editable field
                var editableFields = $('.editable');
                var currentIndex = getIndexOfElementById(editableFields, currentId);
                var nextIdIndex =  currentIndex + 1;

                // Progress the next field if possible
                if (nextIdIndex < editableFields.length) {
                    var next = $('#' + editableFields[nextIdIndex].id);
                    setTimeout(function () {
                        next.editable('show');
                    }, 300);
                }
            }
        });
    });
    /* end editable */

}); //end document ready

/**
 * Searches an array of HTML elements for
 * an element with a matching id attribute.
 *
 * Returns the index of the array that the
 * element is located at.
 *
 * @param elements Array of HTML elements
 * @param id id attribute to match
 * @returns {number}
 */
function getIndexOfElementById(elements, id) {
    for(var i = 0; i < elements.length; i++) {
        var element = elements[i];
        if(element.id === id) {
            return i;
        }
    }

    return -1;
};

/**
 * Removes "a_" from the beginning of strings. Works
 * with hashed tagged values too. Examples:
 *
 * "a_rub_a_dub_dub" => "rub_a_dub_dub"
 * "#a_rub_a_dub_dub" => "#rub_a_dub_dub"
 *
 * @param str A string
 * @returns The string, minus a lead "a_"
 */
function stripAUnderscoreFrom(str) {
    var match = /^(#?)a_(.*)/.exec(str);
    if(match != null){
        return match[1] + match[2];
    }
}

/**
 * Copies the `text` attribute from an `a` tag to
 * an `input` tag's `value` attribute. The
 * `a` tag's ID must be the same as the `input` tag's, except
 * with a leading "a_".
 *
 * For example, if argument `aId` is
 * "a_field", then the text will be copied from
 *
 * <a id="a_field">
 * to
 * <input id="field">
 *
 * @param aId An ID of an `a` tag with a corresponding `input` tag
 */
function copyATextToInputValue(aId){
    var aValue = $(aId).text();
    var formId = stripAUnderscoreFrom(aId);
    $(formId).val(aValue);
}