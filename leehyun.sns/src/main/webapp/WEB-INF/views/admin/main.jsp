<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<%@ include file="../common/include.jsp"%>
<%@ include file="../admin/common/header.jsp"%>
<%@ include file="../admin/common/nav.jsp"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
function pagination() {
	$(".pagination").show();
	$(".searchPagination").hide();
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

function searchPagination() {
	$(".pagination").hide();
	$(".searchPagination").show();
	$(".searchPagination").empty();
    let req_num_row = 16; //한 페이지에 나타낼 데이터 수
    let pageCount = 10; // 한 페이지에 나타낼 페이지 수
    let $products = $('#products');
    let $tr = $(".user").find(":visible");   
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

    $('.searchPagination').append("<li><a href='#' class='sprev'> << </a></li>");

    for (let i = 1; i <= num_pages; i++) {
        $('.searchPagination').append("<li><a href='#' class='spageNum'>" + i + "</a></li>");
        
        $('.searchPagination li:nth-child(2)').addClass("active");
    }

    $('.searchPagination').append("<li><a href='#' class='snext'> >> </a></li>");

    $tr.each(function (i) {
        $(this).hide();
        if (i + 1 <= req_num_row) {
            $tr.eq(i).show();
        }
    });
    
    $('.spageNum').each(function (i) {
        if(i > 9)
        	$(this).hide();
    });
    
    $('.spageNum').click(function (e) {
        e.preventDefault();
        $tr.hide();
        let page = $(this).text();
        
		if((Math.floor((page-1)/10)+1) != current_page_set){
        	$('.spageNum').hide();
        	current_page_set = (Math.floor((page-1)/10)+1);
        	
        	$('.spageNum').each(function (i) {
                if(current_page_set * 10 > i && (current_page_set - 1) * 10 <= i)
                	$(this).show();
            });
        }
        
        let temp = page - 1;
        let start = temp * req_num_row;
        let current_link = temp;
        $('.searchPagination li').removeClass("active");
        $(this).parent().addClass("active");
        $(this).addClass("active");
        for (let i = 0; i < req_num_row; i++) {
            $tr.eq(start + i).show();
        }
    });
    
    $('.sprev').click( () => {
    	let pageNum = $('.searchPagination li.active').prev().text();
    	if(Number(pageNum))
    		$('.searchPagination li.active').prev().children().eq(0).click();
    });
    
    $('.snext').click( () => {
    	let pageNum = $('.searchPagination li.active').next().text();
    	if(Number(pageNum))
    		$('.searchPagination li.active').next().children().eq(0).click();
    });
}

function search() {
	let searchIn = $(".searchIn").val();
	let userCnt = 0;
	$(".user").show();
	$(".user").hide();
	
	if($("input").val()){
		$(".user").children().each((i, e) => {
			if($(e).attr("id").match(searchIn)){
				$(e).parent().show();
				userCnt += 1;
			}	
		});
	}
	
	if(userCnt == 0){
		swal({
			text: "일치하는 회원정보가 없습니다.",
            button: false,
            className: "swalText"
            });
		setTimeout("location.reload()", 1000);
	}
	
	$(".searchIn").val('');
}

$(()=>{
	$(".logout").click(()=>{			
		location.href='user/logout';
	});
		
	$(function(){
		$.ajax({
			url: "user/listUsers",
			success: (users) => {
				$('#userLists').empty();
	
				if(users.length > 0){
					let userList = [];
					for(let i = 0; i < users.length; i++){
						if(users[i].userId != "admin"){
						   userList.push(
						      "<tr class='user'><td id=''>"+ users[i].userNum + 
						      "</td><td class='userName' id=" + users[i].userName + ">" + users[i].userName +
						      "</td><td id=" + users[i].userId + ">" + users[i].userId + 
						      "</td><td id=''>" + users[i].regDate + "</td></tr>"
							);
						}
					}
					$('#userLists').append(userList.join(''));
					
					$('.user').click((e) => {
					     let userNum = $(e.currentTarget).children().eq(0).text();
					     location.href= 'admin/user/adminUser?userNum=' + userNum;
					});
					
					$(function() {
					    pagination();
					});
				}else{
					$('#userLists').append('<tr><td colspan="4"><b> 사용자가 없습니다. </b></td></tr>');					
				}
			}
		});
	});
	
	$(".searchBtn").click(() => {
		search();
		searchPagination();
	});
	
	$('.searchIn').keypress(function(event){
		var keycode = (event.keyCode ? event.keyCode : event.which);
		if(keycode == '13'){
			$(".searchBtn").click();
		}
		event.stopPropagation();
	});
});
</script>
<style>
.swal-footer {
	text-align: center;
}

.grayBtn {
	background: lightgray;
	margin-left: 50px;
}

.swalText .swal-text{
   font-weight: bold;
   font-size: 20px;
}

.head {
	margin: 5px;
}

.logoImg {
	width: 100px;
	height: 50px;
	margin: 10px;
}

.admin {
	font-size: 24px;
}

.menu {
	margin: 10px;
	margin-bottom: 0px;
}

.menuBtn {
	width: 100px;
	height: 45px;
	margin-right: 10px;
}

.logout {
	background: white;
	height: 40px;
	width: 60px;
	float: right;
	margin: 25px;
}

hr {
	border: 1px solid black;
	margin: 5px;
}

.body {
	margin-top: 15px;
	height: 650px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.searchIn {
	width: 350px;
	height: 40px;
	margin-top: 50px;
	vertical-align: middle;
	border: 1px solid #A593E0;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px
}

.searchBtn {
	background: black;
	color: white;
	height: 40px;
	margin-top: 50px;
	vertical-align: middle;
	background: #A593E0;
	border-bottom-left-radius: 0px !important;
	border-top-left-radius: 0px !important;
}

.list {
	width: 80%;
	height: 200px;
	margin-top: 70px;
	margin-bottom: 50px;
	display: flex;
	flex-direction: column;
	text-align: center;
	align-items: center;
}

.userList {
	width: 600px;
}

.userList, tr, td {
	font-size: 16px;
}

thead {
	font-weight: bold;
	color: white;
	background: #A593E0;
}

tbody {
	cursor: pointer;
}

a {
	font-size: 15px;
	color: #A593E0 !important;
}

.active>a {
	background: #A593E0 !important;
	color: white !important;
	border-color: #A593E0 !important;
}

/* .pagination > .active > a, 
.pagination > .active > span, 
.pagination > .active > a:hover, 
.pagination > .active > span:hover, 
.pagination > .active > a:focus, 
.pagination > .active > span:focus {
  background: red;
  border-color: red;
} */
</style>
<title>Admin Main</title>
</head>
<body>
	<header></header>
	<nav></nav>
	<div class='container'>
		<div class='body'>
			<div class='search'>
				<input type="text" class="searchIn" />
				<button class="btn searchBtn">검색</button>
			</div>
			<div class='list'>
				<table class='userList table table-hover' id="products">
					<thead>
						<tr>
							<td>회원번호</td>
							<td>회원이름</td>
							<td>회원ID</td>
							<td>회원생성날짜</td>
						</tr>
					</thead>
					<tbody id="userLists">
					</tbody>
				</table>
			</div>
			<ul class="pagination searchPagination"></ul>			
			<ul class="pagination"></ul>
		</div>
	</div>
</body>
<%@ include file="../common/footer.jsp"%>