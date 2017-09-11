// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require select2-full
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require webcam.min
//= require bootstrap-select
//= require_tree .

$(document).on('turbolinks:load', function(){
  //Hamburguer cross
  var trigger = $('.hamburger'),
      overlay = $('.overlay'),
     isClosed = false;

    trigger.click(function () {
      hamburger_cross();      
    });

    function hamburger_cross() {

      if (isClosed == true) {          
        overlay.hide();
        trigger.removeClass('is-open');
        trigger.addClass('is-closed');
        isClosed = false;
      } else {   
        overlay.show();
        trigger.removeClass('is-closed');
        trigger.addClass('is-open');
        isClosed = true;
      }
  }
  
  $('[data-toggle="offcanvas"]').click(function () {
        $('#wrapper').toggleClass('toggled');
  });

  //Activa bootstrap combobox
  $('.selectpicker').selectpicker({
    style: 'btn-info',
    size: 5
  });

  //var key;
  //var str = '';

  /*$('#buscador').keypress(function(e){
    key = e.which;
    if (key != 8){
      str = str + String.fromCharCode(key);
    } else {
      str = str.substring(0, str.length - 1);
    }
    $.ajax({
      url: "/persons/list_view/",
      type: "post",
      data: {str},
      success: function(e){
        console.log(str);
      },
      error:function(xhr, ajaxOptions, thrownError) {
        alert(xhr.status);
        alert(xhr.responseText);
      }
    });
  })*/

});
