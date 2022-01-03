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

function isNumber(n) { 
	return !isNaN(parseFloat(n)) && !isNaN(n - 0) 
}

$(() => {
	let getuserNum = getQuerystring("userNum");
	
	$("#userNum").html(getuserNum);
	
	$(function(){
		$.ajax({
			url: "../../user/findUserWithNum",
			data: {userNum: getuserNum},
			success: (getUser) => {
				$("#userName").attr("value", getUser.userName);
				$("#userId").html(getUser.userId);
				$("#userPw").attr("value", getUser.password);
				$("#gender").html(getUser.gender);
				$("#userTel").attr("value", getUser.phoneNum);
				$("#userEmail").attr("value", getUser.email);
				$("#birthday").html(getUser.birthday);
			}
		})
	});
	
	$(function(){
		$.ajax({
			url: "../../post/delPostCnt",
			data: {userNum: getuserNum},
			success: (delPost) => {
				$(".restrictContent").html(
						"제재 내역: " + delPost.delPostCnt + " 회  <br> <br> 1회 제재 시 7일 정지,<br> 2회 제재 시 30일"
						 + "정지, <br> 3회 제재 시 영구 정지됩니다.");
			}
		})
	});
	
	$('#editBtn').click(() => {
		swal({
			title: "수정하시겠습니까?",
			text: "회원 정보가 수정됩니다.",
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
			$.ajax({
				url: "../../user/findUserWithNum",
				data: {userNum: getuserNum},
				success: (getUser) => {
					let userName = getUser.userName;
					let userPw = getUser.password;
					let userTel = getUser.phoneNum;
					let userEmail = getUser.email;
					
					if(result){
						if($("#userTel").val().length < 10 || $("#userTel").val().length > 11 || !isNumber($("#userTel").val())){
							swal({
								title: "전화번호가 올바른 형식이 아닙니다.",
								type: "warning",
							});
						}else if(!$("#userEmail").val().includes("@")){
							swal({
								title: "이메일이 올바른 형식이 아닙니다.",
								type: "warning",
							})
						}else if(userName == $("#userName").val() && userPw == $("#userPw").val() && userTel == $("#userTel").val() && userEmail == $("#userEmail").val()){
							swal({
								title: "수정할 내용을 입력해 주세요.",
								type: "warning",
							})
						}else {
							$.ajax({
								url: "../user/adminCorrectUser",
								method: "post",
								data: user = {
									userNum: getuserNum,
									userName: $("#userName").val(),
									password: $("#userPw").val(),
									phoneNum: $("#userTel").val(),
									email: $("#userEmail").val()
								},
								success: (update) => {
									swal({
										text: "회원정보가 수정 되었습니다.",
				                        button: false,
				                        className: "swalText"
				                        });
									setTimeout("location.reload()", 1000);
								},
								error: (a, b, err) => {
									swal({
										title: "잘못된 정보가 있습니다.",
										type: "error",
									})
								}
							});
						}	
					}
				}
			})			
		});
	});
	
	$('#deleteBtn').click( () => {
		swal({
			title: "탈퇴하시겠습니까?",
			text: "아이디가 영구 삭제됩니다.",
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
					url: "../../user/secede",
					method: "post",
					data: {userNum: getuserNum},
					success: (secede) => {
						swal({
							text: "회원이 탈퇴 되었습니다.",
							button: false,
	                        className: "swalText"
							});
						setTimeout("window.location='../../admin'", 1000);
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

.container {
	position: relative;
}

.userManaDiv {
	display: flex;
	height: 650px;
}

.userInfo {
	margin-top: 20px;
	margin-left: 20px;
	width: 600px;
	height: 700px;
}

.formGroup {
	font-size: 20px;
}

.disable {
	margin-top: 5px;
}

.btnDiv {
	margin-top: 20px;
}

.colorBtn {
	background: #A593E0;
	color: white;
	margin: 10px;
}

#editBtn, #deleteBtn, #restrictBtn {
	font-size: 17px;
}

.restrictDiv {
	display: flex;
	flex-direction: column;
}

.restrictBox {
	width: 350px;
	height: 170px;
	border: 1px solid black;
	margin-top: 250px;
	margin-left: 70px;
}

.restrictContent {
	margin: 15px;
	font-size: 18px;
}

.restrictBtnDiv {
	margin-left: 205px;
	margin-top: 61px;
}

.logout {
	background: white;
	height: 40px;
	width: 60px;
	float: right;
	margin: 25px;
}

.adminNav {
	display: flex;
	border-bottom: 1px solid lightgray;
	margin-top: 40px;
	margin-bottom: 40px;
}

.userMana, .postMana, .logoMana {
	height: 50px;
	width: 150px;
	font-size: 20px;
	text-align: center;
	cursor: pointer;
	margin-left: 50px;
}

.userMana {
	border-bottom: 2px solid #A593E0;
}

</style>
<title>Admin adminUser</title>
</head>
<body>
	<header></header>
	<nav></nav>
	<div class='container'>
		<div class="userManaDiv">
			<div class="userInfo">
				<div class="formDiv">
					<form class="form-horizontal">
						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userNum">회원 번호</label>
							<div class="col-sm-7 disable" id="userNum"></div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userName">성명</label>
							<div class="col-sm-7">
								<input id="userName" type="text" class="form-control input-lg">
							</div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userId">아이디</label>
							<div class="col-sm-7 disable" id="userId"></div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userPw">비밀번호</label>
							<div class="col-sm-7">
								<input id="userPw" type="text" class="form-control input-lg">
							</div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="gender">성별</label>
							<div class="col-sm-7 disable" id="gender"></div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userTel">전화번호</label>
							<div class="col-sm-7">
								<input id="userTel" type="text" class="form-control input-lg" maxlength="11">
							</div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userEmail">이메일</label>
							<div class="col-sm-7">
								<input id="userEmail" type="email" class="form-control input-lg">
							</div>
						</div>

						<div class="form-group formGroup">
							<label class="control-label col-sm-3" for="userBirthday">생년월일</label>
							<div class="col-sm-7 disable" id="birthday"></div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-9 btnDiv">
								<button type="button" id="editBtn" class="btn colorBtn">수정</button>
								<button type="button" id="deleteBtn" class="btn colorBtn">탈퇴</button>
							</div>
						</div> 
					</form>
				</div>
			</div>

			<div class="restrictDiv">
				<div class="restrictBox">
					<div class="restrictContent">
					</div>
				</div>
				<!--
				<div class="restrictBtnDiv">
					<button type="button" id="restrictBtn" class="btn colorBtn">제재</button>
				</div>
				 -->
			</div>
		</div>
	</div>
</body>
<%@ include file="../../common/footer.jsp"%>