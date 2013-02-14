
window.onload = function() {
	
    $("#registration_validate").validate({
        rules:{
            username:{
                required: true,
                minlength:5,
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
            },
            firstname:{
                required: true
            },
            lastname:{
                required: true
            },
            block:{
                required: true
            },
            level:{
                required: true,
                digits:true
            },
            unitnumber:{
                required: true,
                digits:true
            },
            mobileno:{
                required: true,
                digits:true,
                minlength:8,
                maxlength:8
            },
            email:{
                required:true,
                email:true
            },
            vehicleNumberPlate:{
                required:function(element) {
                    return $("#vehicleType").val() !="";
                }
            },
            vehicleType:{
                required:function(element) {
                    return $("#vehicleNumberPlate").val()!="";
                }
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
        
       
