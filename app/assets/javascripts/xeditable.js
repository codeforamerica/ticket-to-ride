$(document).ready(function () {
    $(function () {
        $("[data-toggle='popover']").popover();
    });

    $(function () {
        // Field configurations
        $('#guardianFirstName').editable({
            title: 'What is your first name?',
            emptytext: '(first name)',
            type: 'text',
            placement: 'top'
        });
        $('#guardianLastName').editable({
            title: 'What is your last name?',
            emptytext: '(last name)',
            type: 'text',
            placement: 'top'
        });
        $('#studentFirstName').editable({
            title: 'Student\'s first name?',
            emptytext: '(first name)',
            type: 'text',
            placement: 'top'
        });
        $('#studentLastName').editable({
            title: 'Student\'s last name?',
            emptytext: '(last name)',
            type: 'text',
            placement: 'top'
        });
        $('#schoolDistrict').editable({
            title: 'Choose your city or town',
            type: 'select',
            source: [
                {value: 1, text: 'Cranston'},
                {value: 2, text: 'Newport'},
                {value: 3, text: 'Warwick'},
                {value: 4, text: 'West Warwick'}
            ],
            emptytext: '(city/town)'
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