<div class="">
    <c:if test = "${param.createsuccess == 'false'}">
        <div><br/></div>
        <div class="login alert alert-error">
            <b>Whoops.</b> There was an error processing your request. Please try again!
        </div>
    </c:if> 
    <c:if test = "${param.createsuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.createmsg} was added!
        </div>
    </c:if>
    <c:if test = "${param.deletesuccess == 'false'}">
        <div><br/></div>
        <div class="login alert alert-error">
            <b>Whoops.</b> The field could not be deleted.
        </div>
    </c:if> 
    <c:if test = "${param.featuresuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.featuremsg} was successfully featured!
        </div>
    </c:if>

    <c:if test = "${param.featuresuccess == 'false'}">
        <div><br/></div>
        <div class="login alert alert-error">
            <b>Whoops.</b> Post was unable to be featured.
        </div>
    </c:if> 
    <c:if test = "${param.unfeaturesuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.featuremsg} was successfully un-featured!
        </div>
    </c:if>
    <c:if test = "${param.unfeaturesuccess == 'false'}">
        <div><br/></div>
        <div class="login alert alert-error">
            <b>Whoops.</b> Post was unable to be featured.
        </div>
    </c:if> 


    <c:if test = "${param.deletesuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.deletemsg} was successfully deleted!
        </div>
    </c:if>




    <c:if test = "${param.approvesuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.approvemsg} was added!
        </div>
    </c:if>
    <c:if test = "${param.editsuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.editmsg} was successfully edited!
        </div>
    </c:if>
    <c:if test = "${param.createFTsuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.createFTmsg} was successfully created! You can now create a new facility for this Facility Type.
        </div>
    </c:if>
    <c:if test = "${param.paysuccess == 'true'}">
        <div><br/></div>
        <div class="login alert alert-success">
            <b>Done!</b> ${param.paymsg}'s booking payment details has been updated!
        </div>
    </c:if>
    <c:if test = "${param.paysuccess == 'false'}">
        <div><br/></div>
        <div class="login alert alert-error">
            <b>Whoops.</b> ${param.paymsg}'s booking payment details could not be edited.
        </div>
    </c:if>
</div>