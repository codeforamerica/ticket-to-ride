$(document).ready(function() {

  // var GuardianModel = function(name){
  //   var self = this;
  //   self.firstName = ko.observable('George');
  //   self.lastName = ko.observable('Harrison');

  //   self.fullName = ko.computed(function() {
  //     return self.firstName() + " " + self.lastName();
  //   }, this);
  // }

  // ko.applyBindings(GuardianModel);

  var ViewModel = function() {
      this.exampleText = ko.observable("George");
  };


  ko.bindingHandlers.popover = {
      init: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
          var cssSelectorForPopoverTemplate = ko.utils.unwrapObservable(valueAccessor());
          var popOverTemplate = "<div id='my-knockout-popver'>" + $(cssSelectorForPopoverTemplate).html() + "</div>";
          $(element).popover({
              content: popOverTemplate,
              html: true,
              trigger: 'manual'
          });

          $(element).click(function() {
              $(this).popover('toggle');
              var thePopover = document.getElementById("my-knockout-popver");
              ko.applyBindings(viewModel, thePopover);
          });
      },
  };

  ko.applyBindings(new ViewModel());
});
