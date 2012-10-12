/**
 * Unicorn Admin Template
 * Diablo9983 -> diablo9983@gmail.com
**/
$(document).ready(function(){
	
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	
	$('select').chosen();

	
	$("#registration_validate").validate({
		rules:{
			username:{
				required: true,
				minlength:6,
				maxlength:20
			},
                        password:{
				required: true,
				minlength:6,
				maxlength:20
			},
			passwordconfirm:{
				required:true,
				minlength:6,
				maxlength:20,
				equalTo:"#password"
			},firstname:{
				required: true
			},lastname:{
				required: true
			},block:{
				required: true
			},level:{
				required: true
			},unitnumber:{
				required: true
			}
		},
		errorClass: "help-inline",
		errorElement: "span",
		highlight:function(element, errorClass, validClass) {
			$(element).parents('.control-group').addClass('error');
		},
		unhighlight: function(element, errorClass, validClass) {
			$(element).parents('.control-group').removeClass('error');
			$(element).parents('.control-group').addClass('success');
		}
	});
});
