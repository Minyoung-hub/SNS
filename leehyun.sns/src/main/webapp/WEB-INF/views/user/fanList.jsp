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
	let str;
	
	$("#keyword").keyup(function(){
		let k = $(this).val();
		$(".friend").hide();
		let temp = $("#list > div > div:nth-child(3n+2) > div:nth-child(3n+3):contains('"+ k + "')");
		$(temp).parent().parent().show();
	})
	
	if("${fanlist.userId}" == "${user.userId}"){
		$('.profBtn').empty();
		$('.profBtn').append("<button class='profEdit'>프로필 편집</button>"
			+"<button class='postAddBtn'>게시물 등록</button>");
	}else{
		$('.profBtn').empty();
		$('.profBtn').append("<button class='messageSend' name=${fanuser.userNum}>메세지</button>"
       			+"<button class='fanInBtn'>FAN 맺기</button>"
       			+"<button class='fanOutBtn2'>FAN 끊기</button>");
	}
	
	/* 게시물 등록 모달 시작 */
	$('.postAddBtn').click( () => {
		$('#postContent').val("");
		$('#input_img').val("");
		$("#img").removeAttr("src");
		
		$('#postReg').modal("show");
	});
	
	
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
        	   let data = new FormData($('form')[0]);
        	   
        	   if(data.get('attachFile') && data.get('postContent') && $('#input_img').val()){
        		   $.ajax({
            		   url: '../common/post/posting',
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
                    	   setTimeout( () => location.href="../common/mypage", 1000);
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
	
	$.ajax({
    	url: 'chkFan',
    	data: {"toUserId": $("#myPageProfId").text()},
    	success: chkFan => {
    		if(chkFan){
    			$('.fanOutBtn2').show(),
        		$('.fanInBtn').hide()
    		}else{
    			$('.fanOutBtn2').hide(),
        		$('.fanInBtn').show()
    		}
    	},
    	error: (a, b, err) => {
    		$('.fanOutBtn2').hide(),
    		$('.fanInBtn').show()
		}
	})
	
	
	
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
                	data: {"toUserId": $("#myPageProfId").text()},
                	success: addfan => {
                		swal({
                			title:$("#myPageProfName").text()+'님의 fan이 되었습니다.',
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
    
    $('.fanOutBtn2').click( () => {
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
                	data: {"toUserId": $("#myPageProfId").text()},
                	success: removefan => {
                		swal({
                			title:$("#myPageProfName").text()+'님과 fan을 끊었습니다.',
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

	$(".postClick").click(()=>{
		if($("#myPageProfId").text() == "${user.userId}")
			window.location="../common/mypage";
		else{
			$.ajax({
				 url: "fanPageId",
				 method: 'post',
				 data: {"userId": $("#myPageProfId").text()},
				 success: userId => {
					  location.href="fanPage";
				}
			});
		}	
	});
	
	$(".profEdit").click(()=>{ 
		location.href="../user/modifyUser";
	});
    
	listFans();
	
	$('.fan').click( () => {
		$('.fan').css("border-bottom", "2px solid #A593E0");         
        $('.star').css("border-bottom", "0px solid");    
		listFans();
	});
	
    $('.star').click( () => {
        $('.fan').css("border-bottom", "0px solid");         
        $('.star').css("border-bottom", "2px solid #A593E0");   
   		$.ajax({
   			url: "listStars",
   			data:{"toUserId": $("#myPageProfId").text()},
   			success: (users) => {
   				$('#list').empty();
   	
   				if(users.length > 0){
   					let fanList = [];
   					for(let i = 0; i < users.length; i++){
   						str =  "<div class='friend'>"
     						+"<div class='imgSpace'>"
       						+"<div><img class='friendImg' src=../attach/"
       						+ users[i].profileImg + "></img></div></div>"
							+"<div class='friendInfo'>"
							+"<div id='friendId'>"
							+ users[i].userId + "</div><br>" 
							+"<div id='friendName'>"
							+ users[i].userName + "</div></div>" 
							+ "<div class='friendBtn'>";
							
						if(${user.userNum} != users[i].userNum)
							str += "<button class='btn messageBtn' name="+users[i].userNum+">메세지</button>";
						str += "</div></div>";
   						
						fanList.push(str);
   					}
   					$('#list').append(fanList.join(''));
   					msgBtnEnable();
   				}else{
   					$('#list').append('');
   					$('#list').append("<br><hr><br><div class='noFriend'>STAR가 없습니다.</div>"
   							+"<div style='font-size: 18px; margin-top: 20px; color: #AE9BC1; text-align: center;'>당신의 <strong>STAR</strong>를 등록해보세요!</div>");
   				}
   				
   			  	$(".imgSpace").click((e)=>{
   					let userId = $(e.currentTarget).siblings().eq(0).children().eq(0).text();
   					if(userId != "${user.userId}"){
	   					$.ajax({
	   						 url: "fanPageId",
	   						 method: 'post',
	   						 data: {"userId": userId},
	   						 success: userId => {
		   						location.href="fanPage";
	   						}
	   					});
   					}else
   						window.location="../common/mypage";
   				}); 
   			  	
   			  	$(".friendInfo").click((e)=>{
   					let userId = $(e.currentTarget).children().eq(0).text();
   					if(userId != "${user.userId}"){
	   					$.ajax({
	   						 url: "fanPageId",
	   						 method: 'post',
	   						 data: {"userId": userId},
	   						 success: userId => {
		   						location.href="fanPage";
	   						}
	   					});
   					}else
   						window.location="../common/mypage";
   				}); 
   				
   				$('.fanOutBtn').click( (e) => {
   					userId = $(e.currentTarget).val();
   			    	userName = $(e.currentTarget).parent().siblings().eq(1).children().eq(2).text();
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
   			                	data: {"toUserId": userId},
   			                	success: removefan => {
   			                		swal({
   			                			title:userName+'님과 fan을 끊었습니다.',
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
   			}
   		});
     });
});
function msgBtnEnable() {
	$('.messageBtn').click( (e) => {
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
}

function listFans() {
	$.ajax({
		url: "listFans",
		data:{"toUserId": $("#myPageProfId").text()},
		success: (users) => {
			$('#list').empty();

			if(users.length > 0){
				let fanList = [];
				for(let i = 0; i < users.length; i++){
					str =  "<div class='friend'>"
 						+"<div class='imgSpace'>"
   						+"<div><img class='profileImg' src=../attach/"
   						+ users[i].profileImg + "></img></div></div>" 
						+"<div class='friendInfo'>"
						+"<div id='friendId'>"
						+ users[i].userId + "</div><br>" 
						+"<div id='friendName'>"
						+ users[i].userName + "</div></div>" 
						+ "<div class='friendBtn'>";
						
					if(${user.userNum} != users[i].userNum)
						str += "<button class='btn messageBtn' name="+users[i].userNum+">메세지</button>";
					str += "</div></div>";
					fanList.push(str);
				}
				$('#list').append(fanList.join(''));
				msgBtnEnable();
			}else{
				$('#list').append('');
				$('#list').append("<br><hr><br><div class='noFriend'>FAN이 없습니다.</div>"
						+"<div style='font-size: 18px; margin-top: 20px; color: #AE9BC1; text-align: center;'>당신의 <strong>FAN</strong>을 만들어보세요!</div>");
			}
			
			$(".imgSpace").click((e)=>{
					let userId = $(e.currentTarget).siblings().eq(0).children().eq(0).text();
					if(userId != "${user.userId}"){
	   					$.ajax({
	   						 url: "fanPageId",
	   						 method: 'post',
	   						 data: {"userId": userId},
	   						 success: userId => {
		   						location.href="fanPage";
	   						}
	   					});
					}else
   						window.location="../common/mypage";
				}); 
			  	
			  	$(".friendInfo").click((e)=>{
					let userId = $(e.currentTarget).children().eq(0).text();
					if(userId != "${user.userId}"){
	   					$.ajax({
	   						 url: "fanPageId",
	   						 method: 'post',
	   						 data: {"userId": userId},
	   						 success: userId => {
		   						location.href="fanPage";
	   						}
	   					});
					}else 
   						window.location="../common/mypage";
				}); 
		}
	});
}
</script>
<style>
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

.profDiv {
	display: flex;
	margin-left: 9px;
	margin-bottom: 20px;
}

.postRegBtn{
	background: #A593E0;
	width: 100%;
	color: white;
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

.postContentsDiv {
	height: 100px;
}

#img {
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

.postContentDiv {
	height: 200px;
	border-left: 3px solid #A593E0;
	border-right: 1px solid #A593E0;
	border-bottom: 3px solid #A593E0;
}

.profName {
	font-weight: bold;
	font-size: 18px;
	margin-bottom: 10px;
}

.postContent {
	font-size: 18px;
}

.noFriend{
	margin: 20px;
	margin-bottom: 30px;
	font-size: 28px;
	color: #876DA2;
	text-align: center;
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

#myPageProfId {
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

.fanInBtn, .fanOutBtn2, .messageSend {
   background: white;
   border-radius: 5px;
   border: 1px solid #A593E0;
   background: #A593E0;
   color: white;
   height: 30px;
   width: 100px;
   margin-right: 15px;
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

.friend{
	padding: 10px 0px 10px 0px;
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.2);
	display: inline-flex;
	border-radius: 10px;
	width: 520px;
	margin: 15px;
	margin-top: 30px;
}

.friendImg{
	border: 1px solid;
	border-radius: 50%;
	width: 85px;
	height: 85px;
	background: white;
	cursor: pointer;
}

.profileImg{
	border: 1px solid;
	border-radius: 50%;
	width: 85px;
	height: 85px;
	background: white;
	cursor: pointer;
}

.imgSpace{
	flex: 0.8;
	display: flex;
	justify-content: center;
}

.friendInfo{
	flex: 1;
}

.messageBtn, .fanOutBtn{
	background: white;
	border-radius: 5px;
	border: 1px solid #A593E0;
	background: #A593E0;
	color: white;
	margin-right: 10px;
}

#friendId{
	font-size: 23px;
	font-weight: bold;
	margin-top: 3px;
	cursor: pointer;
}

#friendName{
	font-size: 17px;
	cursor: pointer;
}

.friendBtn{
	flex: 1;
	display: flex;
	align-items: center;
}

.fan, .star{
	height: 50px;
	width: 100px;
	font-size: 20px;
	text-align: center;
	cursor: pointer;
	margin-left: 50px;
}

.fan{
	border-bottom: 2px solid #A593E0;
}

.searchBtn2{
	background:white;
	border: 1px solid white;
}

.searchIn2{
	background: #FBFEFF;
	border-bottom: 2px solid gray;
	border-top: 1px solid white;
	border-left: 1px solid white;
	border-right: 1px solid white;
	height: 30px;
	width: 400px;
	font-size: 18px;
	margin-top: 6px;
}
</style>
</head>
<header></header>
<body>
<div style="background:#FBFEFF;">
	<div class='container' style="padding: 30px 20px 0;">
		<div class='profile'>
			<div class='myPageProfImgSpace'>
				<img class='myPageProfImg' src="../attach/${fanlist.profileImg}"></img>
			</div>
			<div class='myPageInfo'>
				<div id='myPageProfId'>${fanlist.userId}</div>
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
					<h4 id='myPageProfName'>${fanlist.userName}</h4>
				</div>
				<div class='profBtn'>
				</div>
			</div>
		</div>
		<hr>
		<div class='friends' style='margin-top: 30px;'>
			<div class='fanStar' style="display: flex; border-bottom:1px solid lightgray; margin-bottom: 40px;">
				<div class='fan'>FAN</div>
				<div class='star'>STAR</div>
			</div>
			<div class='searchFriend' style="display: flex; justify-content: center;">
				<input type="text" class="searchIn2" id="keyword" placeholder="친구 검색"/>
				<button class="btn searchBtn2"><span class="glyphicon glyphicon-search" style="color: gray; font-size: 25px;"></span></button>
	        </div>
	        <div id='list' style="padding: 10px;">
				
	        </div>
        </div>
	</div>
</div>
<div class="top" style="display: flex;justify-content: center; align-items: center;">
	<a href="#" style="color: white;"><span class="glyphicon glyphicon-arrow-up"> TOP</span></a>
</div>
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
<div style="height: 180px;"></div>
</html>
<%@ include file="../common/footer.jsp"%>