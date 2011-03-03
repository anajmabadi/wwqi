// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready( function() {
    $('a[data-popup]').live('click', function(e) {
    	var w = 630, h = 440; // default sizes
    	var percent = 90;
	    if (window.screen) {
	        w = window.screen.availWidth * percent / 100;
	        h = window.screen.availHeight * percent / 100;
	    }
        window.open($(this)[0].href, 'qajar_popup', 'height=' + h + ',height=' + w + ', toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no, directories=no, status=yes');
        e.preventDefault();
    });
});