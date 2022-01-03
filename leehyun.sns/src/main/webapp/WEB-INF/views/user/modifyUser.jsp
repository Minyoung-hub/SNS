<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>프로필 수정</title>
<%@ include file="../common/include.jsp" %>
<%@ include file="../common/header.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
function isNumber(n) { 
	return !isNaN(parseFloat(n)) && !isNaN(n - 0) 
}
   $( () => {
      $('#photoChangeBtn').click( () => {
         $('#photoChange').modal("show");
      });
      
      
      $('.closeBtn').click( () => {
          $('#photoChange').modal("hide");
       });
      
      $('#editBtn').click( () => {
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
			}else if("${user.userName}" == $("#userName").val() && "${user.phoneNum}" == $("#userTel").val() && "${user.email}" == $("#userEmail").val() && "${user.gender}" == $("#gender").val() && "${user.birthday}" == $("#userBirthday").val()){
				swal({
					title: "수정할 내용을 입력해 주세요.",
					type: "warning",
				})
			}else {
				$.ajax({
		    		  url: "modifyUser",
		    		  method: "post",
		    		  data: {"userId": $(".myProfileName").attr("value"),
		    			  	"userName": $("#userName").val(),
		    			  	"phoneNum": $("#userTel").val(),
		    			  	"email": $("#userEmail").val(),
		    			  	"gender": $("#gender").val(),
		    			  	"birthday": $("#userBirthday").val()
		    			  	},
		    		  success: modifyUser => {
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
      });
      
      $("#pwChangeBtn").click(()=>{
    	 location.href="modifyUserPw"; 
      });
      
      $('#secessionBtn').click( () => {
         swal({
            title: "회원 탈퇴하시겠습니까?",
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
            
         }).then( (result) => {
            if(result){
            	$.ajax({
            		url: "secede",
            		method: "post",
            		data: {"userNum": "${user.userNum}"},
            		success: secede => {
            			swal({
	    		             title: "회원이 탈퇴되었습니다.",
	    		             text: "로그인 화면으로 넘어갑니다.",
	    		             buttons : false,
	    		          });
	    		         setTimeout("window.location='logout'", 1000);
            		}
            	});
            }
         });
      });
      
      $('.imgUpload').click( () => {
      	$('.attachBtn').click();
      });
      
      $('.deleteImg').click( () => {
    	  $.ajax({
    		  url: "baseProfileImg",
    		  method: "post",
    		  data: {"userId" : '${user.userId}'},
    		  success: baseProfileImg => {
    	    	  swal({
    	              title: "프로필사진이 삭제되었습니다.",
    	              text: " ",
    	              buttons : {},
    	              timer: 1000
    	           });
    	    	  setTimeout("window.location.reload()", 1000);
    		  }
    	  });
      });
      
      $(".attachBtn").on("change", miri1);
      
      
   });
   
   function miri1(e) {
   	   var files = e.target.files;
   	   var filesArr = Array.prototype.slice.call(files);
   	   
   	   filesArr.forEach(function(f){
   		   if(!f.type.match("image.*")) {
   			swal({
                title: "확장자는 이미지 확장자만 가능합니다.",
                text: " ",
                buttons : {},
                timer: 1000
             });
   			   $(".attachBtn").val("");
   			   return;
   		   }
   		   
   		   var sel_file = f;
   		   
   		   var reader = new FileReader();
   		   reader.onload = function(e) {
   			   $(".myProfileImg").attr("src", e.target.result);
   				let data = new FormData($('form')[0]);
   			   $.ajax({
   				   url: "profile",
   				   method: "post",
   				   data,
   				   processData: false,
   				   contentType: false,
   				   success: result => {
   					swal({
   		              title: "프로필사진이 변경되었습니다.",
   		              text: " ",
   		              buttons : {},
   		              timer: 1000
   		           });
   				   }
   			   });
   			$('#photoChange').modal("hide");
   		   }
   		   reader.readAsDataURL(f);
   	   });
      };
</script>
<style>

.swal-footer {
   text-align: center;
}

.grayBtn{
   background: lightgray;
   margin-left: 50px;
}

.swalText .swal-text{
   font-weight: bold;
   font-size: 20px;
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
   margin-left: 22px;
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
   margin-top: 13px;
   margin-bottom: 10px;
   font-weight: bold;
}

#photoChangeBtn{
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


.modalOpt {
   cursor: pointer;
   height: 50px;
   text-align: center;
   vertical-align: center;
   font-size: 14px;
   padding-top: 15px;
}

.modalOpt:hover {
   background: #F7F6F6;
}

.modalHr{
   margin: 0px;
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
<div style="background: #FBFEFF;">
   <div style="width: 1140px; margin: 0 auto;">
      <div class="flex main">
         <div class="profileEditFrame">
         
            <div class="myProfileImgDiv">
               <img class="myProfileImg" src="../attach/${user.profileImg}"></img>
               <form><input type="file" name="attachFile" class="attachBtn" style="display: none;"/></form>
               <div class="myProfileNameDiv">
                  <div class="myProfileName" value="${user.userId}">${user.userId}</div>
                  <a id="photoChangeBtn">프로필 사진 바꾸기</a>
               </div>
            </div>
            
            <div class="formDiv">
               <form class="form-horizontal">
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="userName">이름</label>
                     <div class="col-sm-10">
                        <input id="userName" type="text" class="form-control" value="${user.userName}">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="userTel">전화번호</label>
                     <div class="col-sm-10">
                        <input id="userTel" type="text" class="form-control" (변경 시 번호만 입력)" value="${user.phoneNum}">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="userEmail">이메일</label>
                     <div class="col-sm-10">
                        <input id="userEmail" type="text" class="form-control" value="${user.email}">
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="userName">성별</label>
                     <div class="col-sm-10">
                        <select class="form-control" id="gender">
                           <c:if test="${user.gender eq '여'}">
                           <option>남</option>
                           <option selected="selected">여</option>
                           </c:if>
                           <c:if test="${user.gender eq '남'}">
                           <option>여</option>
                           <option selected="selected">남</option>
                           </c:if>
                        </select>
                     </div>
                  </div>
                  
                  <div class="form-group">
                     <label class="control-label col-sm-2" for="userBirthday">생년월일</label>
                     <div class="col-sm-10">
                        <input id="userBirthday" type="date" class="form-control" value="${user.birthday}">
                     </div>
                  </div>
                  
                  
                  <div class="form-group">
                     <div class="col-sm-offset-2 col-sm-10 btnDiv">
                        <button type="button" id="editBtn" class="btn colorBtn">수정</button>
                        <button type="button" id="pwChangeBtn" class="btn colorBtn">비밀번호 변경</button>
                        <button type="button" id="secessionBtn" class="btn btn-danger floatLeft">탈퇴</button>
                     </div>
                  </div>
               </form>
            </div>
            
         </div>
      </div>
   </div>
</div>
<div class="modal fade modal-center" id="photoChange" role="dialog">
   <div class="modal-dialog modal-sm modal-center" >
      <div class="modal-content">
         <div class="modal-header" style="text-align: center;">
            <h4 class="modal-title">프로필 사진 바꾸기</h4>
         </div>
         <div class="modal-body" style="padding: 0px;">
            <div class="modalOpt imgUpload" style="color: #337ab7">사진 업로드</div>
            <hr class="modalHr">
            <div class="modalOpt deleteImg" style="color: red">현재 사진 삭제</div>
            <hr class="modalHr">
            <div class="modalOpt closeBtn">취소</div>
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>