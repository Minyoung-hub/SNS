<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<%@ include file="../../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/nav.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function getQuerystring(key, default_) {
	  if (default_==null) default_="";
	  key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	  let regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
	  let qs = regex.exec(window.location.href);
	  if(qs == null)
	    return default_;
	  else
	    return qs[1];
}

$(() => {	
	let getPostNum = getQuerystring("postNum");
	
	$(function(){
		$.ajax({
			url: "../../common/post/findPost",
			data: {postNum: getPostNum},
			success: (getPost) => {
				$(".contentDate").html(getPost.regDate);
				$("#postContent").html(getPost.postContent);
				$('.postImg').attr("src", `<c:url value="/attach/\${getPost.postImg}"/>`);
				let getuserNum = getPost.userNum;
				
				$.ajax({
					url: "../../user/findUserWithNum",
					data: {userNum: getuserNum},
					success: (getUser) => {
						$("#postOwner").html(getUser.userId);
						$(".profileImg").attr("src", `<c:url value="/attach/\${getUser.profileImg}"/>` )
					}
				});
			}
		})
	});
	
	$(function(){
		$.ajax({
			url: "../post/listComplaints",
			success: (complaints) => {
				let complaintType = "";
				$.each(complaints, (idx, complaint) => {
					if(complaint.postNum == getPostNum)
						complaintType = complaint.complaintType;
				});
				
				$("#contentType").html("신고유형: " + complaintType);
			}
		})
	});
	
	$('#cancel').click( () => {
		swal({
			title: "기각하시겠습니까?",
			text: "해당 신고접수를 기각합니다.",
			buttons: {
				yes : {
					text : "확인",
					value : true,
				},
				no : {
					text : "취소",
					value : false,
					className : "grayBtn"
				}
			},
        
		}).then((result) => {
			if(result){
				$.ajax({
					url: "../post/cancelComplaint",
					data: {postNum: getPostNum},
					success: (cancel) => {
						swal({
							text: "신고접수가 기각 되었습니다.",
							button: false,
	                        className: "swalText"
						});
						setTimeout("window.location='../post/complaintPost'", 1000);
					}
				});
			}			
		}); 
	});
	
	$('#punishmentBtn').click( () => {
		swal({
			title: "삭제하시겠습니까?",
			text: "해당 게시물이 삭제됩니다.",
			buttons: {
				yes : {
					text : "확인",
					value : true,
				},
				no : {
					text : "취소",
					value : false,
					className : "grayBtn"
				}
			},
        
		}).then((result) => {
			if(result){
				$.ajax({
					url: "../../common/post/findPost",
					data: {postNum: getPostNum},
					success: (getPost) => {
						let postImg = getPost.postImg; 
						let postRegDate = getPost.regDate;
						let postContent = getPost.postContent;
						let userNum = getPost.userNum;
						
						$.ajax({
							url: "../post/listComplaints",
							success: (complaints) => {
								let complaintType = "";
								let complaintCnt = 0;
								$.each(complaints, (idx, complaint) => {
									if(complaint.postNum == getPostNum) {
										complaintType = complaint.complaintType;
										complaintCnt = complaint.complaintCnt;
									}	
								});  
								
								$.ajax({
									url: "../post/putDelPost",
									data: delPost = {
										delPostNum: getPostNum,	
										delPostImg: postImg,
										delPostRegDate: postRegDate,
										delPostContent: postContent,
										userNum: userNum,
										delPostReason: complaintType,
										declareCnt: complaintCnt
									},
									success: (delPost) => {
										$.ajax({
											url: "../post/cancelComplaint",
											data: {postNum: getPostNum},
											success: (cancel) => {
											}
										});
										
										$.ajax({
											url: "../../common/post/secedePost",
											data: {postNum: getPostNum},
											success: (secedePost) => {												
											}
										});
										
										$.ajax({
											url: "../../post/delPostCnt",
											data: {userNum: userNum},
											success: (delPost) => {
											}
										});
										
										$.ajax({
											url: "../user/correctPenaltyDate",
											data: {userNum: userNum},
											success: (correctPenaltyDate) =>{	
											}
										});
										
										swal({
											text: "해당 게시물이 삭제 되었습니다.",
											button: false,
					                        className: "swalText"
											});
										setTimeout("window.location='../post/complaintPost'", 1000);
									}
								});
							}
						});
					}
				});
			}			
		}); 
	});
})
	
</script>
<style>
.swal-footer {
	text-align: center;
}

.grayBtn {
	background: lightgray;
	margin-left: 50px;
}

.swalText .swal-text{
   font-weight: bold;
   font-size: 20px;
}

.scroll {
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

.body {
	height: 650px;
	margin-left: 80px;
}

.flex {
	display: flex;
}

.wrapping {
	position: absolute;
	display: flex;
}

.leftDiv {
	flex: 4;
	float: left;
}

.post {
	width: 450px;
	margin-left: 20px;
	margin-top: 20px;
	margin-bottom: 30px;
	background: white;
	height: 560px;
	display: flex;
	flex-direction: column;
	border: 3px solid #A593E0;
}

.postImg {
	height: 340px;
	width: 340px;
	border: 2px solid #A593E0;
	margin-left: 50px;
	margin-top: 10px;
	text-align: center;
}

.postContentDiv {
	height: 150px;
	margin-top: 10px;
}

.postContent {
	font-size: 16px;
}

.contentDate {
	margin-top: 10px;
	margin-left: 15px;
}

.ownerProfile {
	height: 70px;
	display: flex;
}

.profileImg {
	background: white;
	width: 50px;
	height: 50px;
	margin-right: 10px;
	margin-top: 15px;
	margin-left: 55px;
	border: 1px solid;
	display: inline-block;
	border-radius: 50%;
}

.rightDiv {
	display: flex;
	flex-direction: column;
}

.cause {
	margin: 20px;
	margin-top: 40px;
	margin-left: 70px;
	padding: 15px;
	padding-bottom: 5px;
	width: 230px;
	font-size: 18px;
	font-weight: bold;
	border: 1px solid black;
	float: left;
	position: relative;
}

#cancel, #punishmentBtn{
	width: 90px;
	height: 40px;
	margin-top: 42%;
	margin-left: 20px;
	background: #A593E0;
	color: white;
}

.punishment {
	margin-top: 250px;
	margin-left: 40px;
}

.ownerProfileName {
	display: inline-block;
	font-size: 18px;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 10px;
}

</style>
<title>Admin admincomplaintPost</title>
</head>
<body>
	<header></header>
	<nav></nav>
	<div class='container'>
		<div class='body'>
			<h3>신고 접수</h3>
			<div class='wrapping'>
				<div class="leftDiv">
					<div class="post scroll">
						<div class="ownerProfile">
            				<img class="profileImg"/>
            				<div class="ownerProfileName" id="postOwner"></div>
            			</div>
						<img class="postImg" />
						<div class="postContentDiv">
							<hr style="border: 0; margin: 3px; margin-top: 10px; height: 1px; background: #A593E0;">
							<div class="postContent">
								<div class="contentDate"></div>
								<pre style="background: none; border: 0px solid; font-size: 14px;" id="postContent"></pre>
							</div>
						</div>
					</div>
				</div>
				<div class="rightDiv">
					<div class='cause'>
						<p id="contentType"></p>
					</div>
	
					<div class='punishment'>
						<button type="button" class="btn" id='cancel'
							style="margin-left: 45px;">기각</button>
						<button type="button" class="btn" id='punishmentBtn'>삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<%@ include file="../../common/footer.jsp"%>