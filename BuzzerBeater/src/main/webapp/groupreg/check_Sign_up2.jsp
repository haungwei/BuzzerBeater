<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="GroupRegSvc" scope="page"
	class="eeit.groupreg.model.GroupRegService" />
<jsp:useBean id="teamsSvc" scope="page"
	class="eeit.teams.model.TeamsService" />
<!DOCTYPE >
<html>
<head>
<title>BuzzerBeater-審核繳費紀錄</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.12.4.js"></script>
<!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/datatables.min.css" />
<jsp:include page="/header_css.jsp" />
<style>
#img1 {
	width: 55px;
	height: 40px;
	margin: auto;
}
</style>
</head>
<body>
	<jsp:include page="/header.jsp" />
	<!--主文(開始)-->
	<div class="container">
		<h2 align="center">審核繳費紀錄</h2>
		<div class="jumbotron">
			<form class="form-inline" method="post"
				action="<%=request.getContextPath()%>/Players.do">
				<select class="form-control" name="groups">
					<option>分組</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select> <input type="submit" class="btn btn-warning" value="搜尋"> <input
					type="hidden" name="action" value="getOne_For_Display">
			</form>
			<!--表格(開始)-->
			<!--****************-->
			<!-- 第一列(開始) -->
			<!--****************-->
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered" id="example">
						<thead>
							<tr>
								<td>隊伍名稱</td>
								<td>報名分組</td>
								<td>報名時間</td>
								<td>繳費狀態</td>
								<td>帳號後五碼</td>
								<td>核對</td>
							</tr>
						</thead>
						<tbody id="test01">
							<c:forEach var="groupRegVO" items="${GroupRegSvc.all}" >
								<tr align='center' valign='middle' >
									<td><a
									href="<%=request.getContextPath()%>/Teams.do?action=GET_ONE_TEAM&teamID=${groupRegVO.teamsVO.teamID}">${groupRegVO.teamsVO.teamName}</a></td>
									<td>${groupRegVO.groupsVO.seasonVO.seasonName}-
										${groupRegVO.groupsVO.groupName}</td>
									<!--球隊名-->

									<!--報名時間-->
									<td>${groupRegVO.registerDate}</td>
									<!--繳費狀態-->
									<td>${groupRegVO.teamStat}</td>
									<!--帳號後五碼-->
									<td>${groupRegVO.paymentNumber}</td>
									<!--核對-->
									
<!-- 										<Form method="post" -->

                                         <c:if test="${groupRegVO.teamStat==1}">
												<td><button type="button" class="btn btn-lg btn-primary">已繳費</button></td>
											</c:if>
											<c:if test="${groupRegVO.teamStat==2}">
												<td><button type="button" class="btn btn-lg btn-primary">待審核</button> </td>                                                 
											</c:if>
<%-- 			        			<input type="hidden" name="seasonID" value="${sVO.seasonID}">  --%>
<!--                                     <input type="hidden" name="action" value="GET_ONE_TO_UPDATE"> -->
<!-- 										</Form> -->
									
								</tr>
							</c:forEach>
					</table>

				</div>
			</div>
			<jsp:include page="/footer.jsp" />
		</div>
	</div>
	<!--主文(結束)-->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/js/datatables.min.js"></script>
	<script>
	   $(function(){
		   
		$(document).ready(function() {
			$('#example').DataTable({
				columnDefs: [{ width: 200, targets: 6}],
				"lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
				"pagingType": "full_numbers",
				"language": {
					"lengthMenu":"每一頁顯示_MENU_ 筆資料",
					"zeroRecords":"查無資料",
					"info":"現在正在第_PAGE_ 頁，總共有_PAGES_ 頁",
					"infoEmpty":"無資料",
					"infoFiltered":"(總共搜尋了_MAX_ 筆資料)",
					"search":"搜尋：",
					"paginate":{
						"first":"第一頁",
						"previous":"上一頁",
						"next":"下一頁",
						"last":"最末頁"					
					}
			  }
			})
		});
		
		$('.btn-primary').on('click', function(){
 			//var a = $(this).parents('tr').find('td:nth-child(4)').text();
// 			alert($(this).parents('tr').find('td:nth-child(4)').text());
            $(this).parents('tr').find('td:nth-child(4)').text('1');
            $(this).text('已繳費');
		})
// 		 var a = $("#test01 > tr").find("td:nth-child(4)").text();
// 		    alert(a);
		    
	   })    
	</script>
</body>
</html>