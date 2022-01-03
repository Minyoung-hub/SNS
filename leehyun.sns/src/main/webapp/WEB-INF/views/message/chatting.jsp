<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<link href="https://fonts.googleapis.com/css2?family=Sriracha&display=swap" rel="stylesheet">
<script>
$( () => { 
	let obj;
	let str = "";
	
	reload();
	setInterval(() => reload(), 500);
	
	function reload() {
		$.ajax({
			url: 'message/reload',
			success: arr => {
				if(arr){
					if(arr.length != 0)
						$('.msgFrame').empty();
					
					for(let i = 0; i < arr.length; i++){
						if(arr[i].lastMsg.length > 30){
							arr[i].lastMsg = arr[i].lastMsg.substring(0, 30);
							arr[i].lastMsg += "..."; 
						}
						
						str = `
							<div class="msgListDiv">
							<div style="display: none;">`+arr[i].chatNum+`</div>
							<img class="profileImg" src="attach/`+arr[i].toUserImg+`" /><br>
							<div style="width: 700px;">
								<div class="msgOwner">`+arr[i].toUserName+`</div>`
						if(arr[i].msgCnt != 0)		
							str +=	`<div class="msgCnt">`+arr[i].msgCnt+`</div>`
						else
							str +=	`<div class="msgCnt" style="background: none; color: none;">`+arr[i].msgCnt+`</div>`
						str +=	`<div class="msgContent">`+arr[i].lastMsg+`</div>
							</div>
						</div>
						<hr style="margin: 10px;">`
						if(arr[i].lastMsg)
							$(".msgFrame").append(str);
					}
					$(".msgListDiv").click( (e) => {
						let addr = $(e.currentTarget).children().eq(0).text();
						location.href = "message/" + addr;
					});
				}else{
					swal({
						title: "채팅방  가져오기 실패 문제발생",
						type: "warning",
					})					
				}
			},
			error : (a, b, err) => swal({
				title: "채팅방 가져오기 ERROR 문제발생",
				type: "warning",
			})
		});
		
		if(!($(".msgFrame").children().length))
			$('.msgFrame').append(
				`<div class="noList" style="text-align: center; font-size: 30px; padding-top: 120px;">대화 목록이 없습니다.</div>`
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
	height: 105px;
}

.msgHeaderFont {
	margin-top: 20px;
	font-size: 35px;
	font-family: 'Sriracha', cursive;
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

.msgFrame {
	height: 740px;
	margin-left: 7px;
}

.msgListDiv {
	height: 100px;
	display: flex;
	cursor: pointer;
}

.profileImg {
	background: white;
	width: 80px;
	height: 80px;
	margin-top: 10px;
	margin-left: 30px;
	margin-right: 20px;
	border: 1px solid;
	border-radius: 50%;
}

.msgOwner {
	font-size: 25px;
	margin-top: 10px;
	font-weight: bold;
	height: 39px;
	display: inline-block;
}

.msgContent {
	font-size: 15px;
	margin-top: 15px;
	margin-bottom: 10px;
	margin-light: 20px;
	font-weight: bold;
}
.msgCntDiv{
	display: inline-block;
}


.msgCnt{
	display: inline-block;
	position: relative;
	float: right;
	background: red;
	width: 40px;
	height: 40px;
	margin-left: 20px;
	top: 30px;
	border-radius: 50%;
	color: white;
	text-align: center;
	padding-top: 8px;
	font-size: 18px;
	font-weight: bold;
}
</style>
<div style="background: #FBFEFF;">
	<div class='container'>
		<div class="main">
			<div class="msgBox">
				<div class="msgHeader">
					<div class="msgHeaderFont">
						&nbsp;&nbsp;Message&nbsp;<span class="glyphicon glyphicon-send"></span>
					</div>
				</div>
				<div class="msgFrame scroll"></div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp"%>