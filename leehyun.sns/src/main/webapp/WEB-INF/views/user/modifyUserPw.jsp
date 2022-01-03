<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>프로필수정-비밀번호변경</title>
<%@ include file="../common/include.jsp" %>
<%@ include file="../common/header.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
   $( () => {
      $('#okBtn').click( () => {
    	  if($("#beforePw").val() != "" && $("#afterPw1").val() != "" && $('#afterPw2').val() != "") {
	    	  if($('#beforePw').val() == "${user.password}"){
	    		  if($('#afterPw1').val() == $('#afterPw2').val()){
	    	    	  $.ajax({
	    	    		  url: "modifyUserPw",
	    	    		  method: "post",
	    	    		  data: {"userId": $(".myProfileName").attr("value"),
	    	    			  	"password": $('#afterPw1').val()},
	    	    		  success: modifyUserPw => {
	    	    		         swal({
	    	    		             title: "비밀번호가 변경되었습니다.",
	    	    		             text: "로그인 화면으로 넘어갑니다.",
	    	    		             buttons : false,
	    	    		          });
	    	    		         setTimeout("window.location='logout'", 1000);
	    	    		  }
	    	    	  });
	    		  }else{
	    			  swal({
		    			  title: "새 비밀번호와 확인이 일치하지 않습니다.",
		    			  type: "warning"
		    		  })
	    		  }
	    	  }else{
	    		  swal({
	    			  title: "이전 비밀번호가 일치하지 않습니다.",
	    			  type: "warning"
	    		  })
	    	  }
    	  }else {
    		  swal({
    			  title: "정보를 모두 입력하세요.",
    			  type: "warning"
    		  })
    	  }
      });
   });
</script>
<style>
.swal-footer {
   text-align: center;
}

.main {
   height: 800px;
}

.flex {
   display: flex;
   justify-content: center;
   align-items: center;
}

.profileEditFrame{
   width: 800px;
   height: 600px;
   background: white;
   border: 1px solid lightgray;
   padding: 80px;
}

.myProfileImgDiv{
   display: flex;
   margin-left: 80px;
   margin-bottom: 30px; 
}


.myProfileImg {
   background: white;
   width: 70px;
   height: 70px;
   margin-right: 20px;
   margin-top: 15px;
   border: 1px solid;
   display: inline-block;
}

.myProfileNameDiv{
   display: inline-block;
}

.myProfileName {
   font-size: 25px;
   margin-top: 30px;
   font-weight: bold;
}

.floatLeft{
   float: right;
}

.btnDiv{
   margin-top: 20px;
}

.colorBtn{
   background: #A593E0;
   color: white;
}
</style>
</head>
<header></header>
<div style="background: #FBFEFF;">
   <div class='container'>
      <div class="flex main">
         <div class="profileEditFrame">
         
            <div class="myProfileImgDiv">
               <img class="myProfileImg" src="../attach/${user.profileImg}"></img>
               <div class="myProfileNameDiv">
                  <div class="myProfileName" value="${user.userId}">${user.userId}</div>
               </div>
            </div>
            
            <div class="formDiv">
               <form class="form-horizontal">
                  <div class="form-group">
                     <label class="control-label col-sm-3" for="beforePw">이전비밀번호</label>
                     <div class="col-sm-8">
                        <input id="beforePw" type="password" class="form-control">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-3" for="afterPw1">새비밀번호</label>
                     <div class="col-sm-8">
                        <input id="afterPw1" type="password" class="form-control">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-3" for="afterPw2">새비밀번호확인</label>
                     <div class="col-sm-8">
                        <input id="afterPw2" type="password" class="form-control">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <div class="col-sm-offset-3 col-sm-8 btnDiv">
                        <button type="button" id="okBtn" class="btn colorBtn">비밀번호 변경</button>
                     </div>
                  </div>
               </form>
            </div>
            
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>