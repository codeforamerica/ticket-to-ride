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
    $('#dob').editable({
      format: 'yyyy-mm-dd',    
      viewformat: 'dd/mm/yyyy',    
      datepicker: {
        firstDay: 1
      }
    });
    $('#birthCountry').editable({
      url:'',
      title: 'In what country was your child born?'
    });
    $('#hispanicLatino').editable({
       value: 2,    
       source: [
         {value: 1, text: 'is'},
         {value: 2, text: 'is not'}]
    });
    $('#studentRace').editable({
       value: 1,    
       source: [
         {value: 1, text: 'White'},
         {value: 2, text: 'Black/African American'},
         {value: 1, text: 'Asian'},
         {value: 2, text: 'American Indian/Alaska Native'},
         {value: 1, text: 'Native Hawaiian/other Pacific Islander'}]
    });
  }); /* end editable */

}); //end document ready