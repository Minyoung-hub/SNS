package leehyun.sns;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import leehyun.sns.post.domain.Comment;
import leehyun.sns.post.domain.CommentUser;
import leehyun.sns.post.service.CommentService;
import leehyun.sns.post.service.PostService;
import leehyun.sns.user.domain.User;
import leehyun.sns.user.service.FanService;
import leehyun.sns.user.service.UserService;

@Controller
@RequestMapping("/")
public class MainController {
	@Autowired private PostService postService;
	@Autowired private CommentService commentService;
	@Autowired private UserService userService;
	@Autowired private FanService fanService;
	
	
	@RequestMapping
	public String main(Model model, HttpSession session){
		User user = (User) session.getAttribute("user");
		if(user == null) {
			return "redirect:/user/login";
		}
		model.addAttribute("postList", postService.mainPosts(user.getUserNum()));
		
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
		int myNum = (int)session.getAttribute("userNum");
		List<Integer> fans = fanService.listFans(myNum);
		List<Integer> stars = fanService.listStars(myNum);
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan", cntFan);
		session.setAttribute("cntStar", cntStar);
		return "/main";
	}
	
	@RequestMapping("/admin")
	public String adminMain() {
		return "/admin/main";
	}
}