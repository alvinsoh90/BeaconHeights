<div class="navbar navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="#">LivingNet Admin</a>
            <div class="btn-group pull-right">
                <a class="btn" href="my-profile.html"><i class="icon-user"></i> Admin</a>
                <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="/residents/index.jsp"><i class="icon-forward"></i> Go to Resident View</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                    <stripes:link href="/stripes/LogoutActionBean.action"><i class="icon-off"></i> Logout</stripes:link>
                    </li>
                </ul>
            </div>
            <div class="nav-collapse">
                <ul class="nav">
                    <li><a href="mainadmin.jsp">Home</a></li>
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Users <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="new-user.jsp">New User</a></li>
                            <li class="divider"></li>
                            <li><a href="users.jsp">Manage Users</a></li>
                        </ul>
                    </li>

                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Facilities <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="new-user.jsp">Manage Bookings</a></li>
                            <li><a href="users.jsp">Manage Facilities</a></li>
                            <li><a href="users.jsp">Manage Facilities Types</a></li>
                        </ul>
                    </li>            
<!--
                    <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Roles <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="new-role.html">New Role</a></li>
                            <li class="divider"></li>
                            <li><a href="roles.html">Manage Roles</a></li>
                        </ul>
                    </li>
                    <li><a href="stats.html">Stats</a></li>-->
                </ul>
            </div>
        </div>
    </div>
</div>