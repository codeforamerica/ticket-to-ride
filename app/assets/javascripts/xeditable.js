
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
        $('#studentGender').editable({
            title: 'Choose based on the student\'s gender',
            type: 'select',
            source: [
                {value: 1, text: 'He'},
                {value: 2, text: 'She'}
            ],
            emptytext: '(He/She)'
        });
        $('#dob').editable({
            title: 'What is the student\'s birthday?',
            type: 'combodate',
            emptytext: '(birthday)'
        });
        $('#birthCountry').editable({
            url: '',
            title: 'In what country was your child born?'
        });
        $('#hispanicLatino').editable({
            value: 2,
            source: [
                {value: 1, text: 'is'},
                {value: 2, text: 'is not'}
            ]
        });
        $('#studentRace').editable({
            value: 1,
            source: [
                {value: 1, text: 'White'},
                {value: 2, text: 'Black/African American'},
                {value: 1, text: 'Asian'},
                {value: 2, text: 'American Indian/Alaska Native'},
                {value: 1, text: 'Native Hawaiian/other Pacific Islander'}
            ]
        });

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