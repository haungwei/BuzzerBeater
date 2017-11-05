<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
    <html lang="zh" class="no-js">

    <head>
      	<meta charset="UTF-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  		<meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    	<link href="<%=request.getContextPath() %>/css/bootstrap.css" rel='stylesheet' type='text/css' />
    	<link href="<%=request.getContextPath() %>/css/style.css" rel="stylesheet" type="text/css" media="all" />
    	
        <jsp:include page="/header_css.jsp" />
        <jsp:include page="/font_css.jsp" />
	    <style>
			h2,h3 {		
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
	        	</span>
	        	&gt;
	        	<span>
	            	<a href="<%=request.getContextPath() %>/season/seasonList_back.jsp">
	            		<span>賽季管理</span>
	            	</a>
	        	</span>
	        	&gt;
	        	<span>
	            	<a href="<%=request.getContextPath() %>/season/addSeason.jsp">
	            		<span>新增賽季</span>
	            	</a>
	        	</span>
	        	&gt;
	        	<span>使用EXCEL新增完整賽季</span>
	    	</div>
	    	<!--上層導覽列(結束) -->
	    	
			<!-- 網頁內容 -->
			
			<form action="<%=request.getContextPath()%>/Games.do" method="post">
				<input type="hidden" name="action" value="GET_EXCEL_TEMPLATE">
				<input type="submit" class="btn btn-info btn-lg" value="取得EXCEL範本">
			</form>
		
			<form action="<%=request.getContextPath()%>/Games.do" method="post">
				<div class="form-group">
					<label for="putFullSeason">上傳EXCEL建立完整賽季</label>
					<input type="hidden" name="action" value="PUT_FULL_SEASON">
				    <input type="file" class="form-control-file" id="putFullSeason" aria-describedby="fileHelp">
			    </div>
			    <input type="submit" class="btn btn-lg btn-success" value="送出">
			</form>
		
			<!-- 網頁內容END -->
			<jsp:include page="/footer.jsp" />
	    	</div>
	    </div>    
	    <jsp:include page="/footer_css.jsp" />
    </body>

    </html>