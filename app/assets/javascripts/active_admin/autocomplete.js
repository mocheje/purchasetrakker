
$(document).ready(function() {
    var autocomplete = function() {
        // Loop through elements that have the autocomplete class
        $('.autocomplete').each(function(index, input) {
            var $hiddenInput, $input;
            $input = $(input);
            // Find the dynamically generated hidden form element
            $hiddenInput = $('#' + $input.attr('id') + '_input').find(':hidden');
            return $input.autocomplete({
                minLength: 3,
                delay: 600,
                // Do an ajax call to a url to get back the JSON that will populate the autocomplete options
                source: function(request, response) {
                    return $.ajax({
                        url: $input.data('url'),
                        dataType: 'json',
                        data: {
                            // Pass the search term
                            term: request.term
                        },
                        success: function(data) {
                            return response(data);
                        }
                    });
                },
                // Upon select, designate what to do with the selected item. In this case, display the label of their selection
                // and populate the hidden track field with the ID
                select: function(event, ui) {
                    $input.val(ui.item.label);
                    $hiddenInput.val(ui.item.id);
                    return false;
                }
                // Populate the autocomplete options in a drop down unordered list
            }).data('ui-autocomplete')._renderItem = function(ul, item) {
                return $('<li></li>').data('item.autocomplete', item).append('<a>' + item.label + '</a>').appendTo(ul);
            };
        });
    };

    autocomplete();

    // Make sure that inputs generated on the fly (via the has many association) also have autocomplete functionality
    $('.has_many .button').click(function() {
        autocomplete();
    });
});