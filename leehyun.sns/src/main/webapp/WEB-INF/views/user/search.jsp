<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SNS</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
   $( () => { 
      $('.profImg').click( (e) => {
    	  $.ajax({
    		 url: "fanPage",
    		 method: 'post',
    		 data: {"profId": $(e.currentTarget).attr("value")},
    		 success: (isMe) => {
    			 if(isMe)
    				 location.href="../common/mypage";
    			 else
    			 	location.href="fanPage";
    		 }
    	 });
      });
      
      $('.profId').click( (e) => {
    	  $.ajax({
     		 url: "fanPage",
     		 method: 'post',
     		 data: {"profId": $(e.currentTarget).text()},
     		success: (isMe) => {
   			 if(isMe)
   				 location.href="../common/mypage";
   			 else
   			 	location.href="fanPage";
   		 }
     	 });
      });
   });
</script>
<style>
.swal-footer {
	text-align: center;
}

.grayBtn {
	background: lightgray;
	margin-left: 50px;
}

.main {
	height: 800px;
}

.searchFrame {
	margin-top: 30px;
	width: 1140px;
	padding: 0 100px;
	height: 800px;
	overflow: auto;
}

.searchResult {
	font-size: 25px;
	color: lightgray;
	margin-bottom: 30px;
}

.searchWord {
	font-weight: bold;
	display: inline-block;
}

.searchHr {
	margin: 0;
}

.searchItem {
	display: flex;
}

.profImg {
	border: 1px solid;
	border-radius: 50%;
	width: 100px;
	height: 100px;
	margin: 20px 30px;
	margin-left: 50px;
	cursor: pointer;
}

.profNameDiv {
	width: 250px;
}

.profId {
	margin-top: 20px;
	margin-bottom: 15px;
	font-size: 35px;
	cursor: pointer;
}

#profName {
	font-size: 20px;
}
</style>
</head>
<header></header>
<div style="background: #FBFEFF;">
	<div style="width: 1140px; margin: 0 auto;">
		<div class="main">
			<div class="searchFrame">
				<c:choose>
					<c:when test="${!empty users}">
						<div class="searchResult">
							<span class="glyphicon glyphicon-search"></span>"
							<div class="searchWord">${partUserName}</div>
							"에 대한 검색 결과입니다.
						</div>
						<c:forEach var="user" items="${users}">
							<c:if test="${user.userId ne 'admin'}">
								<hr class="searchHr">
								<div class="searchItem">
									<img class="profImg" value=${user.userId} src="../attach/${user.profileImg}"></img>
									<div class="profNameDiv">
										<div class="profId">${user.userId}</div>
										<div id="profName">${user.userName}</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="searchResult">
							<span class="glyphicon glyphicon-search"></span>"
							<div class="searchWord">${partUserName}</div>
							"에 대한 검색 결과가 없습니다.
						</div>
					</c:otherwise>
				</c:choose>
				<hr class="searchHr">
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp"%>