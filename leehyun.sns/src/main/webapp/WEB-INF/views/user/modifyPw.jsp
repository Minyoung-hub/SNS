<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>FANPLE-비밀번호 변경</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(() => {
	$('.logoImg').click( () => {
		location.href = 'login';
	});
	
	$(".pwChangeBtn").click(() => {
		if(!$(".pwChangeIn").val() == ""){
		if($(".pwChangeIn").val() == $(".pwChangeCkIn").val()){
			if($(".pwChangeIn").val().length < 12){
				$.ajax({
					url: "pwChange",
					method: "post",
					data: {"password": $(".pwChangeIn").val()},
					success: pwchange => {
						swal({
							title: "비밀번호가 변경되었습니다.",
							text: "로그인 페이지로 이동합니다.",
							type: "success",
							buttons: {
								ok : {
									text: "확인",
									value: true,
								},
								no : {
									text: "취소",
									value: false,
									className : "grayBtn"
								}
							},
						}).then((result)=>{
							if(result)
								location.href="login";
						})
						/* ('#msgModal').modal("show"); */
					}
				})
			}else{
				swal({
					title: "비밀번호를 12자 이하로 입력해주세요.",
					type: "warning"
				})
			}
		}else{
			swal({
				title: "비밀번호가 일치하지 않습니다.",
				type: "warning"
			})
		}
		}else{
			swal({
				title: "비밀번호를 0자 이상 입력하세요.",
				type: "warning"
			})
		}

	});
	
	$("#yes").click(() => {
		location.href = 'login';
	});	
})
</script>
<style>
.swal-footer {
   text-align: center;
}

.grayBtn{
   background: lightgray;
   margin-left: 50px;
}

.back {
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
	width: 180px;
	height: 90px;
	margin: 30px;
	cursor: pointer;
}

.pwChange {
	width: 400px;
	text-align: left;
	font-size: 25px;
}

.pwChangecontents {
	font-size: 18px;
	text-align: center;
	margin-bottom: 20px;
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

.pwChangeBtn {
	width: 400px;
	margin: 15px;
	height: 40px;
	background: #BDC6F4;
	margin-bottom: 50px;
}

.msg {
	font-size: 18px;
	text-align: center;
}

.yesBtn {
	background-color: white;
	font-size: 16px;
	color: #BDC6F4;
	font-weight: bold;
	border-top: none;
	border-bottom: none;
	border-left: none;
	border-right: none;
}

.modal.modal-center {
	text-align: center;
}

@media screen and (min-width: 768px) {
	.modal.modal-center:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}

.modal-dialog.modal-center {
	display: inline-block;
	text-align: left;
	vertical-align: middle;
}
</style>
</head>
<div class="back">
	<div class='container logincontainer'>
		<div class="loginframe gradient-border">
			<img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
			<div class="pwChange">비밀번호 변경</div>
			<hr style="width: 450px; border: 1px solid lightgray">
			<div class="pwChangecontents">
				변경할 비밀번호를 입력해주세요. <br>
			</div>
			<input class="pwChangeIn inp" type="password" placeholder="비밀번호" />
			<input class="pwChangeCkIn inp" type="password" placeholder="비밀번호 확인" />
			<button class="btn pwChangeBtn" type="button">비밀번호 변경</button>
		</div>
	</div>
</div>
<footer></footer>

<div id="msgModal" class="modal fade modal-center">
	<div class="modal-dialog modal-sm modal-center">
		<div class="modal-content">
			<div class="modal-body">
				<p class="msg">
					비밀번호가 변경되었습니다.<br> 로그인 페이지로 이동합니다.
				</p>
			</div>
			<div class="modal-footer"
				style="display: flex; justify-content: center;">
				<button type="button" class="yesBtn" id="yes">확인</button>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>