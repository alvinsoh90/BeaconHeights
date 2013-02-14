
window.onload = function() {
	
    $("#amenity_validate").validate({
        rules:{
            name:{
                required: true,
                minlength:1,
                maxlength:50
            },
            description:{
                required: true,
                minlength:1,
                maxlength:100
            },
            unitNo:{
                required:true,
                minlength:1,
                maxlength:7
            },
            streetName:{
                required: true,
                minlength:1,
                maxlength:60
            },
            postalCode:{
                required: true,
                digit: true,
                minlength:6,
                maxlength:6
            },
            contactNo:{
                required: true,
                digit: true,
                minlength:8,
                maxlength:8
            },
            
            category:{
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
    })
   

};
        
       
