<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>
<script>
let isIdBtn = false;
let isCertifyBtn = false;
let emailRanNum = 0;
   $( () => {
		$('.logoImg').click( () => {
			location.href = 'login';
		});
	   
      $("#agreeLink").click(()=>{
         $("#agreeContent").modal("show");
      });
      
      $("#addUser").click((e)=>{
         e.preventDefault();
         if(!isValidDate($("#birthday").val())){
            swal({
               title: "없는 날짜입니다.",
               type: "warning",
            });
         }else if($("#phoneNum").val().length < 10 || $("#phoneNum").val().length > 11){
            swal({
               title: "전화번호가 올바른 형식이 아닙니다.",
               type: "warning",
            });
         }else if($("#userPw").val() != $("#userPw2").val()) {
            swal({
               title: "비밀번호가 다릅니다.",
               type: "warning",
            });
         }else{
         
         $.ajax({
            url: 'addUser',
            method: 'post',
            data: {"userName" : $('#userName').val(), "userId" : $('#userId').val(), "password" : $('#userPw').val(), "email" : $('#email').val(), "birthday" : $('#birthday').val(), "phoneNum" : $('#phoneNum').val(), "gender" : $('#gender').val()},
            success: adduser => {
               swal({
                  title: "가입되었습니다.",
                  type: "success",
                  
               }, function(){
                  window.location = "login";
               });
            },
            error: (a, b, err) => 
            swal({
               title:"잘못된 정보가 있습니다.",
               type: "error",
            })
         });
         }
      });
      
      $("#idCkBtn").click(()=> { /* 중복확인버튼 */
         $.ajax({
            url: "findUser",
            data:{"userId" : $('#userId').val()},
            success: findUser => {
               if(findUser == $('#userId').val()) {
                  swal({
                     title:"이미 존재하는 아이디입니다.",
                     type: "error",
                  })
               }
            },
            error : (a, b, err) => {
               if($("#userId").val().length < 2) {
                  swal({
                     title: "아이디를 2자 이상 입력하세요.",
                     type: "warning",
                  })
               } else {
                  swal({
                  title: "사용가능한 아이디입니다.",
                  type: "success",
                  
                  })
               };
               isIdBtn = true;
               isDisabled();
            }
         });
      });
      
      /*이메일 보내기*/
      $("#emailCkBtn").click(()=> {
         emailRanNum = Math.floor(Math.random() * 100000);
         if(CheckEmail($("#email").val())){
            $.ajax({
               url: "mail",
               data: {"email" : $("#email").val(), "emailNum" : emailRanNum},
               success:
                  swal({
                     title: "메일 보내기 성공",
                     type: "success",
                  })
            });
         } else {
            swal({
               title: "메일 형식이 올바르지 않습니다.",
               type: "warning",
            })
         }
      });
      
      /*이메일 인증 */
      $("#certifyBtn").click(()=>{
         if($("#certify").val() == emailRanNum){
            isCertifyBtn = true;
            isDisabled();
            swal({
               title: "이메일 인증 됐습니다.",
               type: "success",
            });
         }else{
            swal({
               title: "이메일 인증 실패",
               type: "warning",
            });
         }         
      });
      
      $("#email").on("propertychange change keyup paste input", function() {
         isCertifyBtn = false;
         isDisabled();
      });
   });
   
function isDisabled() {
   if(isIdBtn && isCertifyBtn) 
      $("#addUser").attr("disabled", false);
   else
      $("#addUser").attr("disabled", true);
}

function isLeaf(year) {
   var leaf = false;

   if(year % 4 == 0) {
   leaf = true;
   if(year % 100 == 0) leaf = false;
   if(year % 400 == 0) leaf = true;
   }
   return leaf;
}

// 날짜가 포맷에 맞고 윤연에 해당하는지 실제 날짜 유효성 검사
function isValidDate(d) {
   var month_day = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

   var dateArray = d.split('-');
   var year = Number(dateArray[0]);
   var month = Number(dateArray[1]);
   var day = Number(dateArray[2]);

   if(year > 9999) return false;
   if(day == 0) return false;
   
   var isValid = false;

   // 윤년
   if(isLeaf(year)) {
   if(month == 2) {
   if(day <= month_day[month-1] + 1) isValid = true;
   } else {
   if(day <= month_day[month-1]) isValid = true;
   }
   } else {
   if(day <= month_day[month-1]) isValid = true;
   }
   return isValid;
}

function CheckEmail(str) {                                                 
     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
     if(!reg_email.test(str)) {                            
          return false;         
     } else {                       
          return true;         
     }                            
}   
</script>
<style>
.back{
   background: #F8F8FF;
   position: relative;
   z-index: 0;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
}

.signUpcontainer {
   height: 942px;
   display: flex;
   justify-content: center;
   align-items: center;
}

.signUpframe {
   width: 750px;
   height: 900px;
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
   margin: 40px;
   cursor: pointer;
}

.inp{
   width: 400px;
   margin: 10px;
   height: 40px;
   border-radius: 4px;
   background: #F8F8FF;
   text-align: center;
   border: 1px solid #8C9FFB;
}

.idInDiv{
   position: relative;   
}

.idCkBtn {
   background: #BDC6F4;
   position: absolute;
   height: 40px;
   border: 1px solid #8C9FFB;
   border-bottom-right-radius: 4px;
   border-top-right-radius: 4px;
   top: 10px;
   right: 10px;
}

.emailInDiv{
   position: relative;   
}

.emailCkDiv{
   position: relative;   
}

.emailCkBtn {
   background: #BDC6F4;
   position: absolute;
   height: 40px;
   border: 1px solid #8C9FFB;
   border-bottom-right-radius: 4px;
   border-top-right-radius: 4px;
   top: 10px;
   right: 10px;
}

.genderIn {
   text-align-last: center;
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
}

.phoneIn{
   -webkit-appearance: none;
   -moz-appearance: none;
   appearance: none;
}

.signUpBtn {
   width: 400px;
   margin: 20px;
   height: 40px;
   border-radius: 4px;
   background: #BDC6F4;
}

.agree {
   width: 70%;
   height: 40px;
   margin: 15px;
   background: white;
   text-align: center;
   color: gray;
}

#agreeLink {
   font-weight: bold;
   color: gray;
   cursor: pointer;
}
</style>

<div class="back">
<form>
   <div class='container signUpcontainer'>
      <div class="signUpframe gradient-border">
         <img class='logoImg' src="<c:url value="/attach/common/logo" />"></img>
               <input class="nameIn inp" type="text" id="userName" 
               placeholder="이름" maxlength="13"/>
         <div class="idInDiv">            
            <input class="idIn inp" type="text" id="userId" 
            placeholder="아이디" maxlength="13"/>
            <button class="idCkBtn" id="idCkBtn" type="button">중복확인</button>
         </div>
         <input class="pwIn inp" type="password" id="userPw"
         placeholder="비밀번호" maxlength="13"/>
         <input class="pwCkIn inp" type="password" id="userPw2" placeholder="비밀번호 확인" pattern=".{2,13}"/>
         <select class="genderIn inp" id="gender" >
            <option value="" disabled selected hidden >성별 ▼</option>
            <option>남</option>
            <option>여</option>
         </select>
               
         <input class="phoneIn inp" type="number" id="phoneNum" placeholder="전화번호 (번호만 입력해주세요.)" maxlength="11"/>
         <input placeholder="생년월일" class="birthIn inp" type="text" onfocus="(this.type='date')" id="birthday">
               
         <div class="emailInDiv">            
            <input class="emailIn inp" type="email" id="email" placeholder="이메일 "/>
            <button class="emailCkBtn" type="button" id="emailCkBtn">본인확인</button>
         </div>
         <div class="emailCkDiv">
            <input class="emailIn inp" type="text" id = "certify" placeholder="이메일 인증코드" maxlength="6"/>
            <button class="emailCkBtn" type="button" id="certifyBtn">인증하기</button>
          </div>
          
         <button type="submit" class="btn signUpBtn" id="addUser" disabled>가입</button>
         <br>
         <p class='agree'>가입하면 SNS의 <a id='agreeLink'><u>약관, 데이터 정책 및 쿠키 정책</u></a>에 동의하게 됩니다.</p>
      </div>
   </div>
</form>
</div>

<div class="modal fade" id="agreeContent" role="dialog">
   <div class="modal-dialog" >
      <div class="modal-content">
         <div class="modal-header">
            <h4 class="modal-title">약관 데이터 정책 및 쿠키 정책</h4>
         </div>
         <div class="modal-body" style="overflow: auto; height: 600px;">
            <p><b>Fanple에 오신 것을 환영합니다!</b><br>
            본 약관은 회원님의 Fanple 이용에 적용되며, 아래 설명된
               Fanple 서비스에 관한 정보를 제공합니다. 회원님이 Fanple 계정을 만들거나 Fanple을 이용하면 회원님은 본
               약관에 동의하는 것입니다.<br><br><b> 창작, 연결, 커뮤니케이션, 발견 및 공유를 위한 맞춤화된 기회를 제공합니다.</b><br>사람들은
               다양합니다. 당사는 회원님이 실제로 관심을 가지는 경험을 공유함으로써 관계를 강화하길 원합니다. 따라서 당사는 회원님 및
               다른 사람들이 관심 있는 사람과 사항을 파악하는 시스템을 구축하고 파악한 정보를 이용함으로써 회원님에게 중요한 경험을
               창작하고, 발견하며, 동참하고, 공유하도록 합니다. 그 일환으로, 회원님 및 다른 사람들이 Fanple 안팎에서 하는
               활동에 기초하여 회원님이 관심을 가질 만한 콘텐츠, 기능, 제안 및 계정을 더 잘 보여드리고, 회원님에게 Fanple을
               경험하는 방법을 제안하기도 합니다.<br><br><b>데이터 정책</b><br>Fanple 서비스를 제공하기 위해서는 회원님의 정보를 수집하고 이용해야
               합니다. 데이터 정책은 Fanple 제품에서 저희가 정보를 수집, 이용하고 공유하는 방법에 대해 설명합니다.
               또한 Fanple 개인정보 보호 및 권한 설정을 포함해 회원님의 정보를 관리할 수 있는 여러 방법에 대해 설명합니다.
               Fanple을 이용하려면 데이터 정책에 동의해야 합니다.<br><br><b>회원님의 약속</b><br>Fanple 서비스 제공에 대한 당사의 약속에
               대해 회원님은 다음과 같은 약속을 해야 합니다. <b>Fanple을 이용할 수 있는 주체.</b> 당사는 Fanple 서비스가 가능한
               개방적이고 포괄적인 서비스가 되기를 원하지만, 본 서비스가 안전하고, 보안성을 갖추며, 법을 준수하는 서비스가 되기를
               원하기도 합니다. 따라서 회원님이 Fanple 커뮤니티에 참여하려면 몇 가지 제한 사항을 준수해야 합니다.<br><br>만 14세
               이상이어야 합니다.<br>관련 법률에 따라 Fanple 서비스를 받는 것이 일부라도 금지된 사람 또는 관련 제재 대상 명단에
               있어 결제 관련 Fanple 서비스를 이용하는 것이 금지된 사람이 아니어야 합니다.<br><b>Fanple을 사용할 수 없는 경우.</b>광범위한 커뮤니티에 안전하고 개방적인 Fanple 서비스가 제공되기 위해서는 우리 모두가 각자의 본분을 다해야 합니다.<br><br>
               <b>다른 사람을 사칭하거나 부정확한 정보를 제공하면 안 됩니다.</b><br>
               Fanple에서 회원님의 신원을 공개할 필요는 없지만 정확한 최신 정보(등록 정보 포함)를 제공해야 합니다. 또한 본인이 아닌 다른 사람을 사칭해서는 안 되며, 다른 사람의 명시적인 허락 없이 다른 사람의 이름으로 계정을 만들면 안 됩니다.
               <br><b>불법적이거나, 오해의 소지가 있거나, 사기적인 행위 또는 불법적이거나 허가받지 않은 목적을 위한 어떠한 행위도 하면 안 됩니다.
특히 Fanple 커뮤니티 가이드라인, Fanple 플랫폼 정책, 음악 가이드라인을 포함하여 본 약관 또는 저희 정책을 위반하거나 다른 사람들이 위반하도록 돕거나 조장해서는 안 됩니다.</b>행위 또는 콘텐츠를 신고하는 방법은 고객 센터에서 알아보세요.
<b>Fanple 서비스의 정상적인 운영을 방해하거나 지장을 주는 어떠한 일도 해서는 안 됩니다.
허가받지 않은 방법으로 계정을 만들거나 정보에 접근하거나 정보를 수집하려 해서는 안 됩니다.</b><br>여기에는 당사의 명시적 허락 없이 자동화된 방법으로 계정을 만들거나 정보를 수집하는 것이 포함됩니다.<br><b>회원님의 계정 일부(사용자 이름 포함)를 구입, 판매 또는 양도하거나, 다른 사용자의 로그인 정보 또는 배지를 요청, 수집 또는 사용하려고 시도해서는 안 됩니다.
</b><br><b>개인 정보 또는 기밀 정보를 게시하거나 지적 재산을 포함한 타인의 권리를 침해하는 어떠한 행위도 해서는 안 됩니다.</b><br>여기에서 회원님의 지적 재산권을 침해한다고 생각되는 콘텐츠를 신고하는 방법을 포함한 자세한 내용을 알아보세요.<br><b>당사의 사전 서면 동의 없이 회원님의 사용자 이름에 도메인 이름이나 URL을 사용하면 안 됩니다.
</b><br><b>회원님이 당사에 부여한 권한. </b>본 계약의 일부로서, 회원님은 당사가 회원님에게 Fanple 서비스를 제공하기 위해 필요로 하는 권한을 함께 부여합니다.<br><br><b>회원님의 사용자 이름, 프로필 사진 및 회원님의 관계 및 행동에 관한 정보를 계정, 광고 및 홍보 콘텐츠에 이용할 수 있는 권한.</b><br>회원님은 당사에 회원님의 사용자 이름, 프로필 사진 및 회원님의 활동(예: "좋아요") 또는 관계(예: "팔로우")에 관한 정보를 Facebook 제품 전반에 표시되는 계정, 광고, 제안 및 회원님이 팔로우하거나 참여하는 기타 홍보 콘텐츠와 함께 또는 이와 관련하여 표시할 수 있는 권한을 무상으로 부여합니다. 예를 들어, 당사는 회원님이 Fanple에 유료로 광고를 게재하는 브랜드의 홍보 게시물을 좋아했다는 점을 표시할 수 있습니다. 다른 콘텐츠에서의 행동 및 다른 계정의 팔로우와 마찬가지로, 홍보 콘텐츠에서의 행동 및 홍보 계정의 팔로우도 해당 콘텐츠나 팔로우를 볼 수 있는 권한이 있는 사람들에게만 표시됩니다. 당사는 회원님의 광고 설정도 존중합니다. 여기에서 회원님의 광고 설정에 대해 자세히 알아보실 수 있습니다.
<br><br><b>회원님은 당사가 회원님의 기기에 Fanple 서비스 업데이트를 다운로드하고 설치할 수 있다는 것에 동의합니다.
</b><br><br>개정: 2020년 6월 16일
            </p>
         </div>
         <div class='modal-footer'>
            <button type="button" class="btn btn-default" id="no" class="close" data-dismiss="modal">확인</button>
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp" %>