<ul class="nav pull-right">
                    <li class="divider-vertical"></li>                    
                    <li class="dropdown">
                        <a onclick="retrieveNotifications()" data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span id="nCount" class="hide label label-important notificationCount"></span>
                            <i class="icon-download-alt larger"></i>                            
                            <b class="caret"></b>							
                        </a>

                        <ul id="nHolder" class="dropdown-menu hoverShow notificationDropDown">
                            <li><div class="notification header centerText TAGGEDINPOST">No Notifications</div></li>
                            <!--<li><div class="notification TAGGEDINPOST"><div class="float_l"><img src="/uploads/profile_pics/123123123.jpg"/></div><div class="content"><a href="/profile.jsp?"<b>Shamus Hash</b></a> tagged you in a <a href="#">post</a>:<br/> <b>"Blabla post name Blabla post name Blabla post name"</b> <span>34mins ago</span></div></div></li>
                            <li><div class="notification EVENTCREATED"><div class="float_l"><img src="/uploads/profile_pics/123123123.jpg"/></div><div class="content"><a href="/profile.jsp?"<b>Shamus Hash</b></a> created an event: <a href="#">post</a>:<br/> <b>"Blabla post name Blabla post name Blabla event name"</b> <span>34mins ago</span></div></div></li>
                            <li><div class="notification JOINEDEVENT"><div class="float_l"><img src="/uploads/profile_pics/123123123.jpg"/></div><div class="content"><a href="/profile.jsp?"<b>Shamus Hash</b></a> joined the event: <a href="#">post</a>:<br/> <b>"Blabla post name Blabla post name Blabla event name"</b> <span>34mins ago</span></div></div></li>  -->                          
                        </ul>
                        
                        <!-- Notification Scripts Start -->
                        <script src="/js/jquery-1.9.1.min.js"></script>
                        <script>
                            $(function(){
                                retrieveNotifications();
                            });
                            
                            function setAllNotificationsRead(){
                                
                            }
                            
                            function retrieveNotifications(){
                                $.ajax({
                                    type: "GET",
                                    url: "/json/getUserNotifications.jsp",
                                    success: function(data, textStatus, xhr) {
                                        if(xhr.status === 200){
                                            var count = data.notifications.length;
                                            console.log(count);
                                            if(count){
                                               $("#nCount").text(count);
                                               $("#nCount").show();
                                               
                                               $("#nHolder").html("");
                                               //loop through and show
                                               for(var i = 0 ; i < data.notifications.length ; i++){
                                                   var html = '';
                                                   var n = data.notifications[i];
                                                   if(n.type == "FRIENDREQUEST"){
                                                       html = '<li><div class="notification FRIENDREQUEST"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> would like to be your friend <br/><a onclick="acceptFriend('+n.senderId+')" href="#">Accept</a> or <a onclick="acceptFriend('+n.senderId+')" href="#">Reject</a> <span>'+n.timestamp+'</span></div></div></li>';                                                       
                                                   } 
                                                   else if(n.type == "TAGGEDINPOST"){
                                                       html = '<li><div class="notification TAGGEDINPOST"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> tagged you in a <a href="communitywall.jsp?pid='+n.post.id+'">post</a>:<br/> <b>"'+n.post.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "EVENTCREATED"){
                                                       html = '<li><div class="notification EVENTCREATED"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> created an <a href="eventwall.jsp?eid='+n.event.id+'">event</a>:<br/> <b>"'+n.event.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "JOINEDEVENT"){
                                                       html = '<li><div class="notification JOINEDEVENT"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> joined the <a href="eventwall.jsp?eid='+n.event.id+'">event</a>:<br/> <b>"'+n.event.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "POSTCOMMENT"){
                                                       html = '<li><div class="notification JOINEDEVENT"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> commented on the <a href="communitywall.jsp?eid='+n.post.id+'">post</a>:<br/> <b>"'+n.post.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   
                                                   $("#nHolder").append(html);
                                               }
                                               
                                            }                                            
                                        }
                                        else{
                                            //toastr.error("There was a problem liking this post. Please try again later.");
                                        }
                                    }
                                });
                                
                                setTimeout(retrieveNotifications,10000);
                            }
                           
                            
                            function acceptFriend(postId){
                                var dat = new Object();
                                dat.postId = postId;
                                dat.isALike = true;

                                console.log(JSON.stringify(dat));
                                $("#post-"+postId+" .postLikeBtn").addClass("disabled");

                                $.ajax({
                                    type: "POST",
                                    url: "/json/community/likeOrUnlikePost.jsp",
                                    data: dat,
                                    success: function(data, textStatus, xhr) {
                                        console.log(xhr.status);
                                    },
                                    complete: function(xhr, textStatus) {
                                        if(xhr.status === 200){
                                            $("#post-"+postId+" .postLikeBtn").removeClass("disabled");
                                            // disable like button
                                            $("#post-"+postId+" .postLikeBtn .txt").text("You like");
                                            $("#post-"+postId+" .postLikeBtn .iconLike").attr("class","icon-ok iconLike");
                                            $("#post-"+postId+" .postLikeBtn").attr("onclick","unlikePost("+postId+")");
                                        }
                                        else{
                                            toastr.error("There was a problem liking this post. Please try again later.");
                                        }
                                    } 
                                });
                            }

                            function rejectFriend(postId){
                                var dat = new Object();
                                dat.postId = postId;
                                dat.isALike = false;

                                console.log(JSON.stringify(dat));
                                $("#post-"+postId+" .postLikeBtn").addClass("disabled");

                                $.ajax({
                                    type: "POST",
                                    url: "/json/community/likeOrUnlikePost.jsp",
                                    data: dat,
                                    success: function(data, textStatus, xhr) {
                                        console.log(xhr.status);
                                    },
                                    complete: function(xhr, textStatus) {
                                        if(xhr.status === 200){
                                            $("#post-"+postId+" .postLikeBtn").removeClass("disabled");
                                            // enable like button
                                            $("#post-"+postId+" .postLikeBtn .txt").text("Like");
                                            $("#post-"+postId+" .postLikeBtn .iconLike").attr("class","icon-heart iconLike");
                                            $("#post-"+postId+" .postLikeBtn").attr("onclick","likePost("+postId+")");
                                        }
                                        else{
                                            toastr.error("There was a problem unliking this post. Please try again later.");
                                        }
                                    } 
                                });
                            }
                        </script>
                        <!-- Notification Scripts End -->
                        
                     </li>
</ul> 