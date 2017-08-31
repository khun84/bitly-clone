var pasted = false;

$(document).ready(function(){
    console.clear();
    $('#shorten_btn').click(function () {
        $(this).effect("shake");
    });


    $('#url_form').submit(function (event) {
        event.preventDefault();
        ajaxCall();
    });

    $('#shorten_url').bind('paste',function (event) {
        pasted = true;
        setTimeout(function () {
            ajaxCall()
            },
        500);

    });

});

function createCell(className) {
    col = $(document.createElement('td'));
    col.addClass(className);
    return col;
}
var result;
function ajaxCall() {
    console.log('running ajax')
    $.ajax({
        url: '/urls',
        method: 'POST',
        data: $('#shorten_url').serialize(),
        format: 'json',
        error: function(data) {
            console.log(data)
        },
        success: function(data) {
            // REMEMBER TO PARSE THE JSON OBJECT FROM SERVER
            data = JSON.parse(data)
            result = data;

            $('#url-error-message').remove();
            if(data.id !== undefined){
                var tr;
                var count = 0;
                if($('#url_table tr').length !== 0){
                    count = $('#url_table tr').length
                }

                tr = $(document.createElement('tr'));

                var colIndex = createCell('column-index');
                colIndex.html(count + 1);

                var colLong = createCell('column-url');
                colLong.html(data.long_url);

                var colShort = createCell('column-url');
                colShort.html(data.short_url);

                var colClickCount = createCell('column-count');
                colClickCount.html(data.click_count);

                tr.append(colIndex);
                tr.append(colLong);
                tr.append(colShort);
                tr.append(colClickCount);

                $('#url_table tbody').append(tr);

                if(pasted){
                    $('#shorten_url').val(data.short_url);
                }
            }
            else {
                var i = 1;
                $.map(data, function(val, key){
                    eleID = 'url_error_message_' + i
                    $('#container').append("<p class='url-error-message' id=" + eleID + ">" + key + ": " + val + "</p>");
                    i+=1;

                })
            }
        pasted = false;

        }
    })
}
