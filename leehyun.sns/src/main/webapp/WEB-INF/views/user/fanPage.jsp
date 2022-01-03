<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ include file="../common/include.jsp" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>SNS</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

$(() => {
		let complaintPostNum;
	  	$.ajax({
    	url: 'chkFan',
    	data: {"toUserId": $("#friend").attr("value")},
    	success: chkFan => {
    		if(chkFan){
    			$('.fanOutBtn').show(),
        		$('.fanInBtn').hide()
    		}else{
    			$('.fanOutBtn').hide(),
        		$('.fanInBtn').show()
    		}
    	},
    	error: (a, b, err) => {
    		$('.fanOutBtn').hide(),
    		$('.fanInBtn').show()
		}
	})
	
	$('#yes').click( () => {
		swal({
		title: "게시물을 신고하시겠습니까?",
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
					url: "../complaint",
					data: {"complaintType": $(".singoContent").val(),
							"postNum": complaintPostNum,
							"userNum": "${user.userNum}"},
					success: complaint => {
						if(complaint == 0)
							swal({
								title: "신고 내용을 선택해주세요."
							})
						else if(complaint == 1)
							swal({
								title: "게시물이 신고 되었습니다."
							})
						else if(complaint == 2)
							swal({
								title: "이미 신고한 게시물입니다."
							})
						else
							swal({
								title: "신고 오류 발생."
							})
					}
				});
				$("#singo").modal("hide");
			}
		});
	}); 
    
	$(".singoBtn").click((e)=> {
		complaintPostNum = $(e.currentTarget).attr("value");
		$("#singo").modal("show");
	})
	
	$('.postCommentDiv').each(function (){
    	 if($(this).children().length == 0){
    		 $(this).append(`<div class="noList" style="text-align: center; font-size: 20px; padding-top: 260px;">댓글이 없습니다.</div>`);
    	 }
     });
	
    $('.fanInBtn').click( () => {
		swal({
			title: "FAN이 되시겠습니까?",
			buttons: {
               ok : {
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
                	url: 'addFan',
                	data: {"toUserId": $("#friend").attr("value")},
                	success: addfan => {
                		swal({
                			title:$("#name").text()+'님의 fan이 되었습니다.',
                			buttons:{
                				ok:{
                					text : "확인",
                	                value : true,
                				}
                			},
                		}).then((result) => {
                			location.reload();
                		})
                	},
                	error: (a, b, err) => {
                		swal({
                			title:"실패",
                		})
                	}
				})
			}
		})
    });
	
	$(".postCommentOwner").click((e)=>{
		let userId = $(e.currentTarget).text();
		if(userId != "${user.userId}"){
			$.ajax({
				 url: "fanPageId",
				 method: 'post',
				 data: {"userId": userId},
				 success: userId => {
					  location.href="fanPage";
				}
			});
		}
	});
    
    $('.fanOutBtn').click( () => {
    	swal({
            title: "FAN을 끊으시겠습니까?",
            buttons: {
               ok : {
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
                	url: 'removeFan',
                	data: {"toUserId": $("#friend").text()},
                	success: removefan => {
                		swal({
                			title:$("#friend").text()+'님과 fan을 끊었습니다.',
                			buttons:{
                				ok:{
                					text : "확인",
                	                value : true,
                				}
                			},
                		}).then((result) => {
                			location.reload();
                		})
                	},
                	error: (a, b, err) => {
                		swal({
                			title:"실패",
						})
					}
				})
			}
		})
	});
    
    $('.messageSend').click( (e) => {
    	let targetUserNum = $(e.currentTarget).attr("name");
    	$.ajax({
        	url: '../message/addchatting',
        	data: {"toUserNum": targetUserNum},
        	success: result => {
        		location.href="../message/" + result;
        	},
        	error: (a, b, err) => {
        		swal({
        			title:"채팅방 찾기 실패",
				})
			}
		})
    });
    
	$(".friendClick").click(()=>{
		window.location="fanList2";
	});
	
	$(".commentBtn").click((e)=>{
		let getpostNum = $(e.currentTarget).val();

		$.ajax({
			url: "../common/mypage/comments",
			data: {"postNum": getpostNum,
				"userNum": "${user.userNum}",
				"commentContent": $(e.currentTarget).siblings().eq(0).val()},
			success: addComments => {
				$.ajax({
						url: "../mypage/list",
						data: {},
						success: listComment => {
						}
					});
				location.reload();
			}
		});
	});
	
	$(".xBtn").click((e)=>{
		$.ajax({
		url: "../common/delComment",
		data: {"commentNum": $(e.currentTarget).attr("value")},
		success: delComment => {
			location.reload();
		}
		});
	});
	
   likeList();
   
   $(".likeBtn").click((e)=>{
         let getpostNum = $(e.currentTarget).val();
         let likeType = $(e.currentTarget).children().eq(0).attr("value");
         $.ajax({
            url: "../plusLike",
            data: {"postNum": getpostNum,
               "likeType": likeType},
            success: plusLike => {
               likeList();
            }
         });
      });
});

function likeList(){
	   $.ajax({
	      url: "../like",
	      success: (arr)=>{
	    	  $('.icon').text(" 0");
	          $('.icon').css("color", "gray");
	         
	          for(let i=0; i< arr.length; i++){
	            $('span[name=l' + arr[i].postNum + ']').text(" " + arr[i].likeCnt);
	            $('span[name=d' + arr[i].postNum + ']').text(" " + arr[i].disLikeCnt);
	            if(arr[i].myState == 'like')
	               $('span[name=l' + arr[i].postNum + ']').css("color", "blue");
	            else if(arr[i].myState == 'dislike')
	               $('span[name=d' + arr[i].postNum + ']').css("color", "red");
	         }
	      }
	   });
	}
</script>
<style>
.icon{
	color: gray;
}

.swal-footer {
   text-align: center;
}

.grayBtn{
   background: lightgray;
   margin-left: 50px;
}

.myPageProfImgSpace {
   flex-grow: 1;
   display: flex;
   text-align: center;
   justify-content: center;
}

.myPageProfImg {
   border: 1px solid;
   border-radius: 50%;
   width: 150px;
   height: 150px;
}

.myPageInfo {
   flex-grow: 1;
}

.myPageProfId {
   font-size: 40px;
   margin-bottom: 10px;
}

.profile {
   display: flex;
   margin-bottom: 30px;
}

.profBtn {
   display: inline-block;
   margin-left: 160px;
   font-size: 15px;
}

.fanInBtn, .fanOutBtn, .messageSend {
   background: white;
   border-radius: 5px;
   border: 1px solid #A593E0;
   background: #A593E0;
   color: white;
   height: 30px;
   width: 100px;
   margin-right: 15px;
}

.myPageProfName {
   display: inline-block;
}

.myPageProfFriend {
   margin-bottom: 15px;
}

p {
   display: inline-block;
   font-size: 15px;
}

.myPageTitle {
   font-weight: bold;
   margin-right: 13px;
}

.myPageCnt {
   margin-right: 20px;
}

.post {
   display: flex;
   justify-content: center;
}

.top {
   position:fixed; 
   bottom: 30px; 
   right:30px; 
   background: #A593E0;
   border-radius: 5px;
   height: 30px;
   width: 100px;
}

.postClick, .friendClick{
   cursor: pointer;
   display: inline-block;
}

#no, #yes{
   background:#A593E0;
   color: white;
   border: 1px solid white;
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
/* 여기부터 post 관련 style(main에서 그대로 따옴) */
.ownerProfileName {
   font-size: 29px;
   font-weight: bold;
   margin-top: 25px; /* 여기 수정함 */
}

.profileImg {
   background: white;
   width: 50px;
   height: 50px;
   margin-left: 10px;
   margin-right: 20px;
   border: 1px solid;
   margin-top: 25px; /* 여기 수정함 */
   border-radius: 50%;
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

.post {
   margin: 20px;
   margin-top: 30px;
   margin-bottom: 30px;
   background: white;
   height: 720px;
   display: flex;
}

.postLeft {
   width: 520px;
}

.postImg {
	height: 520px;
	border-top: 3px solid #A593E0;
	border-left: 3px solid #A593E0;
	border-right: 1px solid #A593E0;
	border-bottom: 1px solid #A593E0;
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
	align-items: center;
}

.postContentDiv {
   height: 200px;
   border-left: 3px solid #A593E0;
   border-right: 1px solid #A593E0;
   border-bottom: 3px solid #A593E0;
}

.likeBtn {
   margin-left: 5px;
   margin-top: 5px;
   background: white;
   font-size: 25px !important;
}

.singoBtn, .updateBtn{
   margin-right: 10px;
   margin-top: 10px;
   float: right;
   background: white;
}

.postContent {
   font-size: 18px;
}

.contentDate {
   margin: 10px;
}

.postRight {
   width: 330px;
}

.postOwner {
   height: 100px;
   margin: 0px;
   border-top: 3px solid #A593E0;
   border-right: 3px solid #A593E0;
}

.postCommentFrame {
   height: 580px;
   border-top: 1px solid #A593E0;
   border-right: 3px solid #A593E0;
}

.postCommentDiv {
   margin: 5px;
}

.postCommentOwner {
   display: inline-block;
   font-size: 20px;
   margin-top: 5px;
   margin-left: 10px;
   font-weight: bold;
}

.postCommentContent {
   display: inline-block;
   font-size: 15px;
   margin-top: 10px;
   margin-bottom: 10px;
   margin-left: 20px;
   margin-light: 20px;
}

.postCommentInDiv {
   height: 50px;
   display: flex;
}

.postCommentDate {
   margin-left: 10px;
   margin-bottom: 10px;
   color: #B0AEB0;
}

.commentIn {
   flex: 5;
   border-top: 1px solid #A593E0;
   border-bottom: 3px solid #A593E0;
   border-left: none;
   border-right: none;
   height: 40px;
}

.commentBtn {
   flex: 1;
   background: #A593E0;
   color: white;
   height: 40px;
}

.xBtn {
  float: right;
  display: inline-block;
  font-size: 20px;
  margin-top: 5px;
  cursor: pointer;
  color: gray;
}

.postInfo{
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
	align-items: center;
}

.postInfoText{
	margin: 20px;
	margin-top: 30px;
	margin-bottom: 30px;
	width: 420px;
	height: 200px;
	font-size: 28px;
	color: #876DA2;
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
	align-items: center;
}

img {
	max-height: 100%;
	max-width: 100%;
}
</style>
</head>
<header></header>
<body>
<div style="background:#FBFEFF;">
   <div class='container' style="padding: 30px 20px 0;">
      <div class='profile'>
         <div class='myPageProfImgSpace'>
            <img class='myPageProfImg' src="../attach/${fanuser.profileImg}" ></img>
            
         </div>
         <div class='myPageInfo'>
            <div class='myPageProfId' id="friend" value=${fanuser.userId}>${fanuser.userId}</div>
            <div class='myPageProfFriend'>
               <div class="postClick">
                  <p class="myPageTitle">게시물</p>
                  <p class="myPageCnt">${postCnt}</p>
               </div>
               <div class="friendClick">
                  <p class="myPageTitle">FAN</p>
                  <p class="myPageCnt">${cntFan1}</p>
                  <p class="myPageTitle">STAR</p>
                  <p class="myPageCnt">${cntStar1}</p>
               </div>
            </div>
            <div class='myPageProfName'>
               <h4 id ='name'>${fanuser.userName}</h4>
            </div>
            <div class='profBtn'>
               <button class='messageSend' name=${fanuser.userNum}>메세지</button>
               <button class='fanInBtn'>FAN 맺기</button>
               <button class='fanOutBtn'>FAN 끊기</button>
            </div>
         </div>
      </div>
      <hr>
		<c:choose>
			<c:when test="${fn:length(postList) > 0}">
				<c:forEach var="post" items='${postList}'>
					<div class='post'>
						<div class="postLeft">
							<div class="postImg"><img src='<c:url value="/attach/${post.postImg}"/>'/></div>
							<div class="postContentDiv">
								<div class="postContentBtnBar">
									<button class="likeBtn btn" name="l${post.postNum}" value="${post.postNum}">
	                                    <span class="glyphicon icon glyphicon-thumbs-up"
	                                       name="l${post.postNum}" value="like" style="font-size: 25px;"> 0</span>
	                                 </button>
	                                 <button class="likeBtn btn" name="d${post.postNum}" value="${post.postNum}">
	                                    <span class="glyphicon icon glyphicon-thumbs-down"
	                                       name="d${post.postNum}" value="dislike" style="font-size: 25px;"> 0</span>
	                                 </button>
									<button class="singoBtn btn" value="${post.postNum}">신고</button>
								</div>
								<hr style="margin: 3px;">
								<div class="postContent">
									<div class="contentDate">${post.regDate}</div>
									<pre style="background: none; border: 0px solid; font-size: 18px;">${post.postContent}</pre>
								</div>
							</div>
						</div>
						<div class="postRight">
							<div class="profile postOwner">
								<img class="profileImg" src="../attach/${fanuser.profileImg}"></img>
								<div class="ownerProfileName">${fanuser.userId}</div>
							</div>
							<div class="postCommentFrame scroll">
								<div class="postCommentDiv">
									<c:forEach var="comment" items="${comments}">
										<c:if test="${comment.postNum eq post.postNum}">
										<div class="postCommentOwner">${comment.userId}</div>
										<c:if test="${user.userId eq comment.userId}">
										<a class="xBtn" value="${comment.commentNum}">&times;</a>
										</c:if>
										<br>
										<div class="postCommentContent">${comment.commentContent}</div>
										<div class="postCommentDate">${comment.commentTime.toLocaleString().substring(0, comment.commentTime.toLocaleString().length()-3)}</div>
										<hr style="margin: 0px;">
										</c:if>
									</c:forEach>
								</div>
							</div>
							<div class="postCommentInDiv">
								<input class="commentIn" type="text" />
								<button value="${post.postNum}" class="commentBtn btn">게시</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class='postInfo'>
					<div class='postInfoText'>
						등록된 게시물이 없습니다.
						<p style='font-size: 18px; margin-top: 20px; color: #AE9BC1;'>당신의 새로운 <strong>이야기</strong>를 등록해보세요!</p>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		</div>
   <div class="top" style="display: flex;justify-content: center; align-items: center;">
   <a href="#" style="color: white;"><span class="glyphicon glyphicon-arrow-up"> TOP</span></a>
   </div>
</div>
</body>
<div class="modal fade modal-center" id="singo" role="dialog">
   <div class="modal-dialog modal-sm modal-center">
      <div class="modal-content">
         <div class="modal-header">
            <button class='close' data-dismiss='modal'>&times;</button>
            <h4 class="modal-title">게시물 신고</h4>
         </div>
         <div class="modal-body" style='text-align: center;'>
            <select class="singoContent" style="height: 30px;">
                  <option value="">신고내용</option>
                  <option>음란성 게시물</option>
                  <option>폭력성 게시물</option>
                  <option>자살유도 및 유해 게시물</option>
                  <option>불법광고성 게시물</option>
                  <option>명예훼손 게시물</option>
               </select>
         </div>
         <div class='modal-footer'>
            <button type="button" class="btn btn-default" id="yes" style="float: left; background: #A593E0; color: white;">신고하기</button>
            <button type="button" class="btn btn-default" id="no" class="close" data-dismiss="modal" style="background: #A593E0; color: white;">취소</button>
         </div>
      </div>
   </div>
</div>
</html>
<%@ include file="../common/footer.jsp" %>