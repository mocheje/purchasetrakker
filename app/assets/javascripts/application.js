// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.min
//= require jquery_ujs
//= require requests
//= require bootstrap.min
//= require bootstrap-colorpicker
//= require bootstrap-datepicker
//= require bootstrap-file-input
//= require bootstrap-select
//= require bootstrap-timepicker.min

//= require jquery.sparkline.min
//= require jquery.tagsinput.min
//= require jquery.mCustomScrollbar.min
//= require jquery-ui.min
//= require plugins
//= require actions
//= require summernote
//= require morris.min
//= require raphael-min
//= require jquery.printElement.min










$(function(){
    $("#requestSearch form input[type='text']").on("keydown", function(){
        if(evnt.keyCode === 13) {
            $(this).closest("form").submit();
            return false
        }
        console.log("you pressed the following key %s", evnt.keyCode);
    })
});

$(document).ready(function() {
    $('.reject_request').hide();
    $('#sim_request_rejection_reason').click(function(){
        $(this).hide();
        $('.reject_request').show();
    });
});
