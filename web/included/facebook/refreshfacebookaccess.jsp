<%-- 
    This file will retrieve a fresh facebook access token
    File should only be included if some element on that page may require facebook access
    e.g. CommunityWall or EventWall (if user wants to share a post or event created)

    Dependencies::
    1. Must be used in conjunction with initfacebook.jsp 
    (place this file after including initfacebook.jsp)
    2. lin.facebookfunctions.js (provides Utility AJAX calls)
--%>

<script>
    
    function refreshAndStoreFacebookToken(callback) {
        
        
        //Tries to retrieve piece of info, if successful, token is still valid
        FB.api('/me',{access_token: '${fb_access_token}'}, function(response) {
            
            if(!response.error){
                $("#fb-name").text("Connected as " + response.name);               
                $('#fbImg').attr("src", "https://graph.facebook.com/" + response.id + "/picture"); 
                $(".fbControls").removeAttr("disabled");
                console.log("fbisalrconnected");
                console.log(response);
                //token is valid. store on server
                var dat = new Object();
                dat.accessToken = response.authResponse.accessToken;
                dat.fbUserId = response.authResponse.userID;
                
                $.ajax({
                    type: "POST",
                    url: "/json/facebook/connectFacebook.jsp?isExtendingToken=true",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        if(xhr.status == 200 && data.extended_token){
                            //connect facebook success, now replace div with connected info
                            console.log("token extended, stored in session");                        

                            callback();
                        }                    
                        else{
                            //failed. 
                            console.log("Warning: Failed to extend facebook token")
                        }
                    }
                });
                
            }
            else{                
                console.log("responsefberror");
                console.log(response);
                
                //token invalid. get a new one
                refreshAndExtendToken(callback);                                                                          
            }
        });
        
    }
    
function login() {
    FB.login(function(response) {
        if (response.authResponse) {
            // connected
            console.log(response);
            //post to our server
            var dat = new Object();
            dat.accessToken = response.accessToken;
            dat.fbUserId = response.authResponse.userID;
            
            $.ajax({
                type: "POST",
                url: "/json/facebook/connectFacebook.jsp?isFirstConnect=true",
                data: dat,
                success: function(data, textStatus, xhr) {
                    if(xhr.status == 200 && data.success){
                        //connect facebook success, now replace div with connected info
                        toastr.success("Successfully connected facebook!");
                        setTimeout("window.location.reload()",2000);
                        showFacebookLoggedIn();
                    }
                    else if(xhr.status == 200 && data.isAlreadyConnected){
                        toastr.info("A facebook account is already connected to this account.");
                        showFacebookLoggedIn();
                    }
                    else{
                        //failed. 
                        toastr.error("There was an error connecting your facebook account. Please try again later.");
                    }
                }
            });
            
        } else {
            toastr.warning("Facebook connect cancelled");
        }
    },{perms:'read_stream,publish_stream,user_groups,user_likes,user_groups,create_event'});
}
    
    

</script>

