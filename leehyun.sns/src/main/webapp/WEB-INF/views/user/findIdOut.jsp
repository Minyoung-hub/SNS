<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>FANPLE-아이디찾기 출력화면</title>
<script>
$(()=>{
	$('.logoImg').click( () => {
		location.href = 'login';
	});
	
	$(".loginBtn").click(()=>{
		window.location = "login";
	});
	$(".pwSearch").click(()=>{
		window.location = "findPw";
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

.idSearch {
width: 400px;
   text-align: left;
   font-size: 25px;
   margin-bottom: 5px;
}

.idSearchResultcontents {
	font-size: 16px;
	width: 350px;
	margin-bottom: 10px;
}

.optBtnDiv {
   margin: 10px;
   width: 400px;
   display: flex;
   justify-content: space-between;
   margin-bottom: 75px;
}

.optBtn {
   width: 200px;
   margin: 15px;
   height: 40px;
   background: #BDC6F4;
}
</style>
</head>
<div class="back">
   <div class='container logincontainer'>
      <div class="loginframe gradient-border">
         <img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
         <div class="idSearch">아이디 찾기</div>
         <hr style="width: 450px; border: 1px solid lightgray">
         <div class="idSearchResultcontents">${user.userName} 고객님 아이디는</div>         
         <div class="idSearchResultcontents" style="text-align: center; font-weight: bold;">${userIds}</div>
         <div class="idSearchResultcontents" style="text-align: right">입니다.</div>
         <div class="optBtnDiv">   
            <button class="btn loginBtn optBtn" type="button">로그인</button>
            <button class="btn pwSearch optBtn" type="button">비밀번호 찾기</button>
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>