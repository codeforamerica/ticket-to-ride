$(document).ready(function() {
var personViewModel = function () {
    var self = this;
    self.persons = ko.observableArray();
    self.persons.push({
        id: 1,
        firstName: ko.observable('John' + ' '),
        lastName: ko.observable('Lennon')
    })

    self.closePopover = function(person) {
        $('#popover' + person.id + '_click').popover('hide');
    };
}

ko.bindingHandlers.popUp = {
    init: function (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
        var attribute = ko.utils.unwrapObservable(valueAccessor());
        var templateContent = attribute.content;
        var popOverTemplate = "<div class='popOverClass' id='" + attribute.id + "-popover'>" + $(templateContent).html() + "</div>";
        $(element).popover({
            placement: 'top',
            content: popOverTemplate,
            html: true,
            trigger: 'manual'
        });
        $(element).attr('id', "popover" + attribute.id + "_click");
        $(element).click(function (){
            $(".popoverClass").popover("hide");
            $(this).popover('toggle');
            var thePopover = document.getElementById(attribute.id + "-popover");
            childBindingContext = bindingContext.createChildContext(viewModel);
            ko.applyBindingsToDescendants(childBindingContext, thePopover)
        })
    }
}

  ko.applyBindings(new personViewModel());

});