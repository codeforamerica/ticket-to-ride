// $(document).ready(function() {

//   $("#tooltip").tooltip();
//   $("#popover").popover();

//   var guardianViewModel = function() {
//     this.id: 1;
//     this.guardianFirstName = ko.observable("George");
//     this.guardianLastName = ko.observable(' ' + "Harrison");

//     this.closePopover = function(person){
//       $('#popover' + person.id + '_click').popover('hide');
//     };
//   }


//   ko.bindingHandlers.popUp = {
//       init: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
//           var attribute = ko.utils.unwrapObservable(valueAccessor());
//           var templateContent = attribute.content;
//           var popOverTemplate = "<div class='popOverClass' id=''>" + attribute.id + "-popover'>" + $(templateContent).html() + "</div>";
//           // var popOverTitle = "<a href='#' id='popCancel' class='pull-right'>x</a>";

//           $(element).popover({
//             // title: $(this).title + popOverTitle, // fix the undefined call for .title
//             content: popOverTemplate,
//             html: true,
//             trigger: 'manual'
//           });
//           $(element).attr('id', "popover" + attribute.id + "_click");
//           $(element).click(function() {
//             $(".popoverClass").popover('hide');
//             $(this).popover('toggle');
//             var thePopover = document.getElementById(attribute.id + "-popover");
//             childBindingContext = bindingContext.createChildContext(viewModel);
//             ko.applyBindingsToDescendants(childBindingContext, thePopover)
//           })
//       }
//   }

//   ko.applyBindings(new guardianViewModel());

// });
