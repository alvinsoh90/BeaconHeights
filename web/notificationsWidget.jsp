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
                                                   console.log(i + " is " + n.type);
                                                   if(n.type == "FRIENDREQUEST"){
                                                       
                                                       html = '<li id="n-'+n.id+'"><div class="notification FRIENDREQUEST"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> would like to be your friend <br/><span id="acceptReject"><a onclick="acceptFriend('+n.senderId+','+n.id+')" href="#">Accept</a> or <a onclick="rejectFriend('+n.senderId+','+n.id+')" href="#">Reject</a></span> <span>'+n.timestamp+'</span></div></div></li>';                                                       
                                                   } 
                                                   else if(n.type == "TAGGEDINPOST"){
                                                       html = '<li><div class="notification TAGGEDINPOST"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> tagged you in a <a href="communitywall.jsp?pid='+n.post.id+'">post</a>:<br/> <b>"'+n.post.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "EVENTCREATED"){
                                                       html = '<li><div class="notification EVENTCREATED"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> is participating in <a href="eventwall.jsp?eid='+n.event.id+'">event</a>:<br/> <b>"'+n.event.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "JOINEDEVENT"){
                                                       html = '<li><div class="notification JOINEDEVENT"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> is participating in <a href="eventwall.jsp?eid='+n.event.id+'">event</a>:<br/> <b>"'+n.event.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
                                                   }
                                                   else if(n.type == "POSTCOMMENT"){
                                                       html = '<li><div class="notification POSTCOMMENT"><div class="float_l"><img src="/uploads/profile_pics/'+ n.senderProfilePhotoFilename +'"/></div><div class="content"><a href="profile.jsp?profileid='+ n.senderId +'"<b>'+ n.senderName +'</b></a> commented on the <a href="communitywall.jsp?eid='+n.post.id+'">post</a>:<br/> <b>"'+n.post.title+'"</b> <span>'+n.timestamp+'</span></div></div></li>';
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
                                //TURN OFF NOTIFICATIONS
                               // setTimeout(retrieveNotifications,15000);
                            }
                           
                            
                            function acceptFriend(friendRequesterId, notificationId){
                                var dat = new Object();
                                dat.friendRequesterId = friendRequesterId;
                                dat.isAccepting = true;
                                dat.notificationId = notificationId;
                                //hello!!
                                console.log(JSON.stringify(dat));

                                $.ajax({
                                    type: "POST",
                                    url: "/json/community/acceptOrRejectFriendship.jsp",
                                    data: dat,
                                    success: function(data, textStatus, xhr) {
                                        if(xhr.status === 200 && data.flag_success){
                                            $("#n-"+notificationId+" #acceptReject").html("You accepted <i class='icon icon-ok'></i>");
                                        }
                                        else{
                                            toastr.error("There was a problem accepting the request. Please try again later.");
                                        }
                                    }

                                });
                            }

                            function rejectFriend(friendRequesterId, notificationId){
                                var dat = new Object();
                                dat.friendRequesterId = friendRequesterId;
                                dat.isAccepting = false;
                                dat.notificationId = notificationId;

                                console.log(JSON.stringify(dat));

                                $.ajax({
                                    type: "POST",
                                    url: "/json/community/acceptOrRejectFriendship.jsp",
                                    data: dat,
                                    success: function(data, textStatus, xhr) {
                                        if(xhr.status === 200 && data.unflag_success){
                                            $("#n-"+notificationId+" #acceptReject").html("You rejected <i class='icon icon-ok'></i>");
                                        }
                                        else{
                                            toastr.error("There was a problem rejecting the request. Please try again later.");
                                        }
                                    }

                                });
                            }
                        </script>
                        <!-- Notification Scripts End -->
                        
                     </li>
</ul> 