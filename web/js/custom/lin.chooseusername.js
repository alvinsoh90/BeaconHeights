
window.onload = function() {
	
    $("#chooseUsername").validate({
        
        rules:{
            username:{
                required:true
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
//           submitHandler: function(form) {
//            if( $("#username").val().length > 5 && $("#username").val().length <= 20){
//                $(form).submit();
//            }
//            else{
//                toastr.error("Your username must be between 6 - 20 characters!")
//            }
//            
//        },
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
        
       
