$.fn.extend({
    popoverClosable: function (options) {
        var defaults = {
            template: '<div class="popover">\
              <div class="arrow"></div>\
              <div class="popover-header">\
              <button type="button" class="close" data-dismiss="popover" aria-hidden="true">&times;</button>\
              <h3 class="popover-title"></h3>\
              </div>\
              <div class="popover-content"></div>\
              </div>'
        };
        options = $.extend({}, defaults, options);

        var $popover_togglers = this;
        $popover_togglers.popover(options);

        $popover_togglers.on('click', function (e) {
            e.preventDefault();

            $popover_togglers.not(this).popover('hide');
        });

        $('html').on('click', '[data-dismiss="popover"]', function (e) {
            $popover_togglers.popover('hide');
        });
    }
});

$(function () {
    $('[data-toggle="popover"]').popoverClosable();
});