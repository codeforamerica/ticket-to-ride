// $(document).ready(function() {

// $(function () { $("[data-toggle='popover']").popover(); });

// var isVisible = false;
// var clickedAway = false;
// var popoverClose = 

// $('.btn-danger').popover({
//         html: true,
//         trigger: 'manual'
//     }).click(function(e) {
//         $(this).popover('show');
//         $('.popover-title').append('<button type="button" class="close">&times;</button>');
//         clickedAway = false
//         isVisible = true
//         e.preventDefault()
//     });

// $(document).click(function(e) {
//   if(isVisible & clickedAway)
//   {
//     $('.btn-danger').popover('hide')
//     isVisible = clickedAway = false
//   }
//   else
//   {
//     clickedAway = true
//   }
// });

// $('.btn-danger').popover({
//       html: true,
//       trigger: 'manual'
//   }).click(function(e) {
//       $(this).popover('show');
//       $('.popover-title').append('<button type="button" class="close">&times;</button>');
//       $('.close').click(function(e){
//           $('.btn-danger').popover('hide');
//       });
//       e.preventDefault();
//   });
// });
