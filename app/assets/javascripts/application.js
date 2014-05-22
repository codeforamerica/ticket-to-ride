// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


// // scrolling background

//  // speed in milliseconds
//  var scrollSpeed = 120;

//  // set the default position
//  var current = 0;

//  // set the direction
//  var direction = 'h';

//  function bgscroll() {
//      // 1 pixel row at a time
//      current -= 1;

//      // move the background with backgrond-position css properties
//      $('body').css("backgroundPosition", (direction == 'h') ? current + "px 0" : "0 " + current + "px");
//  }

//  //Calls the scrolling function repeatedly
//  setInterval("bgscroll()", scrollSpeed);