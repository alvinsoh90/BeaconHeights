
window.onload = function() {
	
    $("#chooseUsername").validate({
        rules:{
            username:{
                required: true,
                minlength:5,
                maxlength:20
            },
            newpassword:{
                required:true,
                minlength:6,
                maxlength:20
            },
            newpasswordconfirm:{
                required:true,
                minlength:6,
                maxlength:20,
                equalTo:"#newpassword"
            },
            success:{
                required: true,
                equalTo:"true"
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
    })
   

};
        
       
