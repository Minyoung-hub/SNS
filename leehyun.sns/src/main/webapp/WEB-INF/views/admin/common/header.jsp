<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SNS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
   $( () => {
      let path = window.location.pathname;
      path = path.substring(0, path.lastIndexOf("/"));
      path = path.substring(path.lastIndexOf("/"), path.length);
      if(path == "/user" ||path == "/post" || path == "/logo" || path == "/common"){
	  		$('.logout').click( () => {
	  			location.href='../../user/logout';
	  		});
      }else{
	  		$('.logout').click( () => {
	  			location.href='../user/logout';
	  		});
		}
	});
</script>
<style>
.menuTop{
	margin-top: 15px;
	height: 70px;
	display: flex;
}

.logoImg{
	width: 100px;
	height: 50px;
	margin: 10px;
}

.admin{
	font-size: 24px;
	height: 50px;
	margin: 10px;
	padding-top: 10px;
}

.logout{
	float: right;
	background: white;
	height: 40px;
	width: 60px;
	margin: 15px;
}
</style>
</head>
<body>
<div class="container">
	<div class='menuTop'>
		<img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
		<div class='admin'>관리자</div>
		<div style="display: inline-block; width: 928px;">
			<button class="btn logout btn-margin">
				<span class="glyphicon glyphicon-log-out" style="font-size: 25px;"></span>
			</button>
		</div>
	</div>
</div>
</body>
</html>