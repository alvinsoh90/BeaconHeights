
/** Refreshing Tokens **/
function refreshAndExtendToken() {
    
    FB.login(function(response) {
        if (response.authResponse) {
            // connected
            console.log(response);
            //post to our server
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
                        showFacebookLoggedIn();
                        
                    }                    
                    else{
                        //failed. 
                        console.log("Warning: Failed to extend facebook token")
                    }
                }
            });
                                                                                        
        } else {
            toastr.warning("Facebook connect cancelled");
        }
    });   
}

function refreshAndExtendTokenWithCallback(success_callback, failed_callback){
    toastr.info("Authenticating with facebook...");
    
    FB.login(function(response) {
        if (response.authResponse) {
            // connected
            console.log(response);
            //post to our server
            var dat = new Object();
            dat.accessToken = response.authResponse.accessToken;
            dat.fbUserId = response.authResponse.userID;
                                            
            $.ajax({
                type: "POST",
                url: "/json/facebook/connectFacebook.jsp?isExtendingToken=true",
                data: dat,
                success: function(data, textStatus, xhr) {
                    if(xhr.status == 200 && data.extended_token){
                        //connect facebook success
                        console.log("token extended, stored in session");                                                                        
                        success_callback();
                        
                    }                    
                    else{
                        //failed. 
                        console.log("Warning: Failed to extend facebook token");
                        failed_callback();
                    }
                }
            });
                                                                                        
        } else {
            toastr.warning("Facebook connect cancelled");
            failed_callback();
        }
    });
}

/** Make Posts to Group **/

var facebookGroupID = "582475795096626";

function postToGroup(msg,link){
    FB.api('/' + facebookGroupID + '/feed','post',{
        access_token: '${fb_access_token}',
        link:link,
        message:msg
    }, function(response) {
        
        if(response.id){
            toastr.success("Your post is shared with LivingNet @ Beacon Heights Facebook Group.");
        }
                                        
    });
}