<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ include file="include.jsp"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(()=>{
	let content;
	/* 친구목록 페이지 이동 */
	$(".friendClick").click(()=>{
		window.location="../user/fanList1";
	});
	
	/* 게시물 등록 모달 시작 */
	$('.postAddBtn').click( () => {
		$('#postContent').val("");
		$('#input_img').val("");
		$("#img").removeAttr("src");
		
		$('#postReg').modal("show");
	});
	
	/* 게시물 수정 모달창 시작*/
	$('.updateBtn').click( (e) => {
		let getpostNum = $(e.currentTarget).val();
		
		$.ajax({
			url: 'post/findPost',
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
	
	/* 이미지 등록 및 미리보기 */
	var sel_file;
	   
	function handleImgFileSelect(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
	      
		filesArr.forEach((f)=>{
			if(!f.type.match("image.*")){
				swal({
					title: "이미지 확장자만 가능합니다.",
					icon: "warning"
				})
				
				$('#input_img').val("");
				$("#img").removeAttr("src");
				
				return;
			}

			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		})
	}
	
	$("#input_img").on("change", handleImgFileSelect);
	
	$(".postCommentOwner").click((e)=>{
		let userId = $(e.currentTarget).text();
		if(userId != "${user.userId}"){
			$.ajax({
				 url: "../user/fanPageId",
				 method: 'post',
				 data: {"userId": userId},
				 success: userId => {
					  location.href="../user/fanPage";
				}
			});
		}
	});
	
	/* 게시물 등록 확인 버튼 */
	$('.postRegBtn').click( () => {
        swal({
           title: "게시물을 등록하시겠습니까?",
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
        	   let data = new FormData($('form')[1]);
        	   
        	   if(data.get('attachFile') && data.get('postContent') && $('#input_img').val()){
        		   $.ajax({
            		   url: 'post/posting',
            		   method: 'post',
            		   data,
            		   processData: false,
            		   contentType: false,
            		   success: ()=>{
            			   swal({
                    		   title: "게시물이 등록 되었습니다.",
                    		   icon: "success",
                    		   text: " ",
			        		   buttons: false,
                    	   }),
                    	   setTimeout("location.reload()", 1000);
            		   },
            		   error: (a, b, err) =>
    	       			   swal({
    	       				   title: "게시물 등록에 실패했습니다.",
    	       				   icon: "error"
    	       			   })
            	   })
        	   }else{
        		   swal({
        			   title: "사진과 내용을 모두 입력하셨나요?",
        			   icon: "info"
        		   })
        	   }
           }
        });
     });
	
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
							   url: 'post/updatePost',
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
           		   url: 'post/secedePost',
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
	
	$(".profEdit").click(()=>{ 
		location.href="../user/modifyUser";
	});
	
	$('.postCommentDiv').each(function (){
   	 if($(this).children().length == 0){
   		 $(this).append(`<div class="noList" style="text-align: center; font-size: 20px; padding-top: 260px;">댓글이 없습니다.</div>`);
   	 }
    });
	
	$(".commentBtn").click((e)=>{
		let getpostNum = $(e.currentTarget).val();

		$.ajax({
			url: "mypage/comments",
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
	
	$(".xBtn").click((e)=>{
		$.ajax({
		url: "delComment",
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
            success: (plusLike) => {
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

img {
	max-height: 100%;
	max-width: 100%;
}

#postContent {
	width: 400px;
	height: 100%;
	padding: 10px;
	font-size: 18px;
	margin-left: 9px;
}

.postRegBtn {
	background: #A593E0;
	width: 100%;
	color: white;
}

.swal-footer {
	text-align: center;
}

.grayBtn {
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

.profEdit, .postAddBtn {
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

.top {
	position: fixed;
	bottom: 30px;
	right: 30px;
	background: #A593E0;
	border-radius: 5px;
	height: 30px;
	width: 100px;
}

.postClick, .friendClick {
	cursor: pointer;
	display: inline-block;
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
	border-radius: 50%;
	margin-top: 25px; /* 여기 수정함 */
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

.delBtn, .updateBtn {
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
}

.postContentsDiv {
	height: 100px;
}

#postContents{
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

.xBtn {
	float: right;
	display: inline-block;
	font-size: 20px;
	margin-top: 5px;
	cursor: pointer;
	color: gray;
}

</style>

<body>
	<div style="background: #FBFEFF;">
		<div class='container' style="padding: 30px 20px 0;">
			<!-- 사용자 해더 -->
			<div class='profile'>
				<div class='myPageProfImgSpace'>
					<img class='myPageProfImg'
						src="../attach/${user.profileImg}"></img>
				</div>
				<div class='myPageInfo'>

					<div class='myPageProfId'>${user.userId}</div>
					<div class='myPageProfFriend'>
						<div class="postClick">
							<p class="myPageTitle">게시물</p>
							<p class="myPageCnt">${postCnt}</p>
						</div>
						<div class="friendClick">
							<p class="myPageTitle">FAN</p>
							<p class="myPageCnt">${cntFan}</p>
							<p class="myPageTitle">STAR</p>
							<p class="myPageCnt">${cntStar}</p>
						</div>
					</div>
					<div class='myPageProfName'>
						<h4>${user.userName}</h4>
					</div> 
					<div class='profBtn'>
						<button class='profEdit'>프로필 편집</button>
						<button class='postAddBtn'>게시물 등록</button>
					</div>
				</div>
			</div>
			<hr>

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
										<button value="${post.postNum}" class="delBtn btn">삭제</button>
										<button value="${post.postNum}" class="postEditBtn updateBtn btn">수정</button>
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
									<img class="profileImg" src="../attach/${user.profileImg}"></img>
									<div class="ownerProfileName">${user.userId}</div>
								</div>
								<div class="postCommentFrame scroll">
									<div class="postCommentDiv">
										<c:forEach var="comment" items="${comments}">
										<c:if test="${comment.postNum eq post.postNum}">
										<div class="postCommentOwner">${comment.userId}</div>
										<a class="xBtn" value="${comment.commentNum}">&times;</a>
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

		<div class="top"
			style="display: flex; justify-content: center; align-items: center;">
			<a href="#" style="color: white;"><span
				class="glyphicon glyphicon-arrow-up"> TOP</span></a>
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
	
	<!-- 게시물 등록 모달 -->
	<form>
		<div class="modal fade modal-center" id="postReg" role="dialog">
			<div class="modal-dialog modal-postsize modal-center">
				<div class="modal-content modal-postsize">
					<div class="modal-header" style="text-align: center;">
						<h4 class="modal-title">
							게시물 등록
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</h4>
					</div>
					<div class="modal-body">
						<div class="profDiv">
							<img class="profImg" src="../attach/${user.profileImg}"></img>
							<div class="profNameDiv">
								<div class="profName">${user.userName}</div>
								<input type="file" id='input_img' name='attachFile' />
							</div>
						</div>
						<div class="postRegImg">
							<img id='img' />
						</div>
						<hr>
						<div class="postContentsDiv">
							<textarea id="postContent" name="postContent"
								style="resize: none;" placeholder="어떤 말이 하고 싶은가요?"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn postRegBtn">게시</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>



<%@ include file="footer.jsp"%>