<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(() => {
	let arr = [];
	let obj;
	
	<c:forEach var="item" items="${messages}">
	    obj = { 
	    		msgNum: '${item.msgNum}',
	    		chatNum: '${item.chatNum}',
	    		msgContent: '${item.msgContent}',
	    		msgTime: '${item.msgTime}',
	    		sender: '${item.sender}',
	    		msgCheck: '${item.msgCheck}'};
	    arr.push(obj);                                  
	</c:forEach>
	
	for(let i = 0; i < arr.length; i++){
		if(arr[i].sender == ${myUserNum}){
			$(".msgContent").append(
				`<div class="right">
					<div class="msg send" value="\${arr[i].msgNum}">\${arr[i].msgContent}</div>
				</div>`
			);
		}else{
			$(".msgContent").append(
				`<div>
					<div class="msg receive" value="\${arr[i].msgNum}">\${arr[i].msgContent}</div>
				</div>`
			);
		}
	}
	
	$(".msgContent").scrollTop($(".msgContent")[0].scrollHeight);
	
	$('.msgInBlock').keypress(function(event){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == '13'){
			$(".msgBtn").click();
		} 
		event.stopPropagation();
	});
	
	let req = setInterval(() => addMsg(), 500);
	
	$('.msgBtn').click( () => {
		if($('.msgInBlock').val()){
			$.ajax({
				url: 'send',
				data: { "msg": $('.msgInBlock').val(), "chatNum": ${chatNum}},
				success: msg => {
					if(msg){
						clearInterval(req);
						setTimeout(() => addMsg(), 0);
						req = setInterval(() => addMsg(), 500);					
						$('.msgInBlock').val("");
					}else{
						swal({
							title: "메세지 보내기 실패 문제발생",
							icon: "warning",
						})					
					}
				},
				error : (a, b, err) => swal({
					title: "메세지 보내기 ERROR 문제발생",
					icon: "warning",
				})
			});
		}else{
			swal({
				title: "메세지를 입력해주세요",
				icon: "info",
			})
		}
	});
	
	
	$(".deleteBtn").click(()=> swal({
		title: '삭제 하시겠습니까?',
		text: '메시지가 삭제됩니다.',
		icon:'info',
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
		if(result)
		$.ajax({
			url: 'deleteMsg',
			data: {"chatNum": ${chatNum}},
			success: cnt => {
				swal({
					title: "메세지가 삭제되었습니다.",
					text: " ",
					buttons: false,
					timer: 1000
				});
				setTimeout(() => location.href="../message", 1000);
			},
			error : (a, b, err) => swal({
				title: "메세지 삭제 ERROR 문제발생",
				icon: "warning",
			})
		});
	}));
   
	$('.backBtn').click( () => {
		location.href="../message";
	});
   
	function addMsg() {
		let lastMsgNum = $('.msg').eq($('.msg').length-1).attr("value");
		if(!lastMsgNum)
			lastMsgNum = 0;
		$.ajax({
			url: 'addMsg',
			data: { "msgNum": lastMsgNum, "chatNum": ${chatNum}},
			success: arr => {
				if(arr){
					if(arr.length != 0)
						$('.noList').remove();
					
					for(let i = 0; i < arr.length; i++){
						if(arr[i].msgNum != $('.msg').eq($('.msg').length).attr("value"))
							if(arr[i].sender == ${myUserNum}){
								$(".msgContent").append(
									`<div class="right">
										<div class="msg send" value="\${arr[i].msgNum}">\${arr[i].msgContent}</div>
									</div>`
								);
							}else{
								$(".msgContent").append(
									`<div>
										<div class="msg receive" value="\${arr[i].msgNum}">\${arr[i].msgContent}</div>
									</div>`
								);
							}
					}
				}else{
					swal({
						title: "추가 메세지 가져오기 실패 문제발생",
						icon: "warning",
					})					
				}
				if(arr.length>0)
					$('.msgContent').scrollTop($('.msgContent')[0].scrollHeight);
			},
			error : (a, b, err) => swal({
				title: "추가 메세지 가져오기 ERROR 문제발생",
				icon: "warning",
			})
		});
		$.ajax({
			url: 'readChk',
			data: {"chatNum": ${chatNum}},
			success: cnt => {
			},
			error : (a, b, err) => swal({
				title: "읽음 ERROR 문제발생",
				icon: "warning",
			})
		});
		
		if(!($(".msgContent").children().length))
			$('.msgContent').append(
					`<div class="noList" style="text-align: center; font-size: 30px; padding-top: 120px;">대화 내용이 없습니다.</div>`
			);
	}
});
</script>
<style>
.main {
   height: 800px;
}

.msgBox {
   display: flex;
   flex-direction: column;
   width: 900px;
   height: 770px;
   border: 2px solid #A593E0;
   margin-left: 120px;
   margin-top: 35px;
   background: white;
}

.msgHeader {
   height: 120px;
   display: flex;
   border-bottom: 2px solid #A593E0;
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

.profileImg {
   background: white;
   width: 80px;
   height: 80px;
   margin-top: 20px;
   margin-right: 20px;
   border: 1px solid;
   border-radius: 50%;
}

.msgOwner {
   font-size: 30px;
   font-weight: bold;
   margin-top: 35px;
   margin-left: 10px;
}

.msgDelete {
   margin-top: 35px;
   margin-left: 560px;
}

.deleteBtn {
   background: white;
   color: gray;
}

.backBtn {
   background: white;
   color: gray;
}

.msgContent {
   height: 595px;
   border-bottom: 2px solid #A593E0;
}

.right {
   text-align: right;
}

.msg {
   border-radius: 20px;
   margin: 15px;
   font-size: 20px;
   text-align: left;
   margin-top: 10px;
   display: inline-block;
   padding: 10px;
   max-width: 600px;
}

.receive {
   border: 1px solid #A593E0;
}

.send {
   background-color: #A593E0;
   color: white;
}

.msgIn {
   display: flex;
}

.msgInBlock {
   flex: 10;
   border-top: none;
   border-bottom: none;
   border-left: none;
   border-right: none;
   height: 55px;
   font-size: 20px;
}

.msgBtn {
   flex: 1;
   background: white;
   color: #A593E0;
}

.swal-footer {
	text-align: center;
}

.grayBtn {
	background: lightgray;
	margin-left: 50px;
}
</style>
</head>
<header></header>
<div style="background: #FBFEFF;">
   <div class='container'>
      <div class="main">
         <div class="msgBox">
            <div class="msgHeader">
            	<button class="btn backBtn btn-margin">
                     <span class="glyphicon glyphicon-menu-left" style="font-size: 30px;"></span>
                  </button>
               <img class="profileImg" src="<c:url value="/attach/${toUser.profileImg}"/>" />
               <div class="msgOwner">${toUser.userName}</div>
               <div class="msgDelete">
                  <button class="btn deleteBtn btn-margin">
                     <span class="glyphicon glyphicon-trash" style="font-size: 30px;"></span>
                  </button>
                  
               </div>
            </div>
            <div class="msgContent scroll">
            </div>
            <div class="msgIn">
               <input class="msgInBlock" type="text" maxlength="650"/>
               <button class="msgBtn btn">
                  <span class="glyphicon glyphicon-send" style="font-size: 30px;"></span>
               </button>
            </div>
         </div>
      </div>
   </div>
</div>
<%@ include file="../common/footer.jsp"%>