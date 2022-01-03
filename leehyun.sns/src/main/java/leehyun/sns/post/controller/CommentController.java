package leehyun.sns.post.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import leehyun.sns.post.domain.Comment;
import leehyun.sns.post.domain.CommentUser;
import leehyun.sns.post.service.CommentService;
import leehyun.sns.user.service.UserService;

@Controller
@RequestMapping
public class CommentController {
	@Autowired
	CommentService commentService;
	UserService userService;
	
	@ResponseBody
	@RequestMapping("/common/mypage/list")
	public void listComments(Model model){
		List<Comment> comments = commentService.listComments();
		List<CommentUser> commentUsers = new ArrayList<>();
		for(Comment comment : comments) {
			CommentUser commentUser = new CommentUser();
			commentUser.setCommentContent(comment.getCommentContent());
			commentUser.setCommentTime(comment.getCommentTime());
			commentUser.setUserId((userService.findUserWithNum(comment.getUserNum()).getUserId()));
			commentUser.setPostNum(comment.getPostNum());
			commentUser.setCommentNum(comment.getCommentNum());
			commentUsers.add(commentUser);
		}
		model.addAttribute("comments", commentUsers);
	}
	
	@ResponseBody
	@RequestMapping("/common/mypage/comments")
	public void mypageComment(int postNum, int userNum, String commentContent) {
			Comment comment = new Comment();
			comment.setCommentContent(commentContent);
			comment.setPostNum(postNum);
			comment.setUserNum(userNum);
			commentService.correctComment(comment);
	}
	
	@ResponseBody
	@RequestMapping("/common/delComment")
	public void delComment(int commentNum) {
		Comment comment = new Comment();
		comment = commentService.listComment(commentNum);
		commentService.secedeComment(comment);
		
	}
}
