<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<%@ include file="../../common/include.jsp"%>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/nav.jsp"%>
<script>
function pagination() {
    let req_num_row = 4; //한 페이지에 나타낼 데이터 수
    let pageCount = 10; // 한 페이지에 나타낼 페이지 수
    let $products = $('#products');
    let $tr =  $($products).find('tbody tr'); 
    let total_num_row = $tr.length;// 총 데이터 수
    let num_pages = 1;
    let current_page_set = 1;
    
    if (total_num_row % req_num_row == 0) {
        num_pages = total_num_row / req_num_row;
    }
    
    if (total_num_row % req_num_row >= 1) {
        num_pages = total_num_row / req_num_row;
        num_pages++;
    }

    $('.pagination').append("<li><a href='#' class='prev'> << </a></li>");

    for (let i = 1; i <= num_pages; i++) {
        $('.pagination').append("<li><a href='#' class='pageNum'>" + i + "</a></li>");
        
        $('.pagination li:nth-child(2)').addClass("active");
    }

    $('.pagination').append("<li><a href='#' class='next'> >> </a></li>");

    $tr.each(function (i) {
        $(this).hide();
        if (i + 1 <= req_num_row) {
            $tr.eq(i).show();
        }
    });
        
    $('.pageNum').each(function (i) {
        if(i > 9)
        	$(this).hide();
    });
    
    $('.pageNum').click(function (e) {
        e.preventDefault();
        $tr.hide();
        let page = $(this).text();
        
		if((Math.floor((page-1)/10)+1) != current_page_set){
        	$('.pageNum').hide();
        	current_page_set = (Math.floor((page-1)/10)+1);
        	
        	$('.pageNum').each(function (i) {
                if(current_page_set * 10 > i && (current_page_set - 1) * 10 <= i)
                	$(this).show();
            });
        }
        
        let temp = page - 1;
        let start = temp * req_num_row;
        let current_link = temp;
        $('.pagination li').removeClass("active");
        $(this).parent().addClass("active");
        $(this).addClass("active");
        for (let i = 0; i < req_num_row; i++) {
            $tr.eq(start + i).show();
        }
    });
    
    $('.prev').click( () => {
    	let pageNum = $('.pagination li.active').prev().text();
    	if(Number(pageNum))
    		$('.pagination li.active').prev().children().eq(0).click();
    });
    
    $('.next').click( () => {
    	let pageNum = $('.pagination li.active').next().text();
    	if(Number(pageNum))
    		$('.pagination li.active').next().children().eq(0).click();
    });
}

$(() => {
	$(function(){
		$.ajax({
			url: "../post/listComplaints",
			success: (complaints) => {
				$("#complaintLists").empty();
				
				if(complaints.length > 0){
					let complaintList = [];
					$.each(complaints, (idx, complaint) => {
						complaintList.push(
							`<tr class='listTr'>
								<td>` + complaint.postNum + `</td>
								<td>` + complaint.complaintType + `</td>
								<td>` + complaint.complaintCnt + `</td>
								<td>` + complaint.postComplaintDate + `</td>
							</tr>`
						);
					});
					$('#complaintLists').append(complaintList.join(''));
					
					
					$(".listTr").click((e) => {
						let postNum = $(e.currentTarget).children().eq(0).text();
						
						location.href= "adminComplaintPost?postNum=" + postNum;
					});
					
					$(function() {
					    pagination();
					});					
				}else {
					$("#complaintLists").append('<tr><td colspan="4"><b>신고게시물이 없습니다.</b></td></tr>');
				}

			}
		});
	});
})
</script>
<style>
hr{
	border: 1px solid black;
	margin: 5px;
}

.body{
	margin-top: 15px;
	display: flex;
	flex-direction: column;
	align-items: center; 
	height: 650px;
}

.searchIn{
	width: 350px;
	height: 40px;
	vertical-align: middle;
	border: 1px solid #BDC6F4;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px
}

.searchBtn{
	background: black;
	color: white;
	height: 40px;
	vertical-align: middle;
	background: #BDC6F4;
	border-bottom-left-radius: 0px !important;
	border-top-left-radius: 0px !important;
}

.post{
	width: 80%;
	height: 200px;
	margin-top: 100px;
	margin-bottom: 80px;
	display: flex;
 	flex-direction: column;
	text-align: center;
	align-items: center;
}

.userPost{
	width: 600px;
}

.userList, tr, td{
	font-size: 16px;
}

thead{
	font-weight: bold;
	color: white;
	background: #A593E0;
}

tbody{
	cursor: pointer;
}

a {
	font-size: 15px;
	color: #A593E0 !important;
}

.active>a{
	background: #A593E0 !important;
	color: white !important;
	border-color: #A593E0 !important;
}

</style>
<title>Admin complaintPost</title>
</head>
<body>
	<header></header>
	<nav></nav>
	<div class='container'>
	<div class='body'>
		<div class='post'>
			<table class='userPost table table-hover' id="products">
				<thead>
					<tr>
						<td>게시물 번호</td>
						<td>신고 카테고리(多)</td>
						<td>신고 횟수</td>
						<td>신고 날짜</td>
					</tr>
				</thead>
				<tbody id="complaintLists">
				</tbody>
			</table>
		</div>
		<ul class='pagination'></ul>
	</div>
</div>
</body>
<%@ include file="../../common/footer.jsp"%>