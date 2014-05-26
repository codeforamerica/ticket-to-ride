$(document).ready(function() {
  $(function () { $("[data-toggle='popover']").popover(); });

  $(function(){
    $('#guardianFirstName').editable({
        url:'',
        title: 'What is your first name?'
    });
    $('#guardianLastName').editable({
        url:'',
        title: 'What is your last name?'
    });
    $('#studentFirstName').editable({
        url:'',
        title: 'Student\'s first name?'
    });
    $('#studentLastName').editable({
        url:'',
        title: 'Student\'s last name?'
    });
    $('#schoolDistrict').editable({
           value: 2,    
           source: [
                 {value: 1, text: 'Cranston'},
                 {value: 2, text: 'Newport'},
                 {value: 3, text: 'Warwick'},
                 {value: 4, text: 'West Warwick'}]
       });
    $('#studentGender').editable({
           value: 2,    
           source: [
                 {value: 1, text: 'He'},
                 {value: 2, text: 'She'}]
       });
  }); /* end editable */

}); //end document ready