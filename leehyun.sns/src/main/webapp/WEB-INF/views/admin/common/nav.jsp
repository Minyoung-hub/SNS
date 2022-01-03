<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SNS</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
$(() => {
	let path = window.location.pathname;
	let mypath = path.substring(path.lastIndexOf("/"));
    path = path.substring(0, path.lastIndexOf("/"));
    path = path.substring(path.lastIndexOf("/"), path.length);
    if(path == "/user" || path == "/post" || path == "/logo" || path == "/common"){
  		$('.userMana').click( () => {
  			location.href='../../admin';
  		});
  		
  		$('.postMana').click( () => {
  			location.href='../post/complaintPost';
  		});
  		
  		$('.logoMana').click( () => {
  			location.href='../common/logo';
  		});
  		
  		$('.baseImgMana').click( () => {
  			location.href='../common/baseImg';
  		});
    }else{
  		$('.userMana').click( () => {
  			location.href='admin';
  		});
  		
  		$('.postMana').click( () => {
  			location.href='admin/post/complaintPost';
  		});
  		
  		$('.logoMana').click( () => {
  			location.href='admin/common/logo';
  		});
  		
  		$('.baseImgMana').click( () => {
  			location.href='admin/common/baseImg';
  		});
	} 
    if(path == "/user" || mypath == "/admin"){
    	$('.userMana').css("border-bottom", "2px solid #A593E0");         
        $('.postMana').css("border-bottom", "0px solid");  
        $('.logoMana').css("border-bottom", "0px solid");
        $('.baseImgMana').css("border-bottom", "0px solid");
    }else if(path == "/post"){
    	$('.userMana').css("border-bottom", "0px solid");         
        $('.postMana').css("border-bottom", "2px solid #A593E0");  
        $('.logoMana').css("border-bottom", "0px solid");
        $('.baseImgMana').css("border-bottom", "0px solid");
    }else if(mypath == "/logo"){
    	$('.userMana').css("border-bottom", "0px solid");         
        $('.postMana').css("border-bottom", "0px solid");  
        $('.logoMana').css("border-bottom", "2px solid #A593E0");
        $('.baseImgMana').css("border-bottom", "0px solid");
    }else if(mypath == "/baseImg"){
    	$('.userMana').css("border-bottom", "0px solid");         
        $('.postMana').css("border-bottom", "0px solid");  
        $('.logoMana').css("border-bottom", "0px solid");
        $('.baseImgMana').css("border-bottom", "2px solid #A593E0");
    }
})
</script>
<style>
.adminNav{
	display: flex; 
	border-bottom:1px solid lightgray; 
	margin-top: 40px;
	margin-bottom: 40px;
}

.userMana, .postMana, .logoMana, .baseImgMana{
	height: 50px;
	width: 150px;
	font-size: 20px;
	text-align: center;
	cursor: pointer;
	margin-left: 50px;
}

/*.userMana{
	border-bottom: 2px solid #A593E0;
}

</style>
</head>
<div class="container">
	<div class='adminNav'>
		<div class='userMana'>사용자 관리</div>
		<div class='postMana'>게시물 관리</div>
		<div class='logoMana'>로고 관리</div>
		<div class='baseImgMana'>회원 사진 관리</div>
	</div>
</div>