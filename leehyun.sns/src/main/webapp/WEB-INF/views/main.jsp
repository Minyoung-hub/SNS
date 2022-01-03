<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ include file="common/include.jsp"%>
<%@ include file="common/header.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
$( () => {
	let complaintPostNum;
	let content;
	$.ajax({
	   url: "user/listStars",
	   data:{"toUserId": $(".myProfileName").attr("value")},
	   success: (users) => {
	      $('#friendList').empty();
	
	      if(users.length > 0){
	         let fanList = [];
	         for(let i = 0; i < users.length; i++){
	            fanList.push(
	               "<div class='profile2' id= 'profile' value=" 
	               + users[i].userId + ">"
	               +"<div><img class='profileImg' src=attach/"
	               + users[i].profileImg + "></img></div>"
	               +"<div id='profileName'>"
	               + users[i].userName + "</div></div>"
	            ); 
	         }
	         $('#friendList').append(fanList.join(''));
	      }else{
	         $('#friendList').append('');
	         $('#friendList').append("<hr><br><div style='font-size: 20px; text-align: center; color: #876DA2;'>STAR가 없습니다.</div>"
	               +"<div style='font-size: 15px; margin-top: 20px; color: #AE9BC1; text-align: center;'>당신의 <strong>STAR</strong>를 등록해보세요!</div>");
	      }
	      
	  	$(".profile2").click((e)=>{ 
			let userId = $(e.currentTarget).attr("value");
			$.ajax({
				 url: "user/fanPageId",
				 method: 'post',
				 data: {"userId": userId},
				 success: userId => {
					  location.href="user/fanPage";
				}
			});
		});
	  	
	  	$(".postCommentOwner").click((e)=>{
			let userId = $(e.currentTarget).text();
			if(userId != "${user.userId}"){
				$.ajax({
					 url: "user/fanPageId",
					 method: 'post',
					 data: {"userId": userId},
					 success: userId => {
						  location.href="user/fanPage";
					}
				});
			}
		});
	         
	   if(self.name != 'reload') {
	         self.name = 'reload';
	         self.location.reload(true);
	      }else self.name = '';
	   }
	});
    
   	$("#keyword").keyup(function(){
        let k = $(this).val();
        $(".profile2").hide();
        let temp = $("#friendList > div > div:nth-child(2n+2):contains('"+ k + "')");
        $(temp).parent().show();
     })
     
     $('.postCommentDiv').each(function (){
    	 if($(this).children().length == 0){
    		 $(this).append(`<div class="noList" style="text-align: center; font-size: 20px; padding-top: 260px;">댓글이 없습니다.</div>`);
    	 }
     });
 	
	$(".post").each(function () {
		$(this).on("mousewheel DOMMouseScroll", function (e) {
			e.preventDefault();
			var delta = 0;
			if (!event) event = window.event;
			if (event.wheelDelta) {
				delta = event.wheelDelta / 120;
				if (window.opera) delta = -delta;
			} else if (event.detail) delta = -event.detail / 3;
			var moveTop = null;
			if (delta < 0) {
				if ($(this).next().offset() != undefined) {
				    moveTop = $(this).next().offset().top;
				    scrollMove(moveTop);
				}
			} else {
				if ($(this).prev().offset() != undefined) {
				    moveTop = $(this).prev().offset().top;
				    scrollMove(moveTop);
				}
			}
		});
	});
	
	$('.postCommentFrame').on('mousewheel', function (e) {
	     e.stopPropagation();
	});
	     
	$(".profile").click((e)=>{
		let userId = $(e.currentTarget).attr("value");
		$.ajax({
			 url: "user/fanPageId",
			 method: 'post',
			 data: {"userId": userId},
			 success: userId => {
				  location.href="user/fanPage";
			}
		});
	});
	      
	$(".myProfile").click(()=>{
		window.location="common/mypage";
	});
	
	$(".xBtn").click((e)=>{
		$.ajax({
		url: "common/delComment",
		data: {"commentNum": $(e.currentTarget).attr("value")},
		success: delComment => {
			location.reload();
		}
		});
	});
	
	$(".commentBtn").click((e)=>{
		let getpostNum = $(e.currentTarget).val();

		$.ajax({
			url: "common/mypage/comments",
			data: {"postNum": getpostNum,
				"userNum": "${user.userNum}",
				"commentContent": $(e.currentTarget).siblings().eq(0).val()},
			success: addComments => {
				$.ajax({
						url: "mypage/list",
						data: {},
						success: listComment => {
						}
					});
				location.reload();
			}
		});
	});
	
	/* 게시물 수정 모달창 시작*/
	$('.updateBtn').click( (e) => {
		let getpostNum = $(e.currentTarget).val();
		
		$.ajax({
			url: 'common/post/findPost',
			data: {
				postNum: getpostNum
			},
			success: (result)=> {
				$('#imgOrigin').attr('src', '../attach/' + result.postImg);
				$('#regPostContents').html(result.postContent);
				content = $('#regPostContents').html();
				$('#postEdit').modal("show");
				$('#postEditBtn2').attr('value', result.postNum);
			},
			error: (a, b, err) => {
				swal({
					title: "게시물 읽기에 실패했습니다.",
					icon: "error"
				})
			}
		})
	})

	/* 게시물 수정 */
	$('.postEditBtn2').click((e) => { 
		let getpostNum = $(e.currentTarget).val();

		if(content != $('#regPostContents').val()){
			swal({
				title: "게시물을 수정하시겠습니까?",
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
					let regPostContents = $('#regPostContents').val()
					
					if(regPostContents){
					 $.ajax({
							   url: 'common/post/updatePost',
							   method: 'post',
							   data: {
								   postContent : regPostContents,
								   postNum : getpostNum
							   },
							   success: ()=>{
								   swal({
					        		   title: "게시물이 수정 되었습니다.",
					        		   icon: "success",
					        		   text: " ",
					        		   buttons: false,
					        	   }),
					        	   setTimeout("location.reload()", 1000);
							   },
							   error: (a, b, err) =>
								   swal({
									   title: "게시물 수정에 실패했습니다.",
									   icon: "error"
								   })
						   })
					}else{
						swal({
							title: "내용을 제대로 입력하셨나요?",
							icon: "info"
						})
					}
				}
			});
		}else{
			swal({
				title: "수정된 내용이 없습니다.",
				icon: "info"
			})
		}
	})

	/* 게시물 삭제 */
	$('.delBtn').click( (e) => {
		let getpostNum = $(e.currentTarget).val();
		
 	   swal({
           title: "게시물을 삭제하시겠습니까?",
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
           		   url: 'common/post/secedePost',
           		   data: {
           			   postNum: getpostNum
           		   },
           		   success: ()=>{
           			   swal({
                   		   title: "게시물이 삭제 되었습니다.",
                   		   icon: "success",
                   			text: " ",
		        		   buttons: false,
                   	   }),
                   	   setTimeout("location.reload()", 1000);
           		   },
           		   error: (a, b, err) =>
   	       			   swal({
   	       				   title: "게시물 삭제에 실패했습니다.",
   	       				   icon: "error"
          		   })
       		   })
           }
        });
     });
	
	/* 게시글 신고 */
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
					url: "complaint",
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
   likeList();
   
   $(".likeBtn").click((e)=>{
         let getpostNum = $(e.currentTarget).val();
         let likeType = $(e.currentTarget).children().eq(0).attr("value");
         $.ajax({
            url: "plusLike",
            data: {"postNum": getpostNum,
               "likeType": likeType},
            success: plusLike => {
               likeList();
            }
         });
      });
});
    
function scrollMove(location) {
   location = location - $(".postLeft").eq(0).offset().top;
   $(".rightDiv").stop().animate({
        scrollTop: location + 'px'
    }, {
        duration: 500, complete: function () {
        }
    });
}
function likeList(){
   $.ajax({
      url: "like",
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
.grayBtn{
   background: lightgray;
   margin-left: 50px;
}

.postInfo{
	display: flex;
	align-items: center;
	justify-content: center;
	height: 500px;
}

.postInfoText{
	font-size: 35px;
	color: #876DA2;
	text-align: center;
}

.icon{
	color: gray;
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

.main {
	height: 800px;
}

.flex {
	display: flex;
}

.leftDiv {
	margin-right: 10px;
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
	flex: 1;
	background-color: #FBFEFF;
	width: 220px;
}

.profile {
	display: flex;
	align-items: center;
	margin: 20px;
	cursor: pointer;
}

.profile2 {
	display: flex;
	align-items: center;
	margin: 20px;
	cursor: pointer;
}

.myProfile {
	display: flex;
	align-items: center;
	margin: 20px;
	margin-top: 0px;
	cursor: pointer;
}

.myProfileImg {
	background: white;
	width: 70px;
	height: 70px;
	margin-right: 20px;
	margin-top: 15px;
	border: 1px solid;
	border-radius: 50%;
}

.myProfileName {
	font-size: 25px;
	margin-top: 13px;
	font-weight: bold;
}

.profileSearchIn {
	margin-left: 20px;
	flex: 5;
	height: 30px;
	width: 100px;
	background: #FBFEFF;
	border-bottom: 2px solid gray;
	border-top: 1px solid white;
	border-left: 1px solid white;
	border-right: 1px solid white;
}

.profileSearchBtn {
	background: #FBFEFF;
	border: 1px solid white;
	flex: 1;
}

.friendList {
	height: 578px;
}

.profileImg {
	background: white;
	width: 50px;
	height: 50px;
	margin-left: 10px;
	margin-right: 20px;
	border: 1px solid;
	border-radius: 50%;
}

#profileName {
	font-size: 18px;
}

.ownerProfileName {
	font-size: 29px;
	font-weight: bold;
}

.rightDiv {
	background: #FBFEFF;
	margin-top: 10px;
	margin-bottom: 10px;
	margin-right: 10px;
	flex: 4;
}

.post {
	margin: 20px;
	margin-top: 30px;
	margin-bottom: 30px;
	background: white;
	height: 720px;
	display: flex;
	justify-content: center;
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

.singoBtn, .delBtn, .updateBtn {
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
	cursor: pointer;
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

img {
	max-height: 100%;
	max-width: 100%;
}

/* 모달 스타일 */
.profDiv {
	display: flex;
	margin-left: 9px;
	margin-bottom: 20px;
}

.profImg {
	border: 1px solid;
	border-radius: 50%;
	width: 60px;
	height: 60px;
	margin-right: 10px;
}

.profName {
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 10px;
}

.postEditprofName {
	margin-top: 15px;
}

.postRegImg {
	border: 1px solid;
	width: 400px;
	height: 400px;
	margin: 20px auto;
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
	align-items: center;
}

.postContentsDiv {
	height: 100px;
}

#postContent {
	width: 400px;
	height: 100%;
	padding: 10px;
	font-size: 18px;
	margin-left: 9px;
}

#regPostContents{
	width: 400px;
	height: 100%;
	padding: 10px;
	font-size: 18px;
	margin-left: 9px;
	color: gray;
}

.postRegBtn, .postEditBtn2 {
	background: #A593E0;
	width: 100%;
	color: white;
}

.modal-dialog.modal-postsize {
	width: 450px;
	height: 780px;
	margin: 0;
	padding: 0;
}

.modal-content.modal-postsize {
	height: auto;
	min-height: 100%;
	border-radius: 0;
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

.swal-footer {
	text-align: center;
}
</style>
</head>
<header></header>
<div style="background: #FBFEFF;">
	<div class='container'>
		<div class=" main flex">
			<div class="leftDiv">
				<div class="myProfile">
					<div><img class="myProfileImg" src="attach/${user.profileImg}"></img></div>
					<div class="myProfileName" value="${user.userId}">${user.userName}</div>
				</div>
				<div class="flex">
					<input class="profileSearchIn" id="keyword" type="text" placeholder="친구 검색"/>
					<button class="profileSearchBtn btn"><span class="glyphicon glyphicon-search" style="color: gray; font-size: 22px;"></span></button>
				</div>
				<div class="friendList scroll" id="friendList">

				</div>
			</div>
			<div class="rightDiv scroll">
				<!-- 게시글 -->
				
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
											<c:if test="${user.userNum eq post.userNum}">
											<button value="${post.postNum}" class="delBtn btn">삭제</button>
											<button value="${post.postNum}" class="postEditBtn updateBtn btn">수정</button>
											</c:if>
											<c:if test="${user.userNum ne post.userNum}">
											<button class="singoBtn btn" value="${post.postNum}">신고</button>
											</c:if>
										</div>
										<hr style="margin: 3px;">
										<div class="postContent">
											<div class="contentDate">${post.regDate}</div>
											<pre id='postContents' style="background: none; border: 0px solid; font-size: 18px;">${post.postContent}</pre>
										</div>
									</div>
								</div>
			
								<div class="postRight">
									<div class="profile postOwner">
										<img class="profileImg" src='<c:url value="/attach/${post.userImg}"/>'/>
										<div class="ownerProfileName">${post.userId}</div>
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
							
							<p style='font-size: 20px; margin-top: 20px; color: #AE9BC1;'>당신의 새로운 <strong>이야기</strong>를 등록해보세요!</p>
						</div>
					</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>
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

<!-- 게시물 수정 모달 -->
	<form id='updateForm'>
		<div class="modal fade modal-center" id="postEdit" role="dialog">
			<div class="modal-dialog modal-postsize modal-center">
				<div class="modal-content modal-postsize">
					<div class="modal-header" style="text-align: center;">
						<h4 class="modal-title">
							게시물 수정
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</h4>
					</div>
					<div class="modal-body">
						<div class="profDiv">
							<img class="profImg" src="../attach/${user.profileImg}"></img>
							<div class="profNameDiv">
								<div class="profName postEditprofName">${user.userName}</div>
							</div>
						</div>
						<div class="postRegImg">
							<img id='imgOrigin' />
						</div>
						<hr>
						<div class="postContentsDiv">
							<textarea id="regPostContents" style="resize: none;"></textarea>
						</div>
	
					</div>
					<div class="modal-footer">
						<button id='postEditBtn2' type="button" class="btn postEditBtn2">수정</button>
					</div>
				</div>
			</div>
		</div>
	</form>
<%@ include file="common/footer.jsp"%>