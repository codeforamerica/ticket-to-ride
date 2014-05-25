$(document).ready(function() {
  // $(function () { $("[data-toggle='popover']").popover(); });

var viewModel = {
    Guardian: {
        firstName: ko.observable("George"),
        lastName: ko.observable("Harrison"),
        btnSubmit: function () { alert(this.firstName() + " " + this.lastName()); }
    },
    Student: {
        studentFirstName: ko.observable("Dhani"),
        studentLastName: ko.observable("Harrison"),
        btnSubmit: function () { alert(this.studentFirstName() + " " + this.studentLastName()); }
    }
};

ko.applyBindings(viewModel);

// ko.bindingHandlers.popUp = {
//   init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
//     var attribute = ko.utils.unwrapObservable(valueAccessor());
//     var templateContent = attribute.content;
//     var popOverTemplate = "<div id='my-knockout-popver'>" + $(templateContent).html() + "</div>";
//     $(element).popover({
//         placement: 'top',
//         content: popOverTemplate,
//         html: true,
//         trigger: 'manual'
//     });
//     // $(element).attr('id', "popover" + attribute.id + "_click");
//     $(element).click(function (){
//         // $(".popoverClass").popover("hide");
//         $(this).popover('toggle');
//         var thePopover = document.getElementById("my-knockout-popver");
//         ko.applyBindings(viewModel, thePopover);
//         // childBindingContext = bindingContext.createChildContext(viewModel);
//         // ko.applyBindingsToDescendants(childBindingContext, thePopover)
//     });
//   },
// };

// ko.applyBindings(new ViewModel());

});