var JolieClient = JolieClient || (function() {
    var API = {};
    var isError = function( data ) {
        if ( data != null && typeof data.error != "undefined" ) {
            return true;
        }
        return false;
    }

    var jolieCall = function( operation, request, callback, errorHandler ) {
	var opts = {
	  lines: 11, // The number of lines to draw
	  length: 31, // The length of each line
	  width: 5, // The line thickness
	  radius: 12, // The radius of the inner circle
	  corners: 0.9, // Corner roundness (0..1)
	  rotate: 33, // The rotation offset
	  direction: 1, // 1: clockwise, -1: counterclockwise
	  color: '#000', // #rgb or #rrggbb or array of colors
	  speed: 0.8, // Rounds per second
	  trail: 49, // Afterglow percentage
	  shadow: true, // Whether to render a shadow
	  hwaccel: false, // Whether to use hardware acceleration
	  className: 'spinner', // The CSS class to assign to the spinner
	  zIndex: 2e9, // The z-index (defaults to 2000000000)
	  top: '50%', // Top position relative to parent
	  left: '50%' // Left position relative to parent
	};
	var target = document.getElementById('map');
	var spinner = new Spinner(opts).spin(target);
        $.ajax({
            url: '/' + operation,
            dataType: 'json',
            data: JSON.stringify( request ),
            type: 'POST',
            contentType: 'application/json;charset=UTF-8',
            success: function( data ){
	           spinner.stop();
               if ( isError( data ) ) {
                    if ( data.error.message == "SessionExpired") {
                        showSessionExpiredDialog();
                    } else {
                        errorHandler( data );
                    }
               } else {
                    callback( data );
               }
            },
            error: function(errorType, textStatus, errorThrown) {
	            spinner.stop();
              errorHandler( textStatus );
            }
        });
    }

    API.getIngredients = function( request, callback, errorHandler ) {
        jolieCall( "getIngredients", request, callback, errorHandler );
    }

    API.getRecipes = function( request, callback, errorHandler ) {
        jolieCall( "getRecipes", request, callback, errorHandler );
    }

    return API;
})();
