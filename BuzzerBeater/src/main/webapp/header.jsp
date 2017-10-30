<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>





<jsp:useBean id="seasonSvc" scope="page" class="eeit.season.model.SeasonService" />

<!--標頭(開始)-->
<nav
	class="navbar navbar-default navbar-fixed navbar-transparent white bootsnav">
	<div class="container">
		<div class="attr-nav">
			<ul>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> 
					<i class="glyphicon glyphicon-pencil"></i></a>
					<!--新刪修"按鈕"(開始)-->
					<ul class="dropdown-menu cart-list">
						<li><h6>
								<a href="#">新增<!--這行的href輸入超連結頁面--></a>
							</h6></li>
						<li><h6>
								<a href="#">刪除<!--這行的href輸入超連結頁面--></a>
							</h6></li>
						<li><h6>
								<a href="#">修改<!--這行的href輸入超連結頁面--></a>
							</h6></li>
					</ul> <!--新刪修"按鈕"(結束)--></li>

				<!--登入登出"按鈕"(開始)-->
				<li >			
					<c:if test="${empty LoginOK}">
						<a href="#" class="cd-signin" onclick="document.getElementById('id01').style.display='block'">
							登入
						</a>
					</c:if>								
					<c:if test="${!empty LoginOK}">		
						<a>			
							<img  src="${pictureUri}"  style="width:25px; height:25px;text-decoration:none;"> 
							<c:set var="var01" value="${LoginOK.name}" />
							${var01}
						</a>
					</c:if>		
				</li>
				<li><a href="GoogleLoginOutServlet" class="cd-signup"" > 
				         <c:choose>
							<c:when test="${empty LoginOK}">
								<c:set var="var02" value="" />
							</c:when>
							<c:otherwise>
								<c:set var="var02" value="登出" />
							</c:otherwise>
						</c:choose> ${var02}
				 </a></li>

				<!--登入登出"按鈕"(結束)-->
			</ul>
		</div>

		<jsp:include page="/header_login.jsp" />

		<div class="navbar-header">
			<!-- 縮小視窗(左列)(開始) -->
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#navbar-menu">
				<i class="fa fa-bars"></i>
			</button>
			<!-- 縮小視窗(左列)(結束) -->
			<!-- logo(開始) -->
			<a class="navbar-brand" href="#brand"> <img
				src="<%=request.getContextPath()%>/images/700_700.png"
				class="logo logo-display" alt=""> <img
				src="<%=request.getContextPath()%>/images/700_700.png"
				class="logo logo-scrolled" alt="">
			</a>
			<!-- logo(結束) -->
		</div>
		<!-- 選單列表(開始) -->
		<div class="collapse navbar-collapse" id="navbar-menu">
			<ul class="nav navbar-nav navbar-right" data-in="fadeInDown">
				<li><a href="<%=request.getContextPath() %>/index.jsp">Home</a></li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/season/seasonList.jsp" class="dropdown-toggle"
					data-toggle="dropdown">賽季<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<c:forEach var="seasonSet" items="${seasonSvc.all}" begin="0" end="3">
							<li><a href="<%=request.getContextPath() %>/Season.do?action=GET_GROUPS&seasonID=${seasonSet.seasonID}">${seasonSet.seasonName}</a></li>
						</c:forEach>
					</ul>
				</li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/groups/groupFront.jsp" class="dropdown-toggle"
					data-toggle="dropdown">分組<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<li><a href="#">分組子頁1<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="#">分組子頁2<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="#">分組子頁3<!--這行的href輸入超連結頁面--></a></li>
					</ul>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">賽程<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<li><a href="#">賽程子頁1<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="#">賽程子頁2<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="#">賽程子頁3<!--這行的href輸入超連結頁面--></a></li>
					</ul>
				</li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/teams/listAllteam_front.jsp" class="dropdown-toggle"
					data-toggle="dropdown">球隊<!--這行的href輸入超連結頁面--></a>
<!-- 					<ul class="dropdown-menu"> -->
<!-- 						<li><a href="#">球隊子頁1這行的href輸入超連結頁面</a></li> -->
<!-- 						<li><a href="#">球隊子頁2這行的href輸入超連結頁面</a></li> -->
<!-- 						<li><a href="#">球隊子頁3這行的href輸入超連結頁面</a></li> -->
<!-- 					</ul> -->
					</li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/players/listAllPlayer_front.jsp" class="dropdown-toggle"
					data-toggle="dropdown">球員<!--這行的href輸入超連結頁面--></a>
<!-- 					<ul class="dropdown-menu"> -->
<!-- 						<li><a href="#">球員子頁1這行的href輸入超連結頁面</a></li> -->
<!-- 						<li><a href="#">球員子頁2這行的href輸入超連結頁面</a></li> -->
<!-- 						<li><a href="#">球員子頁3這行的href輸入超連結頁面</a></li> -->
<!-- 					</ul> -->
					</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">數據<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath() %>/personaldata/PersonalDataindex.jsp">個人數據<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="<%=request.getContextPath() %>/personaldata/TeamDataindex.jsp">球隊數據<!--這行的href輸入超連結頁面--></a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">影音<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath() %>/gamemedia/photo.jsp">照片<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="<%=request.getContextPath() %>/gamemedia/video.jsp">影片<!--這行的href輸入超連結頁面--></a></li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- 選單列表(結束) -->
	</div>
</nav>
<!--標頭(結束)-->


<!--至頂空白(開始)-->
<div class="pageheader fixed-demo dark">
	<div class="container"></div>
</div>
<!--至頂空白(結束)-->
<div class="clearfix"></div>





