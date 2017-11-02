<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
  	<link href="<%=request.getContextPath() %>/css/bootstrap.css" rel='stylesheet' type='text/css' />
   	<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" media="all" />
   	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.min.js"></script>
   	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		    	
    <jsp:include page="/header_css.jsp" />
        <style>
        h2,h3{		
  		  font-family:微軟正黑體;   	  
    	  text-align:center;
   		  }
        #pathWay {
      	  color: #666;
      	  height: 28px;
      	  line-height: 28px;
      	  border-bottom: 1px solid #c0b7b7;
      	  text-indent: 5px;
      	  font-size: 18px;
      	  font-weight: normal;
      	  margin-bottom: 10px;
      	  font-family:微軟正黑體;
        }
        </style>
    
    <title>修改賽季</title>
</head>

<body>
	<jsp:include page="/header.jsp" />
	
	<div class="container">
	<div class="jumbotron">
		
		<!--上層導覽列(開始) -->
		<div id="pathWay">
        	<span>
            	<a href="<%=request.getContextPath() %>/index.jsp">
            		<span>使用者功能</span>
            	</a>
        	</span>&gt;
        	        	<span>
            	<a href="<%=request.getContextPath() %>/season/seasonList_back.jsp">
            		<span>賽季管理</span>
            	</a>
        	</span>&gt;
        	<span><span>修改賽季</span></span>
    	</div>
    	<!--上層導覽列(結束) -->
    	
		<div class="col-md-12">
		
			<h2>修改賽季</h2>
            	<c:if test="${not empty errorMsgs}">
				<p style="color:red">請修正以下錯誤:</p>
					<ul style="color:red">
                        <c:forEach var="message" items="${errorMsgs}">
                            <li>${message}</li>
                        </c:forEach>
                    </ul>
                </c:if>

		    <form method="post" action="<%=request.getContextPath()%>/Season.do">
				<input type="hidden" name="action" value="UPDATE_SEASON">
				<input type="hidden" name="seasonID" value="${seasonVO.seasonID}">
				
				<table class="table table-bordered" id="seasonList">
			        <tbody>
						<tr>
							<td>賽季名稱</td>
							<td><input type="text" name="seasonName" value="${seasonVO.seasonName}"></td>
						</tr>
						<tr>
							<td>賽季開始日期</td>
							<td><input type="date" name="seasonBeginDate" value="${seasonVO.seasonBeginDate}"></td>
						</tr>
						<tr>
							<td>賽季結束日期</td>
							<td><input type="date" name="seasonEndDate" value="${seasonVO.seasonEndDate}"></td>
						</tr>
						<tr>
							<td>報名開始時間</td>
							<td><input type="text" name="signUpBegin" value="${seasonVO.signUpBegin}"></td>
						</tr>
						<tr>
							<td>報名結束時間</td>
							<td><input type="text" name="signUpEnd" value="${seasonVO.signUpEnd}"></td>
						</tr>
						<tr>
							<td>備註</td>
							<td><textarea name="descriptions" >${seasonVO.descriptions}</textarea></td>
						</tr>
			        </tbody>
			        
			    </table>
			    <input type="submit" class="btn btn-success" id="submit_move" value="送出" >
			    <input type ="button" class="btn btn-danger" onclick="history.back()" value="取消"></input>
			</form>
		</div>
	<jsp:include page="/footer.jsp" />
	</div>
	</div>
	<script>
	$(document).ready(function(){
		var td_1={'font-family':'微軟正黑體',
 		 		'text-align':'center',
 		 		'line-height': '60px',
	    		'font-size': '20px'}
		var submit={'margin-left': '876px'}
	$("tr td:first-child").css(td_1)
	$("#submit_move").css(submit)
	})
	</script>
	    
</body>
<jsp:include page="/footer_css.jsp" />
</html>