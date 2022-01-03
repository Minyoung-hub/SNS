<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<head>
<title>SNS</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script>
let path = window.location.pathname;
let myFile = path.substring(path.lastIndexOf("/") + 1);
let folder1 = path.substring(0, path.lastIndexOf("/"));
let folder2 = folder1.substring(0, folder1.lastIndexOf("/"));
folder1 = folder1.substring(folder1.lastIndexOf("/") + 1, folder1.length);
folder2 = folder2.substring(folder2.lastIndexOf("/") + 1, folder2.length);
	$(() => {
		let str = "";
		let date = null;
		let now = new Date();
		let time = "";
		
		let homeLink = ".";
		let msgLink = "message";
		let myLink = "common/mypage";
		let logoutLink = "user/logout";
		let searchLink = "user/search";
		let noticeLink = "notice";
		let fanPageLink = "user/fanPage";
		
		if(folder1=="user" || folder1 == "message" || folder1 == "common"){
			homeLink = "../.";
			msgLink = "../message";
			myLink = "../common/mypage";
			logoutLink = "../user/logout";
			searchLink = "../user/search";
			noticeLink = "../notice";
			fanPageLink = "../user/fanPage";
		}
		
		$(".searchBtn").click(()=>{
			if($(".searchIn").val()){
				$.ajax({
					url: searchLink,
					method: "post",
					data: {"partUserName": $(".searchIn").val()},
					success: idsearch => {
						window.location = searchLink;
					}
				});
			}else{
				swal({
					title: "검색어를 입력해주세요",
					type: "info",
				})
			}
		});
		
		$('.searchIn').keypress(function(event){
			var keycode = (event.keyCode ? event.keyCode : event.which);
			if(keycode == '13'){
				$(".searchBtn").click();
			}
			event.stopPropagation();
		});
		
		$('.allim').click( () => {
			$.ajax({
				url: noticeLink,
				data: {"userNum": ${userNum}},
				success: arr => {
					if(arr){
						$('#noticeFrame').empty();
						
						if(arr.length){
							for(let i = 0; i < arr.length; i++){
								$('#noticeFrame').prepend('<hr class="noticeHr">');
								
								str = "";
								
								str += '<div class="noticeContents">';
								str += '<a class="noticeOwnerText" value="'+arr[i].userId+'">'+arr[i].userName+'</a>님이 ';
								
								switch(arr[i].type){
								case 1:
									str += '나의 팬이 되었습니다.';
									break;
								case 2:
									str += '<div class="noticePost" value="'+arr[i].postNum+'">내 게시글</div>을 좋아합니다.';
									break;
								case 3:
									str += '<div class="noticePost" value="'+arr[i].postNum+'">내 게시글</div>에 댓글을 남겼습니다.';
									break;
								}
								
								date = new Date(arr[i].noticeTime);
								
								if(date.toLocaleDateString() == now.toLocaleDateString())
									time = date.toLocaleTimeString();
								else
									time = date.toLocaleDateString();
								
								str += '<div class="noticeTimeText">'+time+'</div></div>';
								
								$('#noticeFrame').prepend(str);
							}
							
							$('.noticeOwnerText').click( (e) => {
								e.stopPropagation();
								$.ajax({
						     		url: fanPageLink,
						     		method: 'post',
						     		data: {"profId": $(e.currentTarget).attr("value")},
						     		success: (isMe) => {
						   				location.href=fanPageLink;
						   			} 
								});
							});
							
							$('.noticeContents').click( (e) => {
								$(e.currentTarget).children().eq(0).click();
							});
							
						}else{
							$('#noticeFrame').prepend(`<div style="text-align: center; font-size: 30px; padding-top: 120px;">알림 목록이 없습니다.</div>`);
						}
						$("#notice").modal("show");
					}else{
						swal({
							title: "알림 가져오기 실패 문제발생",
							type: "warning",
						})					
					}
				},
				error : (a, b, err) => swal({
					title: "알림 ERROR 문제발생",
					type: "warning",
				})
			});
		});
		
		$('.home').click( () => {
			location.href=homeLink;
		});
	      
		$('.message').click( (e) => {
			location.href=msgLink;
		});
		
		$('.my').click( () => {
			location.href=myLink;
		});
	      
		$('.logout').click( () => {
			location.href=logoutLink;
		});
	});
</script>
<style>
.scroll{
   overflow-x: auto;
}

.scroll::-webkit-scrollbar {
   width: 10px;
  }
.scroll::-webkit-scrollbar-thumb {
   background-color: white;
   border-radius: 10px;
   background-clip: padding-box;
   border: 3px solid transparent;
}
.scroll::-webkit-scrollbar-track {
   background-color: none;
   border-radius: 10px;
}

.head{
   display: flex;
   justify-content: space-between;
}
.logo{
   width: 160px;
   height: 80px;
   margin: 10px;
   margin-left: 30px;
}
.searchIn{
   width: 350px;
   height: 40px;
   vertical-align: middle;
   border: 1px solid #A593E0;
   border-top-left-radius: 4px;
   border-bottom-left-radius: 4px
}
.searchBtn{
   background: black;
   color: white;
   height: 40px;
   vertical-align: middle;
   background: #A593E0;
   border-bottom-left-radius: 0px !important;
   border-top-left-radius: 0px !important;
}
.home{
   background: white;
   height: 40px;
   width: 60px;
}
.message{
   background: white;
   height: 40px;
   width: 60px;
}
.my{
   background: white;
   height: 40px;
   width: 60px;
}
.allim{
   background: white;
   height: 40px;
   width: 60px;
}
.logout{
   background: white;
   height: 40px;
   width: 60px;
}
.noticeContents {
   height: 40px;
   padding-top: 12px;
   padding-left: 12px;
   cursor: pointer;
}

.noticeContents:hover {
   background: #F7F6F6;
}

.noticeOwnerText{
   font-weight: bold;
   color: black;
}

.noticePost{
   font-weight: bold;
   display: inline-block;
}

.noticeTimeText{
   color: lightgray;
   float: right;
   display: inline-block;
}

.noticeHr{
   margin: 5px 0px;
}
</style>
</head>
<body>
<div style="background: white; border-bottom: 1px solid lightgray;">
   <div style="width: 1140px; margin: 0 auto;">
      <div class="head">
         <img class='logo' src="<c:url value="/attach/common/logo" />"></img>
         <div style="display: flex; align-items: center">
            <input type="text" class="searchIn"/>
            <button class="btn searchBtn">검색</button>
         </div>
         <div style="display: flex; align-items: center; margin-right: 25px;">
            <button class="btn home btn-margin"><span class="glyphicon glyphicon-home" style="font-size: 25px;"></span></button>
            <button class="btn allim btn-margin"><span class="glyphicon glyphicon-star-empty" style="font-size: 25px;"></span></button>
            <button class="btn message btn-margin"><span class="glyphicon glyphicon-send" style="font-size: 25px;"></span></button>
            <button class="btn my btn-margin"><span class="glyphicon glyphicon-user" style="font-size: 25px;"></span></button>
            <button class="btn logout btn-margin"><span class="glyphicon glyphicon-log-out" style="font-size: 25px;"></span></button>
         </div>
      </div>
   </div>
</div>
<div class="modal fade" id="notice" role="dialog">
   <div class="modal-dialog" >
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title">알림<button type="button" class="close" data-dismiss="modal">&times;</button></h4>
         </div>
         <div class="modal-body scroll" style="height: 600px;" id="noticeFrame">
         </div>
      </div>
   </div>
</div>
</body>
</html>