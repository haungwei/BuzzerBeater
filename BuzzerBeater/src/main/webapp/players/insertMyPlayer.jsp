<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <%@ page import="java.util.*"%>
            <%@ page import="eeit.players.model.*"%>
                <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
                <html>

                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                    <title>Insert title here</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                    <!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->
                    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/iEdit.css">
                    <script src="<%=request.getContextPath() %>/js/jquery-3.1.1.min.js"></script>
                    <script src="<%=request.getContextPath() %>/js/iEdit.js"></script>
                    <jsp:include page="/header_css.jsp" />
 <style>
                    #result{
							width: 200px;
                                height: 300px;
                                margin: 0px 0px 30px 70px;                    
                    }
                    </style>

                </head>

                <body>

                    <jsp:include page="/header.jsp" />


                    <!--主文(開始)-->

                    <div class="container">
                        <div class="jumbotron">
                            <c:if test="${not empty errorMsgs}">
                                <font color='red'>請修正以下錯誤:
                                    <ul>
                                        <c:forEach var="message" items="${errorMsgs}">
                                            <li>${message}</li>
                                        </c:forEach>
                                    </ul>
                                </font>
                            </c:if>

                            <!-- 修改表單 -->
                            <Form class="form-horizontal" method="post" action="<%=request.getContextPath() %>/Players.do">
                                <fieldset>
                                    <!-- Form Name -->
                                    <legend>球員新增</legend>

                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">球員照片:</label>
                                        <input type="file" id="file">
                                        <div class="col-md-4">
                                            <img id="result" src="data:image/jpeg;base64,${photo}">
                                            <br>
                                            <input type="hidden" id="photo" name="photo" value="data:image/jpeg;base64,${photo}">
                                        </div>
                                    </div>

                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">球員姓名:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="playerName" class="form-control" id="exampleInputEmail1" value="${playerName}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">身分證ID:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="id" class="form-control" id="exampleInputEmail1" value="${id}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">背號:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="playerNo" class="form-control" id="exampleInputEmail1" value="${playerNo}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">位置:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="playerRole" class="form-control" id="exampleInputEmail1" value="${playerRole}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">身高(cm):</label>
                                        <div class="col-md-4">
                                            <input type="text" name="height" class="form-control" id="exampleInputEmail1" value="${height}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">體重(kg):</label>
                                        <div class="col-md-4">
                                            <input type="text" name="weights" class="form-control" id="exampleInputEmail1" value="${weights}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">生日:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="birthday" class="form-control" id="exampleInputEmail1" value="${birthday}">
                                        </div>
                                    </div>
                                    <!-- Text input-->
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">國籍:</label>
                                        <div class="col-md-4">
                                            <input type="text" name="nationality" class="form-control" id="exampleInputEmail1" value="${nationality}">
                                        </div>
                                    </div>




                                    <div class="col-md-12">
                                        <div class="col-md-4"></div>
                                        <div class="col-md-4">
                                            <!-- Button -->
                                            <div class="col-md-4">
                                                <button type="submit" class="btn btn-warning">確認新增</button>
                                                <input type="hidden" name="action" value="listMyPlayer">
                                            </div>
                            </Form>
                            <div class="col-md-4"></div>
                            <div class="col-md-4">
                                <form action="<%=request.getContextPath() %>/Players.do">
                                    <button type="submit" class="btn btn-warning">取消</button>
                                    <input type="hidden" name="action" value="cancel">
                                </form>
                            </div>
                            </div>
                            <div class="col-md-4"></div>
                            </div>




                            <jsp:include page="/footer.jsp" />
                            </fieldset>

                        </div>
                    </div>
                    <!--主文(結束)-->

                    <jsp:include page="/footer_css.jsp" />
                    <script>
                        $("#file").change(function (e) {

                            var img = e.target.files[0];

                            if (!img.type.match('image.*')) {
                                alert("Whoops! That is not an image.");
                                return;
                            }
                            iEdit.open(img, true, function (res) {
                                $("#result").attr("src", res);
                                $("#photo").attr("value", res);
                            });

                        });
                    </script>
                </body>

                </html>