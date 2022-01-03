<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>SNS</title>
<script>
$(()=>{
	$('.logoImg').click( () => {
		location.href = 'login';
	});
	
	$(".idSearchBtn").click(()=>{
		$.ajax({
			url: 'findId',
			method: 'post',
			data: {"userName": $(".nameIn").val(), "phoneNum": $(".phoneIn").val()},
			success: findid => {
				if(findid){
					window.location = "findIdOut";
				}else{
					swal({
						title: "일치하는 정보가 없습니다.",
						type: "warning"
					})
				}
			},
			error: (a, b, err) => {
				swal({
					title: "모든 값을 입력해주세요.",
					type: "warning"
				})
			}
		})
	});
	
	$(".loginBtn").click(()=>{
		window.location = "login";
	});
	
	$(".pwSearch").click(()=>{
		window.location = "findPw";
	});
	
	$(".signUp").click(()=>{
		window.location = "addUser";
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

.in {
   width: 400px;
   margin: 15px;
   height: 40px;
   border-radius: 4px;
   background: #F8F8FF;
   text-align: center;
   border: 1px solid #8C9FFB;
}

.idSearchBtn {
   width: 400px;
   margin: 15px;
   height: 40px;
   background: #BDC6F4;
}

.idSearch {
	width: 400px;
	text-align: left;
	font-size: 25px;
	margin-bottom: 10px;
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
</style>
</head>
<div class="back">
   <div class='container logincontainer'>
      <div class="loginframe gradient-border">
         <img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
         <div class="idSearch">아이디 찾기</div>
         <input class="nameIn in" type="text" placeholder="성명" />
         <input class="phoneIn in" type="tel" placeholder="전화번호" />
         <button class="btn idSearchBtn" type="button">아이디 찾기</button>
         <div class="orBar">
            <hr style="width: 200px; border: 1px solid lightgray">
            <div style="margin: 10px; color: gray">OR</div>
            <hr style="width: 200px; border: 1px solid lightgray">
         </div>
         <div class="optBtnDiv">   
            <button class="btn loginBtn optBtn" type="button">로그인</button>
            <button class="btn pwSearch optBtn" type="button">비밀번호 찾기</button>
            <button class="btn signUp optBtn" type="button">회원가입</button>
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>