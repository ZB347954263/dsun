<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<title>项目管理</title>
<meta name="decorator" content="ani" />
<script src="${ctxStatic}/plugin/js-menu/contabs.js"></script>
<script src="${ctxStatic}/common/js/fullscreen.js"></script>
<%-- <link id="theme-tab" href="${ctxStatic}/plugin/js-menu/menuTab-${cookie.theme.value==null?'lynch':cookie.theme.value}.css" rel="stylesheet" /> --%>
<link id="theme-tab"
    href="${ctxStatic}/plugin/js-menu/menuTab-lynch.css" rel="stylesheet" />
<%@ include file="/webpage/include/systemInfoSocket-init.jsp"%>
<%@ include file="/webpage/include/layIM-init.jsp"%>
<style type="text/css">
.side-widgets {
 height: calc(100% - 92px);
}
#sidebar div.side-widgets .widgets-content {
     display: block;
     height: 100%;
     position: relative;
     overflow: scroll;
     overflow-x: hidden;
     top: 0;
     right: 0;
     bottom: 0;
     left: 0;
     margin-right: -17px;
}
.side-widgets .nano-pane {
    background: rgba(0,0,0,.25);
    display: block;
    position: absolute;
    width: 10px;
    right: 0;
    top: 0;
    bottom: 0;
    visibility: hidden\9;
    opacity: .01;
    transition: .2s;
    border-radius: 5px;
}
.side-widgets .nano-pane .nano-slider{
     background-color: #aaaaaa;
     opacity: 0.3;
     position: relative;
     margin: 0 1px;
     border-radius: 3px;
}

.side-widgets:hover .nano-pane{
    opacity: .99;
} 
.side-widgets .menu {
    top: 0;
}

.topnav-navbar {
    left: 0px;
    width: 100%;
    background: url(${ctxStatic}/common/images/bg-shouyeyemei3.png)
        no-repeat;
    background-size: 100% 100%;
}

.topnav-navbar .navbar-header {
    background: none;
    width: 30rem;
}

.topnav-navbar .collapse.navbar-collapse {
    background: none;
}

#sidebar {
    height: 100%;
    top: 52px;
    bottom: 0;
    left: 0;
    right: 0;
    -webkit-transition-timing-function: cubic-bezier(0.86, 0, 0.07, 1);
    transition-timing-function: cubic-bezier(0.86, 0, 0.07, 1);
    z-index: 999999;
    background-color: #566e87;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -moz-transition: left 0.3s;
    -o-transition: left 0.3s;
    -webkit-transition: left 0.3s;
    transition: left 0.3s;
    -webkit-box-shadow: 3px 0 6px rgba(0, 0, 0, 0.3);
    -moz-box-shadow: 3px 0 6px rgba(0, 0, 0, 0.3);
    box-shadow: 3px 0 6px rgba(0, 0, 0, 0.3);
    background-image: url(${ctxStatic}/common/images/bg-cloudy-light.png);
    background-size: 240px 100%;
    background-repeat: no-repeat;
}

#sidebar .sidenav-outer {
    top: 0px;
}

.side-widgets .menu {
    background: none;
}

.panel a .fa {
    float: right;
}

.nav-stacked>li {
    padding: 4px 10px;
    width: 100%;
}

.menu-body>.nav>li {
    padding: 4px 10px;
    width: 100%;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}

.menu-body>.nav>li>a {
    position: relative;
    display: block;
    padding: 10px 15px 10px 25px;
    color: #ffffff;
    display: block;
    -moz-border-radius: 0;
    -webkit-border-radius: 0;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -moz-transition: all 0.3s;
    -o-transition: all 0.3s;
    -webkit-transition: all 0.3s;
    transition: all 0.3s;
    -webkit-border-radius: 6px;
    border-radius: 6px;
}

.nav li ul li a {
    padding-left: 20px;
}

.nav>li>a[aria-expanded="true"], .nav>li>a:hover, .nav>li>a:focus {
    text-decoration: none;
    color: #ffffff;
    background-color: #7CB342;
    -moz-border-radius: 6px;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    -moz-border-radius-bottomleft: 0;
    -webkit-border-bottom-left-radius: 0;
    border-bottom-left-radius: 0;
    -moz-border-radius-bottomright: 0;
    -webkit-border-bottom-right-radius: 0;
    border-bottom-right-radius: 0;
    -webkit-box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.14), 0 7px 10px -5px
        rgba(60, 72, 88, 0.3), 0 7px 10px -5px rgba(60, 72, 88, 0.1);
    -moz-box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.14), 0 7px 10px -5px
        rgba(60, 72, 88, 0.3), 0 7px 10px -5px rgba(60, 72, 88, 0.1);
    box-shadow: 0 4px 20px 0 rgba(0, 0, 0, 0.14), 0 7px 10px -5px
        rgba(60, 72, 88, 0.3), 0 7px 10px -5px rgba(60, 72, 88, 0.1);
}

.nav>li>ul>li>a[aria-expanded="true"], .nav>li>ul>li>a:hover, .nav>li>ul>li>a:focus
    {
    color: #9CCC65;
    background-color: #3a4757;
}

.nav li ul[aria-expanded="true"] li  ul[aria-expanded="true"] {
    padding-left: .5rem;
}

.menu-body>.nav > li > ul {
    padding-left: .5rem;
    border: 1px #a7a6a6 solid;
    background-color: rgba(255, 255, 255, 0.2);
    -moz-border-radius-bottomleft: 6px;
    -webkit-border-bottom-left-radius: 6px;
    border-bottom-left-radius: 6px;
    -moz-border-radius-bottomright: 6px;
    -webkit-border-bottom-right-radius: 6px;
    border-bottom-right-radius: 6px;
    overflow: hidden;
    list-style-type: none;
}

.menu-body>.nav>li>ul.collapse, li>ul.collapse {
    border: 1px #a7a6a6 solid;
}

.nav li ul li {
    padding: 4px 0;
}

.nav li>ul>li>ul {
    border: solid #9cabc0 0.5px;
    border-bottom-right-radius: 6px;
    border-bottom-left-radius: 6px;
}

.nav>li>.nav>li>.nav>li>.nav>li>a {
    position: relative;
    display: block;
    padding: 10px 0px 10px 50px;
}

.nav>li>.nav>li>.nav>li>a {
    position: relative;
    display: block;
    padding: 10px 0px 10px 50px;
}

.topnav-navbar .navbar-form .form-control, .navbar-form {
    color: #ffff;
}

.panel a i[class] {
    float: right;
    position: absolute;
    top: 12.5px;
    right: 5px;
}

.side-widgets .menu {
    overflow-y: unset;
}
</style>
</head>

<body class="">
    <nav class="navbar topnav-navbar navbar-fixed-top" role="navigation">
        <div class="navbar-header text-center">
            <!-- <button type="button" class="navbar-toggle" id="showMenu" >
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button> -->
            <a class="navbar-brand J_menuItem" href="${ctx}/home"><img
                alt="logo" src="${ctxStatic}/common/images/logo-1.png"
                style="position: absolute; top: 0rem; left: .5rem; width: 25rem;">
            </a>
        </div>
        <div class="collapse navbar-collapse">
            <form class="navbar-form navbar-left" role="search">
                <span class="glyphicon glyphicon-search"></span>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="">
                </div>
            </form>
            <ul class="nav navbar-nav">
                <li class="dropdown"><a href="#" class="dropdown-toggle"
                    data-toggle="dropdown" role="button" style="color: #ffff;"><span
                        class="glyphicon glyphicon-envelope"></span><span
                        class="badge badge-green">${noReadCount}</span></a>

                    <ul class="dropdown-menu animated fadeIn">
                        <li class="messages-top text-center">你有 ${noReadCount} 封未读邮件.
                        </li>

                        <c:forEach items="${mailPage.list}" var="mailBox">

                            <li class="dropdown-messages"><a class="J_menuItem"
                                title="站内信" href="${ctx}/iim/mailBox/detail?id=${mailBox.id}">

                                    <div class="message-sender">
                                        ${mailBox.sender.name }<small class="pull-right">${fns:getTime(mailBox.sendtime)}前</small>
                                    </div>
                                    <div class="message-header">
                                        ${mailBox.mail.overview} <small class="pull-right"> <fmt:formatDate
                                                value="${mailBox.sendtime}" pattern="yyyy-MM-dd HH:mm:ss" /></small>
                                    </div>

                            </a></li>

                        </c:forEach>
                        <li class=" text-center"><a class="J_menuItem"
                            href="${ctx}/iim/mailBox/list?orderBy=sendtime desc"> <font
                                color='gray'> <i class="fa fa-envelope"></i> 查看所有邮件
                            </font>
                        </a></li>
                    </ul></li>
                <li class="dropdown"><a href="#" class="dropdown-toggle"
                    data-toggle="dropdown" role="button" style="color: #ffff;"> <span
                        class="glyphicon glyphicon-bell"></span><span
                        class="badge badge-red">${count }</span>
                </a>
                    <ul class="dropdown-menu animated fadeIn">
                        <li class="messages-top text-center">你有 ${count } 条新通知.</li>

                        <c:forEach items="${page.list}" var="oaNotify">

                            <li class="dropdown-notifications"><a class="J_menuItem"
                                href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}&isSelf=true">
                                    <div class="notification">
                                        <i class="fa fa-bell-o"></i> ${fns:abbr(oaNotify.title,50)} <span
                                            class="pull-right text-muted small">${fns:getTime(oaNotify.updateDate)}前</span>
                                    </div>
                            </a></li>

                        </c:forEach>


                    </ul></li>
            </ul>
            <ul class="nav navbar-nav pull-right navbar-right">
                <li>
                    <div class="row" style="margin: 10px 10px 0 0;">
                        <div class="col-sm-4">
                            <span
                                style="margin: 12px 0 0 0; position: relative; top: 5px; color: #ffff;">Tab</span>
                        </div>
                        <div class="col-sm-8">
                            <div class="onoffswitch">
                                <input type="checkbox" name="onoffswitch"
                                    class="onoffswitch-checkbox" id="switchTab"
                                    ${cookie.tab.value!=false?'checked':''}> <label
                                    class="onoffswitch-label" for="switchTab"> <span
                                    class="onoffswitch-inner"></span> <span
                                    class="onoffswitch-switch"></span>
                                </label>
                            </div>
                        </div>
                    </div>

                </li>
                <!--
                <li class="dropdown color-picker">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                        <span><i class="fa fa-circle"></i></span>
                    </a>
                    <ul class="dropdown-menu pull-right animated fadeIn" role="menu">
                        <li class="padder-h-xs">
                            <table class="table color-swatches-table text-center no-m-b">
                                <tr>
                                    <td class="text-center colorr">
                                        <a href="#" data-theme="blue" class="theme-picker">
                                            <i class="fa fa-circle blue-base"></i>
                                        </a>
                                    </td>
                                    <td class="text-center colorr">
                                        <a href="#" data-theme="green" class="theme-picker">
                                            <i class="fa fa-circle green-base"></i>
                                        </a>
                                    </td>
                                    <td class="text-center colorr">
                                        <a href="#" data-theme="red" class="theme-picker">
                                            <i class="fa fa-circle red-base"></i>
                                        </a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center colorr">
                                        <a href="#" data-theme="purple" class="theme-picker">
                                            <i class="fa fa-circle purple-base"></i>
                                        </a>
                                    </td>
                                    <td class="text-center color">
                                        <a href="#" data-theme="midnight-blue" class="theme-picker">
                                            <i class="fa fa-circle midnight-blue-base"></i>
                                        </a>
                                    </td>
                                    <td class="text-center colorr">
                                        <a href="#" data-theme="lynch" class="theme-picker">
                                            <i class="fa fa-circle lynch-base"></i>
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </li>
                    </ul>
                </li>
                --->
                <li><a href="#" onClick="toggleFullScreen()"
                    style="color: #ffff;"> <span>全屏 </span>
                </a></li>


                <li class="dropdown admin-dropdown"><a href="#"
                    class="dropdown-toggle" data-toggle="dropdown" role="button"
                    aria-expanded="false" style="color: #ffff;"> <img
                        src="<c:if test="${fns:getUser().photo == null || fns:getUser().photo==''}">${ctxStatic}/common/images/flat-avatar.png</c:if> <c:if test="${fns:getUser().photo != null && fns:getUser().photo!=''}">${fns:getUser().photo}</c:if>"
                        class="topnav-img" alt=""><span class="hidden-sm">${fns:getUser().name}</span>
                </a>
                    <ul class="dropdown-menu animated fadeIn" role="menu">
                        <li><a class="J_menuItem" href="${ctx}/sys/user/imageEdit">修改头像</a>
                        </li>
                        <li><a class="J_menuItem" href="${ctx }/sys/user/info">个人资料</a>
                        </li>
                        <li><a class="J_menuItem" href="${ctx }/iim/contact/index">我的通讯录</a>
                        </li>
                        <li><a class="J_menuItem" href="${ctx }/iim/mailBox/list">信箱</a>
                        </li>
                        <li><a href="${ctx}/logout">安全退出</a></li>
                    </ul></li>
            </ul>
        </div>
        <ul class="nav navbar-nav pull-right hidd">
            <li class="dropdown admin-dropdown"><a href="#"
                class="dropdown-toggle" data-toggle="dropdown" role="button"
                aria-expanded="false"> <img src="${fns:getUser().photo }"
                    class="topnav-img" alt=""><span class="hidden-sm">${fns:getUser().name}</span>
            </a>
                <ul class="dropdown-menu animated fadeIn" role="menu">
                    <li><a class="J_menuItem" href="${ctx}/sys/user/imageEdit">修改头像</a>
                    </li>
                    <li><a class="J_menuItem" href="${ctx }/sys/user/info">个人资料</a>
                    </li>
                    <li><a class="J_menuItem" href="${ctx }/iim/contact/index">我的通讯录</a>
                    </li>
                    <li><a class="J_menuItem" href="${ctx }/iim/mailBox/list">信箱</a>
                    </li>
                    <li><a href="${ctx}/logout">安全退出</a></li>
                </ul></li>
        </ul>
    </nav>
    <aside id="sidebar">
        <div class="sidenav-outer">
            <div class="side-widgets">
                <%-- <div class="text-center" style="padding-top:10px;"> 
                <a  href="#"><img class="img-circle user-avatar"  src="<c:if test="${fns:getUser().photo == null || fns:getUser().photo==''}">${ctxStatic}/common/images/flat-avatar.png</c:if> <c:if test="${fns:getUser().photo != null && fns:getUser().photo!=''}">${fns:getUser().photo}</c:if>" class="user-avatar" /></a>
                <li class="dropdown admin-dropdown" style="padding-top:10px;">
                    <a href="#" class="dropdown-toggle"  data-toggle="dropdown" role="button" aria-expanded="false">
                        <font color="white">${fns:getUser().name}<b class="caret"></b></font>
                    </a>
                    <ul class="dropdown-menu animated fade in" style="left:35px" role="menu">
                          <li><a class="J_menuItem" href="${ctx}/sys/user/imageEdit">修改头像</a>
                          </li>
                          <li><a class="J_menuItem" href="${ctx }/sys/user/info">个人资料</a>
                          </li>
                          <li><a class="J_menuItem" href="${ctx }/iim/contact/index">我的通讯录</a>
                          </li>
                          <li><a class="J_menuItem" href="${ctx }/iim/mailBox/list">信箱</a>
                          </li> 
                          <hr>
                          <li><a href="${ctx}/logout">安全退出</a>
                          </li>
                    </ul>
                </li>
            </div> --%>

                <div class="widgets-content">
                    <div class="menu">
                        <div class="menu-body">
                            <ul class="nav nav-pills nav-stacked sidenav" id="1">
                                <t:aniMenu menu="${fns:getTopMenu()}"></t:aniMenu>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nano-pane">
                    <div class="nano-slider" style="height: 581px; transform: translate(0px, 0px);"></div></div>
                </div>
            <div
                style="height: 36px; position: fixed; bottom: 0px; width: 220px !important; background-color: rgba(255, 255, 255, 0.2);">
                <a href="javascript:void(0);" class="sidebar-anchor"
                    style="display: inline-block; float: right; margin-right: 15px;"
                    title="收缩" id="onToggleMenu"> <i
                    class="fa fa fa-arrow-circle-left"
                    style="font-size: 2rem; position: relative; top: 5px; color: #fff;"></i>
                </a>
            </div>
        </div>
    </aside>
    <section id="body-container" class="animation">


        <!--选项卡  -->
        <div class="main-container" id="main-container">
            <div class="main-content">
                <div class="main-content-inner">
                    <div id="breadcrumbs"
                        class="${cookie.tab.value!=false?'breadcrumbs':'un-breadcrumbs'}">
                        <div class="content-tabs">
                            <button id="hideMenu" class="roll-nav roll-left-0 J_tabLeft">
                                <i class="fa fa-align-justify"></i>
                            </button>
                            <button class="roll-nav roll-left J_tabLeft">
                                <i class="fa fa-backward"></i>
                            </button>
                            <nav class="page-tabs J_menuTabs">
                                <div class="page-tabs-content">
                                    <a href="javascript:;" class="active J_menuTab"
                                        data-id="${ctx}/home">首页</a>
                                </div>
                            </nav>
                            <button class="roll-nav roll-right J_tabRight">
                                <i class="fa fa-forward"></i>
                            </button>
                            <a href="${ctx}/logout" class="roll-nav roll-right J_tabExit"><i
                                class="fa fa fa-sign-out"></i> 退出</a>
                        </div>
                    </div>

                    <div class="J_mainContent" id="content-main"
                        style="${cookie.tab.value!=false?'height:calc(100% - 40px)':'height:calc(100%)'}">
                        <iframe class="J_iframe" name="iframe0" width="100%" height="100%"
                            src="${ctx}/home" frameborder="0" data-id="${ctx}/home" seamless></iframe>
                    </div>
                </div>


            </div>
        </div>

        <div class="footer">
            <div class="pull-left">
                <a href="/home"></a> www.dsunsoft.com&copy; 2018
            </div>
        </div>

    </section>
    <script>
        $(function() {
            $('li').click( function(e){
                // --因为执行波浪效果需要时间，一次波浪结束之后允许执行下一次点击
                var htmlStr = "<span id='wave' style='position: absolute;width: 10px;height: 10px;transition: all 0.6s ease-in;background-color: white;opacity: .2;border-radius: 35px;'></span>";
                $(this).append(htmlStr);
                //获取点击时的坐标
                var event = e || window.event;
                var x = event.clientX;
                var y = event.clientY;
                //获取按钮的坐标
                var moveX =  $(this).offset().left;
                var moveY =  $(this).offset().top;
                //获取按钮宽度
                var btnWidth =  $(this).prop('clientWidth');
                //设置点击后波浪样式
                document.getElementById("wave").style.borderRadius = 0;
                document.getElementById("wave").style.width = parseInt(btnWidth)*2+'px';
                document.getElementById("wave").style.left = x-moveX-5+'px';
                document.getElementById("wave").style.marginLeft = -btnWidth+'px';
                document.getElementById("wave").style.height = parseInt(btnWidth)*2+'px';
                document.getElementById("wave").style.top = y-moveY-5+'px';
                document.getElementById("wave").style.marginTop = -btnWidth+'px';
                //定时删除波浪
                setTimeout(function(){
                    document.getElementById("wave").remove();
                    oneClick = true;
                },600);
            })
        	$('.widgets-content').scroll(function() {
        		console.log($('.widgets-content').prop('scrollHeight'));
        		console.log($('.widgets-content').height());
        		console.log($('.widgets-content').scrollTop());
        		$('.nano-slider').css({'transform': 'translate(0px, '+$('.widgets-content').scrollTop()+'px)', 'height' : $('.widgets-content').height() * 2 - $('.widgets-content').prop('scrollHeight') + 52 + 'px'});
        	});
            $('#onToggleMenu').click(
                    function() {
                        if ($('#sidebar').css('margin-left') == '0px') {
                            $('#sidebar').css({
                                'margin-left' : '-165px'
                            });
                            $('#body-container').css({
                                'margin-left' : '55px'
                            });
                            $(this).attr('title', '展开');
                            $(this).find('i').removeClass(
                                    'fa-arrow-circle-left').addClass(
                                    'fa-arrow-circle-right');
                        } else {
                            $('#sidebar').css({
                                'margin-left' : '0px'
                            });
                            $('#body-container').css({
                                'margin-left' : '220px'
                            });
                            $(this).attr('title', '收缩');
                            $(this).find('i').removeClass(
                                    'fa-arrow-circle-right').addClass(
                                    'fa-arrow-circle-left');
                        }
                    });
            $('#calendar2').fullCalendar(
                    {
                        eventClick : function(calEvent, jsEvent, view) {
                            alert('Event: ' + calEvent.title);
                            alert('Coordinates: ' + jsEvent.pageX + ','
                                    + jsEvent.pageY);
                            alert('View: ' + view.name);
                        }
                    });
            $('#rtlswitch').click(function() {
                $('body').toggleClass('rtl');
                var hasClass = $('body').hasClass('rtl');
            });
            $('.theme-picker').click(function() {
                changeTheme($(this).attr('data-theme'));
            });
            $('#showMenu').click(function() {
                $('body').toggleClass('push-right');
            });
            $('#hideMenu').click(
                    function() {
                        /*   $('body').removeClass('push-right')
                        $('body').toggleClass('push-left'); */
                        if ($('#sidebar').css('margin-left') == '0px') {
                            $('#sidebar').css({
                                'margin-left' : '-165px'
                            });
                            $('#body-container').css({
                                'margin-left' : '55px'
                            });
                            $(this).attr('title', '展开');
                            $('#onToggleMenu').attr('title', '展开');
                            $('#onToggleMenu').find('i').removeClass(
                            'fa-arrow-circle-left').addClass(
                            'fa-arrow-circle-right');
                        } else {
                            $('#sidebar').css({
                                'margin-left' : '0px'
                            });
                            $('#body-container').css({
                                'margin-left' : '220px'
                            });
                            $(this).attr('title', '收缩');
                            $('#onToggleMenu').attr('title', '收缩');
                            $('#onToggleMenu').find('i').removeClass(
                                    'fa-arrow-circle-right').addClass(
                                    'fa-arrow-circle-left');
                        }
                    });
            $("#switchTab").change(
                    function() {
                        if ($("#switchTab").is(':checked')) {
                            $("#breadcrumbs").attr("class", "breadcrumbs");
                            $("#content-main").css("height",
                                    "calc(100% - 40px)")
                            $.get(
                                    '${pageContext.request.contextPath}/tab/true?url='
                                            + window.top.location.href,
                                    function(result) {
                                    });
                        } else {
                            $("#breadcrumbs").attr("class", "un-breadcrumbs");
                            $("#content-main").css("height", "calc(100%)")
                            $.get(
                                    '${pageContext.request.contextPath}/tab/false?url='
                                            + window.top.location.href,
                                    function(result) {
                                    });
                        }
                    })

        });

        function changeTheme(theme) {
            var link = $('<link>').appendTo('head').attr({
                type : 'text/css',
                rel : 'stylesheet'
            }).attr('href', '${ctxStatic}/common/css/app-' + theme + '.css');

            var tabLink = $('<link>').appendTo('head').attr({
                type : 'text/css',
                rel : 'stylesheet'
            }).attr('href',
                    '${ctxStatic}/plugin/js-menu/menuTab-' + theme + '.css');

            var childrenLink = $('<link>').appendTo(
                    $(".J_iframe").contents().find("head")).attr({
                type : 'text/css',
                rel : 'stylesheet'
            }).attr('href', '${ctxStatic}/common/css/app-' + theme + '.css');

            $.get('${pageContext.request.contextPath}/theme/' + theme + '?url='
                    + window.top.location.href, function(result) {
                $('#theme').remove();
                $('#theme-tab').remove();
                $(".J_iframe").contents().find("#theme").remove();
                link.attr("id", "theme");
                childrenLink.attr("id", "theme");
                tabLink.attr("id", "theme-tab")
            });
        }
    </script>

</body>
</html>