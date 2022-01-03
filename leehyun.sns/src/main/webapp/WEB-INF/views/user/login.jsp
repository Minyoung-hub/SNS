<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<head>
<title>SNS</title>
<%@ include file="../common/include.jsp" %>
<script>
	function getToday() {
		let date = new Date();
		return date.getFullYear() + "-" + ("0" + (date.getMonth()+1)).slice(-2) + "-"
				+ ("0" + date.getDate()).slice(-2);
	}

	$(()=>{
		$('.logoImg').click( () => {
			location.href = 'login';
		});
		
		$('.pwIn').keypress(function(event){
		      var keycode = (event.keyCode ? event.keyCode : event.which);
		      if(keycode == '13'){
		         $("#loginBtn").click();
		      }
		      event.stopPropagation();
		   });
		
		$("#loginBtn").click(()=>{
			$.ajax({
			url: 'login',
			method: 'post',
			data: {"userId": $('#userId').val(), "userPw": $('#userPw').val()},
			success: login => {
				if($("#userId").val() == 'admin' && $("#userPw").val() == 'admin'){
					window.location = "../admin";
				}
				else if(login){
					$.ajax({
						url: 'findUserWithId',
						data: {userId: $('#userId').val()},
						success: (user) => {
							let userNum = user.userNum;
							let userId = user.userId;
							let profileImg = user.profileImg;
							let userName = user.userName;
							
							let penaltyDate = user.penaltyDate;
							let penaltyDateFormat = penaltyDate.substring(0,10);
							let penaltyDateArr = penaltyDateFormat.split('-');
							
							let today = getToday();
							let todayArr = today.split('-');
							
							let penaltyDateCompare = new Date(penaltyDateArr[0], parseInt(penaltyDateArr[1])-1, penaltyDateArr[2]);
							let todayCompare = new Date(todayArr[0], parseInt(todayArr[1])-1, todayArr[2]);

							$.ajax({
								url: '../post/delPostCnt',
								data: {userNum: userNum},
								success: (delPost) => {
									let delPostCnt = delPost.delPostCnt;
									if(delPostCnt < 1){
										window.location = "../";
									} else if(delPostCnt == 1 || delPostCnt == 2){
										if(penaltyDateCompare.getTime() < todayCompare.getTime()){
											window.location = "../";
										} else {
											let pntDate = penaltyDate.substring(0,10);
											
											$('.profileImg').attr("src", `<c:url value="/attach/\${profileImg}"/>`);
											$('#postOwner').html(userId);
											$('.penaltyContent1').html(`<h3><b>&nbsp;&nbsp;사용이 제한된 ID입니다.</b></h3><br>
							            			` + userName +  ` 회원님의 게시글 중 좌측의 게시물은<br>
							            			여러 사용자에 의해 신고를 받은 게시물입니다.<br>
							            			신고 받은 내용은 아래와 같습니다.`);
											if(delPostCnt == 1 ) {
												$('.penaltyContent2').html(userName + ` 회원님의 신고 적발 횟수가 1번 <br>
								            			임에 따라서, 회원님의 아이디 사용을 <br>
								            			7일 간 정지 합니다.`);
											}else if(delPostCnt == 2) {
												$('.penaltyContent2').html(userName + ` 회원님의 신고 적발 횟수가 2번 <br>
								            			임에 따라서, 회원님의 아이디 사용을 <br>
								            			30일 간 정지 합니다.`);
											}
											
											$('.penaltyDate').html("제재 기간 : " + pntDate + " 까지");
											
											$.ajax({
												url: "../post/latestDelPost",
												data: {userNum: userNum},
												success: (delPost) => {
													$('.postImg').attr("src", `<c:url value="/attach/\${delPost.delPostImg}"/>`);
													let delPostRegDate = delPost.delPostRegDate.substring(0,10);
													$('.contentDate').html(delPostRegDate);
													$('#postContent').html(delPost.delPostContent);
													$('.penaltyType').html("신고 유형 : " + delPost.delPostReason);
												}
											});
											
											$("#penaltyModal").modal("show");
										}				
									} else if(delPostCnt >= 3) {										
										$('.profileImg').attr("src", `<c:url value="/attach/\${profileImg}"/>`);
										$('#postOwner').html(userId);
										$('.penaltyContent1').html(`<h3><b>&nbsp;&nbsp;사용이 제한된 ID입니다.</b></h3><br>
						            			` + userName +  ` 회원님의 게시글 중 좌측의 게시물은<br>
						            			여러 사용자에 의해 신고를 받은 게시물입니다.<br>
						            			신고 받은 내용은 아래와 같습니다.`);
										$('.penaltyContent2').html(userName + ` 회원님의 신고 적발 횟수가 3번 <br>
						            			임에 따라서, 회원님의 아이디 사용을 <br>
						            			영구 정지 합니다.`);
										$('.pntDate').hide();
										
										$.ajax({
											url: "../post/latestDelPost",
											data: {userNum: userNum},
											success: (delPost) => {
												$('.postImg').attr("src", `<c:url value="/attach/\${delPost.delPostImg}"/>`);
												let delPostRegDate = delPost.delPostRegDate.substring(0,10);
												$('.contentDate').html(delPostRegDate);
												$('#postContent').html(delPost.delPostContent);
												$('.penaltyType').html("신고 유형 : " + delPost.delPostReason);
											}
										});	
										
										$("#penaltyModal").modal("show");
									}
								}
							})
						}
					})
					
				}else{
					swal({
						title: "비밀번호가 일치하지 않습니다.",
						type: "warning",
						
					})
				}},
				error : (a, b, err) => swal({
					title: "등록된 아이디가 없습니다.",
					type: "warning",
					
				})
				})
			});
			
			$('.signUp').click(()=>{
				location.href="addUser";
			});
			
			$(".idSearch").click(()=>{
				location.href="findId";
			});
			
			$(".pwSearch").click(()=>{
				location.href="findPw";
			});
	});
</script>
<style>
.back{
	background: #F8F8FF;
	position: relative;
	z-index: 0;
}

.logincontainer {
	height: 892px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.loginframe {
	width: 800px;
	height: 600px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background: white;
}

.gradient-border {
	--borderWidth: 7px;
	position: relative;
	border-radius: var(--borderWidth);
}
.gradient-border:after {
	content: '';
	position: absolute;
	top: calc(-1 * var(--borderWidth));
	left: calc(-1 * var(--borderWidth));
	height: calc(100% + var(--borderWidth) * 2);
	width: calc(100% + var(--borderWidth) * 2);
	background: linear-gradient(60deg, #1AF2F6, #5266DC, #A8D0F9, #D9BFFA, #291BF2);
	border-radius: calc(2 * var(--borderWidth));
	z-index: -1;
	animation: animatedgradient 3s ease alternate infinite;
	background-size: 300% 300%;
}


@keyframes animatedgradient{
	0% {
		background-position: 0% 50%;
	}
	50% {
		background-position: 100% 50%;
	}
	100% {
		background-position: 0% 50%;
	}
}

.logoImg {
	width: 300px;
	height: 150px;
	margin: 30px;
}

.inp {
	width: 400px;
	margin: 15px;
	height: 40px;
	border-radius: 4px;
	background: #F8F8FF;
	text-align: center;
	border: 1px solid #8C9FFB;
}

.idIn {
	
}

.pwIn {
	
}

.signInBtn {
	width: 400px;
	margin: 15px;
	height: 40px;
	background: #BDC6F4;
}

.orBar {
	width: 400px;
	margin: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.optBtnDiv {
	margin: 10px;
	width: 400px;
	display: flex;
	justify-content: space-between;
}

.optBtn {
	width: 30%;
	height: 40px;
	background: white;
	text-align: center;
	font-weight: bold;
	color: gray;
}

.optBtn:hover {
	font-size: 15px;
	font-weight: bold;
}

.modalBody{
	display: flex;
}

.post {
    width: 380px;
    margin: 20px;
    background: white;
    height: 540px;
    display: flex;
    flex-direction: column;
    border: 3px solid #A593E0;
}

.ownerProfile {
	height: 80px;
	display: flex;
}

.ownerProfileName {
	display: inline-block;
	font-size: 18px;
	font-weight: bold;
	margin-top: 25px;
	margin-left: 10px;
}

.postImg {
    height: 320px;
    width: 320px;
    border: 2px solid #A593E0;
    margin-left: 28px;
    text-align: center;
}

.postText {
    width: 375px;
    margin-top: 20px;
    border-top: 1px solid #A593E0;
    font-size: 16px;
}

.contentDate {
	margin-top: 10px;
	margin-left: 15px;
}

.profileImg {
	background: white;
	width: 50px;
	height: 50px;
	margin-right: 10px;
	margin-top: 15px;
	margin-left: 30px;
	border: 1px solid;
	display: inline-block;
	border-radius: 50%;
}

.penaltyContent {
	display: flex;
	flex-direction: column;
}

.penaltyContent1 {
	margin-left: 25px;
	font-size: 18px;
}

.penaltyContent2 {
	margin-left: 25px;
	margin-top: 25px;
	font-size: 18px;
}

.cause {
	width: 340px;
	height: 100px;
	margin-top: 20px;
	margin-left: 30px;
	text-alignt: center;
	border: 1px solid black;
	font-size: 18px;
	font-weight: bold;
	position: relative;
	display: flex;
	align-items: center;
}

.pntDate {
	width: 340px;
	height: 100px;
	margin-top: 20px;
	margin-left: 30px;
	text-alignt: center;
	border: 1px solid black;
	font-size: 18px;
	font-weight: bold;
	position: relative;
	display: flex;
	align-items: center;
}

.penaltyType, .penaltyDate {
	margin-left: 30px;
}
</style>
</head>
<div class="back">
	<div class='container logincontainer'>
		<div class="loginframe gradient-border">
			<img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
			<input class="idIn inp" type="text" id = "userId" placeholder="아이디" />
			<input class="pwIn inp" type="password" id="userPw" placeholder="비밀번호" />
			<button class="btn signInBtn" type="button" id="loginBtn">로그인</button>
			<div class="orBar">
				<hr style="width: 200px; border: 1px solid lightgray">
				<div style="margin: 10px; color: gray">OR</div>
				<hr style="width: 200px; border: 1px solid lightgray">
			</div>
			<div class="optBtnDiv">
				<button class="btn idSearch optBtn" type="button">아이디 찾기</button>
				<button class="btn pwSearch optBtn" type="button">비밀번호 찾기</button>
				<button class="btn signUp optBtn" type="button">회원가입</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="penaltyModal" role="dialog">
   <div class="modal-dialog modal-lg" >
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title"><b>로그인 제재</b></h4>
         </div>
         <div class="modal-body" style="overflow: auto; height: 600px;">
            <div class="modalBody">
            	<div class="post">
            		<div class="postFrame">
            			<div class="ownerProfile">
            				<img class="profileImg"/>
            				<div class="ownerProfileName" id="postOwner"></div>
            			</div>
            			<img class="postImg"/>
            			<div class="postText">
							<div class="contentDate"></div>
							<pre style="background: none; border: 0px solid; font-size: 14px;" id="postContent"></pre>
            			</div>
            		</div>
            	</div>
            	<div class="penaltyContent">
            		<div class="penaltyContent1">
            		</div>
            		<div class="cause">
            			<div class="penaltyType"></div>
            		</div>
            		<div class="penaltyContent2">
            		</div>
            		<div class="pntDate">
            			<div class="penaltyDate"></div>
            		</div>
            	</div>
            </div>
         </div>
         <div class='modal-footer'>
            <button type="button" class="btn btn-default" id="no" class="close" data-dismiss="modal">확인</button>
         </div>
      </div>
   </div>
</div>

<%@ include file="../common/footer.jsp" %>



