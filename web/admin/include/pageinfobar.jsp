<div class="">
                        <c:if test = "${param.createsuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error">
                                <b>Whoops.</b> There was an error creating a user. Please try again!
                            </div>
                        </c:if> 
                        <c:if test = "${param.createsuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success">
                                <b>Awesome!</b> ${param.createmsg} was added to the user list!
                            </div>
                        </c:if>
                        <c:if test = "${param.deletesuccess == 'false'}">
                            <div><br/></div>
                            <div class="login alert alert-error">
                                <b>Whoops.</b> The user could not be deleted.
                            </div>
                        </c:if> 
                        <c:if test = "${param.deletesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success">
                                <b>Awesome!</b> ${param.deletemsg} was successfully deleted!
                            </div>
                        </c:if>
                        <c:if test = "${param.approvesuccess == 'true'}">
                            <div><br/></div>
                            <div class="login alert alert-success">
                                <b>Awesome!</b> ${param.approvemsg} was added to the user list!
                            </div>
                        </c:if>
                    </div>