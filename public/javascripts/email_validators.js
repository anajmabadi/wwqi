 /**
 * @author historicus
 */

function trim(str) {
	return str.replace(/^\s+|\s+$/g, '');
}

function setFocusDelayed() {
	global_valfield.focus();
}

function setfocus(valfield) {
	// save valfield in global variable so value retained when routine exits
	global_valfield = valfield;
	setTimeout( 'setFocusDelayed()', 100 );
}

function validateEmail  (valfield) {

	var tfld = trim(valfield.value);  // value of field with whitespace trimmed off
	var email = /^[^@]+@[^@.]+\.[^@]*\w\w$/  ;
	if (!email.test(tfld)) {
		$(valfield).parent().find(".mandatory").html("<%= t(:not_valid) %>");
		$(valfield).data("isValid",false);
		setfocus(valfield);
		return false;
	}

	var email2 = /^[A-Za-z][\w.-]+@\w[\w.-]+\.[\w.-]*[A-Za-z][A-Za-z]$/  ;
	if (!email2.test(tfld)) {
		$(valfield).parent().find(".mandatory").html("<%= t(:not_valid) %>");
		$(valfield).data("isValid",false);
	} else {
		$(valfield).parent().find(".mandatory").html("*");
		$(valfield).data("isValid",true);
	}
	if ($("#sb-container input#from").data("isValid")!=null && $("#sb-container input#from").data("isValid") ==true && $("#sb-container  input#to").data("isValid")!=null && $("#sb-container  input#to").data("isValid")==true) {
		$("#sb-container input[type=submit]").attr("disabled",false);
	} else {
		$("#sb-container input[type=submit]").attr("disabled",true);
	}
	return true;
}
