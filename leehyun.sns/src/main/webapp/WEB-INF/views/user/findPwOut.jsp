<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>FANPLE-비밀번호찾기 출력</title>
<script>

$(()=>{
	$('.logoImg').click( () => {
		location.href = 'login';
	});
	
	$(".pwSearchBtn").click(()=>{
		if($(".codeIn").val() == ${emailNum}){
			swal({
				title: "비밀번호 변경 화면으로 넘어갑니다.",
				type: "success",
			}, function(){
				window.location ="modifyPw";
			})
		} 
		else{
			swal({
				title: "인증코드가 일치하지 않습니다.",
				type: "warning"
			})
		}
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
   width: 180px;
   height: 90px;
   margin: 30px;
   cursor: pointer;
}

.pwSearch {
	width: 400px;
	text-align: left;
	font-size: 25px;
}

.pwSearchResultcontents {
	font-size: 18px;
	text-align: center;
	margin-bottom: 20px;
}

.in {
   width: 400px;
   margin: 15px;
   height: 40px;
   border-radius: 4px;
   background: #F8F8FF;
   text-align: center;
   border: 1px solid #8C9FFB;
}

.pwSearchBtn {
   width: 400px;
   margin: 15px;
   height: 40px;
   background: #BDC6F4;
   margin-bottom: 50px;
}

</style>
</head>
<div class="back">
   <div class='container logincontainer'>
      <div class="loginframe gradient-border">
         <img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
         <div class="pwSearch">비밀번호 찾기</div>
         <hr style="width: 450px; border: 1px solid lightgray">
         <div class="pwSearchResultcontents">
         	회원가입시 고객님이 설정한 이메일로 인증 이메일을 발송했습니다. <br>
         	수신 메일의 인증 코드를 입력해주세요.
         </div>
         <input class="codeIn in" type="text" placeholder="인증코드" />
         <button class="btn pwSearchBtn" type="button">확인</button>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>