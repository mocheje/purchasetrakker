$(document).ready(function() {
    $('.reject_request').hide();
    $('#sim_request_rejection_reason').click(function(){
        $(this).hide();
        $('.reject_request').show();
    });
});
