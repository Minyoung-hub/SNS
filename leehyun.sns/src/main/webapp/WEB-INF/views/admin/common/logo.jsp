<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/nav.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(()=>{
   var sel_file;
   
	function handleImgFileSelect(e){
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
      
		filesArr.forEach((f)=>{
			if(!f.type.match("image.*")){
				swal("파일 이상", "확장자는 이미지 확장자만 가능합니다.");
	            $('#input_img').val("");
				return;
			}
	         
			sel_file = f;
	         
			var reader = new FileReader();
			reader.onload = function(e){
				$(".img_wrap").attr("src", e.target.result);
			}
			reader.readAsDataURL(f);
		})
	}
   
   
	$('.toMain').click( () => {
		location.href="../../admin";
	});
   
	$("#input_img").on("change", handleImgFileSelect);
   
	$('#updateLogo').click( () => {
		swal({
			title: '로고를 수정 하시겠습니까?',
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
				if($('#input_img').val()){
					let data = new FormData($('form')[0]);
					$.ajax({
						method: "post",
						data,
						processData: false,
						contentType: false,
						success: result => {
							if(result) 
								swal("수정 완료!", "로고 이미지가 변경되었습니다.").then( () => {location.reload()});
							else 
								swal("수정 실패1", "로고 이미지 변경 실패.");
						},
						error: (a, b, err) => {
							swal("수정 실패2", "로고 이미지 변경 실패.");
						},
					});
				}else{
					swal("첨부된 이미지 없음", "이미지를 첨부해 주세요");
				}
		});
	});
})
</script>
<style>
.swal-footer {
	text-align: center;
}

.grayBtn {
	background: lightgray;
	margin-left: 50px;
}

.headLine {
	border: 1px solid black;
	margin: 5px;
}

.body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	text-align: center;
	align-items: center;
	height: 500px;
}

.img_wrap {
	width: 620px;
	height: 300px;
	margin-top: 50px;
	border: 1px solid black;
}

#input_img {
	margin-top: 30px;
}

.submitBtn {
	float: right;
	margin: 50px;
}

.submitBtn button {
	background: #A593E0;
	color: white;
	width: 100px;
	height: 45px;
	margin-left: 15px;
}
</style>
<title>Admin Logo</title>
</head>
<body>
	<div class='container'>
		<div class='body'>
			<div>
				<form>
					<input class='fileBtn' type="file" id='input_img' name="attachFile"/>
				</form>
			</div>
			<div>
				<img class='img_wrap'></img>
			</div>
		</div>
		<div>
			<div class='submitBtn'>
				<button class='btn toMain' type='button'>메인으로</button>
				<button class='btn updateLogo' id='updateLogo' type='button'>수정완료</button>
			</div>
		</div>
	</div>
</body>
</html>
<%@ include file="../../common/footer.jsp"%>