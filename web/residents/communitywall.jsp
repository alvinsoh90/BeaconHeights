<%-- 
    Document   : communitywall
    Created on : Jan 27, 2013, 11:36:07 PM
    Author     : fayannefoo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Community Wall | Beacon Heights</title>
        <%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <jsp:useBean id="managePostBean" scope="page"
                     class="com.lin.resident.ManagePostBean"/>
        <jsp:useBean id="manageEventBean" scope="page"
                     class="com.lin.resident.ManageEventBean"/>
        <%@include file="/protect.jsp"%>


        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <meta name="apple-mobile-web-app-capable" content="yes">    

        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="./css/bootstrap-responsive.min.css" rel="stylesheet">

        <%@include file="/header.jsp"%>
        <%@include file="/analytics/analytics.jsp"%>

        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet">
        <link href="./css/font-awesome.css" rel="stylesheet">

        <link href="./css/pages/dashboard.css" rel="stylesheet"> 
        <script src="./js/jquery-1.7.2.min.js"></script>
        <script src="/js/toastr.js"></script>
        <link href="/css/toastr.css" rel="stylesheet" />
        <link href="/css/toastr-responsive.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery.tokeninput.js"></script>
        <script type="text/javascript" src="/js/jquery.tipsy.js"></script>
        <link rel="stylesheet" href="/css/token-input.css" type="text/css" />
        <link rel="stylesheet" href="/css/token-input-facebook.css" type="text/css" />
        <link rel="stylesheet" href="/css/tipsy.css" type="text/css" />
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/jquery.validate.bootstrap.js"></script>                
        <script src="./js/bootstrap.js"></script>

        <script>
            var successStatus = "${SUCCESS}";
            if(successStatus == "true"){
                toastr.success("Successfully posted on the community wall!");
            }else if(successStatus == "false"){
                toastr.error("Sorry, there was a problem posting your entry. Please try again later.");
            }
            
            // ** Handle posting ** //
            
            var inviteDefaultTitle = "invites the community";
            var announcementDefaultTitle = "this is announcmentsia";
            var shoutoutDefaultTitle = "says.."
            var requestDefaultTitle = "made a request"
            var defaultTitle = shoutoutDefaultTitle;
            
            var defaultPostContent = "Enter your message to the community..."
            
            $(document).ready(function(){
                $("#postTitle").val(defaultTitle);
                $("#postContent").val(defaultPostContent);
               
                $("#postTitle").focusin(function(){
                    if ($(this).val() == defaultTitle) $(this).val("");  
                });
                $("#postTitle").focusout(function(){
                    if ($(this).val() == "") $(this).val(defaultTitle);  
                });
               
                $("#postOption").change(function(){
                    changeDefaultPostTitle(); 
                });
               
                $("#postContent").focusin(function(){
                    if ($(this).val() == defaultPostContent) $(this).val("");  
                });
                $("#postContent").focusout(function(){
                    if ($(this).val() == "") $(this).val(defaultPostContent);  
                });
               
                $("#submitPost").click(function(){
                    if ($("#postContent").val() == defaultPostContent)  {
                        $("#postContent").val("");
                        toastr.error("Please enter a message for your post");
                    }
                });
                
                function changeDefaultPostTitle(){
                    var postType = $('select#postOption option:selected').val();
                
                    if(postType == "INVITE"){
                        defaultTitle = inviteDefaultTitle;
                    }
                    else if(postType == "SHOUTOUT"){
                        defaultTitle = shoutoutDefaultTitle;
                    }
                    else if(postType == "REQUEST"){
                        defaultTitle = requestDefaultTitle;
                    }
                    else if(postType == "ANNOUNCEMENT"){
                        defaultTitle = announcementDefaultTitle;
                    }
                
                    $("#firstPostIcon").removeClass("INVITE");
                    $("#firstPostIcon").removeClass("SHOUTOUT");
                    $("#firstPostIcon").removeClass("REQUEST");
                    $("#firstPostIcon").removeClass("ANNOUNCEMENT");
                
                    $("#firstPostIcon").addClass(postType);
                    $("#postTitle").val(defaultTitle);
                }
               
                //* Handle Commentng *//
               
                //handlers for making comment
                $(".commentTextArea").each(function(){
                    $(this).keypress(function(e) {
                        if(e.which == 13) {
                            var postId = $(this).attr("data-post-id");
                            var content = $(this).val();
                            postComment(postId,content);
                        }
                    });                   
                });
            });
            
            
            
            function postComment(postId, commentContent){
                
                var dat = new Object();
                dat.postId = postId;
                dat.content = commentContent;
                dat.posterId = ${user.userId};
                
                console.log(JSON.stringify(dat));
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/commentOnCommunityWallPost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            refreshPost(postId);
                            //setTimeout('window.location.href="/admin/manage-facilitytypes.jsp"',1300);
                        }
                        else{
                            toastr.error("There was a problem leaving a comment. Please try again later.");
                        }
                    } 
                });
            }
            
            function likePost(postId){
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
            
            function unlikePost(postId){
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
            
            function flagPostInappropriate(postId){
                var dat = new Object();
                dat.postId = postId;
                dat.isInappropriate = true;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .flagInappropriateBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/flagOrUnflagInappropriate.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        if(xhr.status === 200){
                            if(!data.flag_success && data.reason){
                                toastr.error(data.reason);
                            }
                            $("#post-"+postId+" .flagInappropriateBtn").removeClass("disabled");
                            // disable button
                            $("#post-"+postId+" .flagInappropriateBtn .txt").text("Post flagged (click to undo)");
                            $("#post-"+postId+" .flagInappropriateBtn").attr("onclick","unFlagPostInappropriate("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    }
                });
            }
            
            function unFlagPostInappropriate(postId){
                var dat = new Object();
                dat.postId = postId;
                dat.isInappropriate = false;
                
                console.log(JSON.stringify(dat));
                $("#post-"+postId+" .flagInappropriateBtn").addClass("disabled");
                
                $.ajax({
                    type: "POST",
                    url: "/json/community/flagOrUnflagInappropriate.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(xhr.status);
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                            $("#post-"+postId+" .flagInappropriateBtn").removeClass("disabled");
                            // disable like button
                            $("#post-"+postId+" .flagInappropriateBtn .txt").text("Flag as inappropriate");
                            $("#post-"+postId+" .flagInappropriateBtn").attr("onclick","flagPostInappropriate("+postId+")");
                        }
                        else{
                            toastr.error("There was a problem flagging this post. Please contact us directly at helpdesk@beaconheights.com.sg");
                        }
                    } 
                });
            }
            
            var r;
            function refreshPost(postId){
                //fade out comment area
                $("#post-" + postId + " .commentArea .comments").css("opacity","0.6");
                //show ajax loading
                $("#post-" + postId + " .commentArea .ajaxSpinnerSmall").show();
                
                var dat = new Object();
                dat.postId = postId;
                
                //post comment
                $.ajax({
                    type: "POST",
                    url: "/json/community/getCommentsForPost.jsp",
                    data: dat,
                    success: function(data, textStatus, xhr) {
                        console.log(data.comments);
                        r = data.comments[0];
                        $("#post-" + postId + " .commentArea .comments").html(""); 
                            
                        //loop thru retrieved comments and append to html
                        for(var i=0;i<data.comments[0].length;i++){
                            var c = data.comments[0][i];
                            $("#post-" + postId + " .commentArea .comments").append(
                            '<div class="comment"><img src="/uploads/profile_pics/'+c.user.profilePicFilename+'" class="profilePic float_l"><div class="content float_l"><b>'+c.user.escapedFirstName + ' ' + c.user.escapedLastName +': </b>'+c.text+'<div class="timestamp">'+c.timeSinceComment+'</div></div><br class="clearfix"></div>'
                        )
                        }

                        //after done, fade in comment area
                        $("#post-" + postId + " .commentArea .comments").css("opacity","1");
                        //clear comment input box
                        $("#post-" + postId + " .commentArea .commentTextArea").val("");   
                        //hide ajax loading
                        $("#post-" + postId + " .commentArea .ajaxSpinnerSmall").hide();
                    },
                    complete: function(xhr, textStatus) {
                        if(xhr.status === 200){
                        }
                        else{
                            $("#post-" + postId + " .commentArea .comments").css("opacity","1");
                            toastr.error("There was a problem leaving a comment. Please try again later.");
                        }
                    } 
                });
                                             
            }
            
        </script>

        <script>
            // ** Handle friend tagging ** //
    
            var start=/@/ig; // @ Match
            var word=/@(\w+)/ig; //@abc Match
    
            var latestFriendList;
    
            function tagFriendAndReplaceByIdx(idx){
                var content = $("#postContent").val();

                var symbol = content.match(start); //Content Matching @
                var name = content.match(word);
        
                console.log("old content: " + content + ".. looking to replace == " + name);
        
                content = content.replace(name, "<div><a href='./profile.jsp?profileid='>"
                    + latestFriendList[idx].name + "</div></a>");
        
                $("#postContent").append(content);
                console.log("new content: " + content);
            }
    

            //Watch for @
            $("#postContent").on('keyup',function(){
                var content = $("#postContent").val();
        
                var symbol = content.match(start); //Content Matching @
                var name = content.match(word);
        
        
                // if @name is found
                if(symbol != null){ 
                    //make ajax call
                    console.log("make ajax");
            
                    var dat = new Object();
                    dat.userId = '${sessionScope.user.userId}';
                    console.log(name[0]);
                    dat.searchString = name[0].substring(1);                   
                } 
            });
    
            var taggedFriendsList = [];
    
            $(document).ready(function() {
                $("#tagFriendsBox").tokenInput("/json/community/getUserTaggableFriends.jsp", {
                    theme: "facebook",
                    queryParam:"searchString",
                    jsonContainer:"friendList",
                    searchingText:"Searching friends...",
                    hintText:"Enter a friend's name",
                    resultsFormatter: function(item){ return "<li>" + "<img class='resultsPic' src='/uploads/profile_pics/" + item.profilePic + "' title='" + item.name + "' />" + "<div style='display: inline-block; padding-left: 10px;'><div class='resultsName'>" + item.name + "</div><div class='resultsUsername'>" + item.username + "</div></div></li>" },
                    onAdd: function(item){
                        taggedFriendsList.push(item.userId);
                        $("#taggedFriends").val(JSON.stringify(taggedFriendsList));
                    },
                    onDelete: function(item){
                        var idx = taggedFriendsList.indexOf(item.userId);
                        if(idx!=-1) taggedFriendsList.splice(idx,1);
                        $("#taggedFriends").val(JSON.stringify(taggedFriendsList));
                    }
                });
            });
    
        </script>

    </head>
    <body>


        <div id="content">

            <div class="container">
                <div class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${user.profilePicFilename}" class="profilePic" />
                            <div class="name">${user.firstname} ${user.lastname}</div>
                        </div>
                        <div id="firstPostIcon" class="postIcon wallicon SHOUTOUT">
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post span6">
                    <div class="baseContent newPost">
                        <stripes:form id="makePostForm" beanclass="com.lin.resident.AddPostActionBean" focus="postContent">
                            <div class="inlineblock name">${user.firstname} ${user.lastname}  </div>
                            <stripes:text id="postTitle" name="postTitle" class="postTitleArea span3" />
                            <stripes:textarea id="postContent" name="postContent" class="makePost" />
                            Tag Event:
                            <stripes:select name="eventId">
                                <c:set value="${manageEventBean.getAllFutureEventsForUser(user)}" var="futureBookingList" />
                                <c:choose>
                                    <c:when test="${not empty futureBookingList}">
                                        <option value="-1">Select an event</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="-1">No events available</option>
                                    </c:otherwise>
                                </c:choose>

                                <c:forEach items="${futureBookingList}" var="event">
                                    <option value="${event.id}">${event.title} 
                                        on <fmt:formatDate pattern="dd/MM @ hh:mm a" value="${event.startTime}" /></option>
                                    </c:forEach>       

                            </stripes:select>
                            <br/>
                            Tag Friends: <input text="text"  id="tagFriendsBox" />
                            <stripes:hidden name="taggedFriends" id="taggedFriends" />
                            <br/>
                            <stripes:hidden name="posterId" id="posterID" value='${sessionScope.user.userId}'/> 
                            <div class="optionsBar">
                                <span>Type:</span> <stripes:select name="postCategory" id="postOption">
                                    <option value="SHOUTOUT">Shout Out</option>
                                    <option value="INVITE">Event Invitation</option>                                                                   
                                    <option value="REQUEST">Request</option> 
                                </stripes:select>
                                <stripes:hidden name="wallId" id="wallId" value="-1"/> 
                                <stripes:submit id="submitPost" class="float_r btn btn-peace-1" name="addPost" value="Post to Wall"/> 
                            </stripes:form>
                        </div>
                    </div>
                </div>
                <div class="featured">
                    <section class="featuredTitle"> FEATURED</section>
                    <section class="featuredPost">
                        <div class="featuredProfile">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic"/>
                            <a href="profile.jsp?profileid=${post.user.userId}"><div class="name">${post.user.firstname} ${post.user.lastname}</div></a>
                        </div>
                        POST<hr/>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Duis ligula arcu, luctus nec elementum quis, condimentum a lectus. 
                        Suspendisse potenti. Proin neque diam, dictum ac elementum scelerisque, 
                        aliquet eget diam....
                    </section>
                </div>


            </div>


            <c:forEach items="${managePostBean.postList}" var="post" varStatus="loop">

                <div id="post-${post.postId}" class="postWrapper row-fluid">
                    <div class="leftContent span2">
                        <div class="posterInfo">
                            <img src="/uploads/profile_pics/${post.user.profilePicFilename}" class="profilePic" />
                            <a href="profile.jsp?profileid=${post.user.userId}"><div class="name">${post.user.firstname} ${post.user.lastname}</div></a>
                            <div class="timestamp">${post.timeSincePost}</div>
                        </div>
                        <div class="postIcon wallicon ${post.category}">
                            <div class="timeline"/></div>
                    </div>
                </div>
                <div class="post span6">
                    <div class="baseContent">
                        <div class="title"><b><a href="profile.jsp?profileid=${post.user.userId}">${post.user.firstname} ${post.user.lastname}</b></a> ${post.title}</div>
                        <div class="content">"${post.message}"</div>


                        <c:set var="taggedUsers" value="${managePostBean.getTaggedUsers(post.postId,-1)}"/>

                        <c:if test="${not empty taggedUsers}">
                            <div class="taggedUsers">
                                Tagged:
                                <c:forEach items="${taggedUsers}" var="tagged" varStatus="status">
                                    <a href="profile.jsp?profileid=${tagged.userId}"><img title="${tagged.firstname} ${tagged.lastname}" class="liker" src='/uploads/profile_pics/${tagged.profilePicFilename}' height="25px" width="25px" class="float_l"/></a>
                                    </c:forEach>
                            </div>    
                        </c:if>


                        <c:if test="${post.event != null}">
                            <div class="attachment event">
                                <div class="eventTitle"><a href="eventpage.jsp?eventid=${post.event.id}">${post.event.title}</a></div>
                                <div class="eventMeta">
                                    <b>Venue:</b> ${post.event.venue} <br/>                                    
                                    <b>Date/Time:</b> ${post.event.formattedEventTime}
                                </div>
                            </div>
                        </c:if>

                        <div class="linkBar">
                            <!--<a class="btn btn-mini btn-peace-2"><i class="icon-check"></i> I'm going!</a>-->

                            <%-- Check if user likes this post --%>
                            <c:choose>
                                <c:when test="${managePostBean.hasUserLikedPost(post.postId, sessionScope.user.userId)}">
                                    <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="unlikePost(${post.postId})"><i class="iconLike icon-ok"></i> <span class="txt">You Like</span></a>
                                </c:when>
                                <c:otherwise>
                                    <a class="btn btn-mini btn-rhubarbarian-3 postLikeBtn" onclick="likePost(${post.postId})"><i class="iconLike icon-heart"></i> <span class="txt">Like</span</a>
                                </c:otherwise>    
                            </c:choose>                                

                            <!--<a class="btn btn-mini btn-decaying-with-elegance-3"><i class="icon-eye-open"></i> View Event</a> -->
                            <a href="#flag" onclick="flagPostInappropriate(${post.postId})" class="float_r flagPost flagInappropriateBtn"><i class="icon-flag"></i> <span class="txt">Flag as inappropriate</span></a>
                        </div>
                    </div>
                    <div class="commentArea">
                        <div class="comments">
                            <c:forEach items="${managePostBean.sortCommentsByDate(post.comments)}" var="comment" varStatus="loop">
                                <div class="comment">
                                    <img src="/uploads/profile_pics/${comment.user.profilePicFilename}" class="profilePic float_l"/>
                                    <div class="content float_l">
                                        <b>${comment.user.firstname} ${comment.user.lastname}: </b>${comment.text}
                                        <div class="timestamp">${comment.timeSinceComment}</div>
                                    </div>
                                    <br class="clearfix"/>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="comment replyArea">
                            <img src="/uploads/profile_pics/${sessionScope.user.profilePicFilename}" class="profilePic float_l" />
                            <input class="float_l commentTextArea" data-post-id="${post.postId}" placeholder="Say something here..."/><div class="float_r ajaxSpinnerSmall hide"></div>
                            <br class="clearfix"/>
                        </div>


                    </div>
                </div>
                <div class="span2 postSideBlock">

                </div>                                
            </div>
        </c:forEach>

    </div>
</div>
<div id="footer">

    <div class="container">				

        <p><center><a href="mailto:helpdesk@beaconheights.com.sg">
                Facing Technical Issues? Contact the LivingNet help desk</a></center></p>
    </div> <!-- /container -->

</div> <!-- /footer -->
<script>
    $(document).ready(function() { 
                
        $("#makePostForm").validate({
            rules: {
                postTitle: "required",
                postContent: "required"                        
            },
            messages :{
                postTitle: "",
                postContent: ""
            },
                        
            submitHandler: function(form) {
                formAjaxSubmit();     
                //slotDataHasError
            }
                        
        });        
    });       
</script>


</body>
</html>
