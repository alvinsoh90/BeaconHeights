function setupValidation() {
    //for edit amenity modal
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
                        unitno:{
                            required:true,
                            minlength:1,
                            maxlength:7,
                            digits:true
                        },
                        streetName:{
                            required: true,
                            minlength:1,
                            maxlength:60
                        },
                        postalCode:{
                            required: true,
                            digits: true,
                            minlength:6,
                            maxlength:6
                        },
                        contactNo:{
                            required: true,
                            digits: true,
                            minlength:8,
                            maxlength:8
                        },

                        category:{
                            required: true
                        }

                    },
                   submitHandler: function(form) {
                    alert("Test");

                    },
                    errorClass: "help-inline",
                    errorElement: "span",
                    highlight:function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('success');
                        $(element).parents('.control-group').addClass('error');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('error');
                        $(element).parents('.control-group').addClass('success');
                    }
                });


            };
        
$(document).ready(function(){    
    //for create amenity modal
    $("#amenity_validate2").validate({
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
                            maxlength:7,
                            digits:true
                        },
                        streetName:{
                            required: true,
                            minlength:1,
                            maxlength:60
                        },
                        postalCode:{
                            required: true,
                            digits: true,
                            minlength:6,
                            maxlength:6
                        },
                        contactNo:{
                            required: true,
                            digits: true,
                            minlength:8,
                            maxlength:8
                        },

                        category:{
                            required: true
                        }

                    },
                   submitHandler: function(form) {
                    alert("Test");

                    },
                    errorClass: "help-inline",
                    errorElement: "span",
                    highlight:function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('success');
                        $(element).parents('.control-group').addClass('error');
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).parents('.control-group').removeClass('error');
                        $(element).parents('.control-group').addClass('success');
                    }
                });
});

