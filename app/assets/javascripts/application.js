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
//= require best_in_place
//= require jquery_ujs
//= require requests
//= require bootstrap.min
//= require bootstrap-tour.min
//= require bootstrap-colorpicker
//= require bootstrap-datepicker
//= require bootstrap-file-input
//= require bootstrap-select
//= require bootstrap-timepicker.min
//= require semantic
//= require sweetalert.min

//= require jquery.sparkline.min
//= require jquery.tagsinput.min
//= require jquery.mCustomScrollbar.min
//= require jquery-ui.min
//= require best_in_place.jquery-ui
//= require plugins
//= require actions
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
    });
    $('.dropdown')
        .dropdown()
    /* Activating Best In Place */
    $(".best_in_place").best_in_place();
    $("[data-behavior='delete']").click(function(e){
        var self = this;
        e.preventDefault();
        console.log('trying to delete');
        swal({
            title: 'Are you sure?',
            text: 'You will not be able to recover this imaginary file!',
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#DD6B55',
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel',
            closeOnConfirm: false,
            closeOnCancel: false
        }, function(confirmed){
            if(confirmed){
                $.ajax({
                    url: $(self).attr("href"),
                    dataType: "JSON",
                    method: "DELETE",
                    success: swal('Deleted!', 'Your imaginary file has been deleted.', 'success')
                });
                //reload page
                location.reload();
            } else {
                swal('Cancelled', 'Not deleted:)', 'error');
                return;
            }
        })

    });

});

