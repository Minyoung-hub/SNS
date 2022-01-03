package leehyun.sns.user.controller;
 
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import leehyun.sns.post.domain.Comment;
import leehyun.sns.post.domain.CommentUser;
import leehyun.sns.post.domain.Post;
import leehyun.sns.post.service.CommentService;
import leehyun.sns.post.service.PostService;
import leehyun.sns.user.domain.Fan;
import leehyun.sns.user.domain.User;
import leehyun.sns.user.service.FanService;
import leehyun.sns.user.service.UserService;

@Controller 
@RequestMapping("/user")
	public class FanController {
	@Autowired private FanService fanService;
	@Autowired private UserService userService;
	@Autowired private PostService postService;	
	@Autowired private CommentService commentService;
	
	@RequestMapping("/fanPage")
	public String fanPage(Model model, HttpSession session) {
		User user = (User)session.getAttribute("fanuser");
		List<Post> posts = postService.listPosts(user.getUserNum());
		model.addAttribute("postList", posts);
		List<Integer> fans = fanService.listFans(user.getUserNum());
		List<Integer> stars = fanService.listStars(user.getUserNum());
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan1", cntFan);
		session.setAttribute("cntStar1", cntStar);
		session.setAttribute("postCnt", posts.size());
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
		return "/user/fanPage";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="/fanPage", method=RequestMethod.POST)
	public int fanPageProf(HttpSession session, String profId) {
		int isMe = 0;
		int myUserNum = (int)session.getAttribute("userNum");
		User user = userService.findUserWithId(profId);
		List<Integer> fans = fanService.listFans(user.getUserNum());
		List<Integer> stars = fanService.listStars(user.getUserNum());
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan1", cntFan);
		session.setAttribute("cntStar1", cntStar);
		if(myUserNum == user.getUserNum())
			isMe = 1; 
		session.setAttribute("fanuser", user);
		return isMe;
	}
	
	@RequestMapping(value="/fanPageId", method=RequestMethod.POST)
	public String fanPageName(HttpSession session, String userId) {
		User user = userService.findUserWithId(userId);
		List<Integer> fans = fanService.listFans(user.getUserNum());
		List<Integer> stars = fanService.listStars(user.getUserNum());
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan1", cntFan);
		session.setAttribute("cntStar1", cntStar);
		session.setAttribute("fanuser", user);
		return "/user/fanPage";
	}
	
	@RequestMapping("/fanList1")
	public String fanList1(HttpSession session) {
		User user = (User)session.getAttribute("user");
		List<Integer> fans = fanService.listFans(user.getUserNum());
		List<Integer> stars = fanService.listStars(user.getUserNum());
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan1", cntFan);
		session.setAttribute("cntStar1", cntStar);
		session.setAttribute("fanlist", user);
		return "/user/fanList";
	}
	
	@RequestMapping("/fanList2")
	public String fanList2(HttpSession session) {
		User user = (User)session.getAttribute("fanuser");
		List<Integer> fans = fanService.listFans(user.getUserNum());
		List<Integer> stars = fanService.listStars(user.getUserNum());
		int cntFan = fans.size();
		int cntStar = stars.size();
		session.setAttribute("cntFan1", cntFan);
		session.setAttribute("cntStar1", cntStar);
		session.setAttribute("fanlist", user);
		return "/user/fanList";
	}
	
	@ResponseBody
	@RequestMapping("/addFan")
	public boolean makeStar(HttpSession session, String toUserId) {
		User user = userService.findUserWithId(toUserId);
		int num = user.getUserNum();
		int myNum = (int)session.getAttribute("userNum");
		Fan fan = new Fan();
		fan.setFromUserNum(myNum);
		fan.setToUserNum(num);
		return fanService.makeStar(fan);
	}
	
	@RequestMapping("/removeFan")
	@ResponseBody
	public boolean removeStar(HttpSession session, String toUserId){
		User user = userService.findUserWithId(toUserId);
		int num = user.getUserNum();
		int myNum = (int)session.getAttribute("userNum");
		int fanNum = fanService.findFanNum(num, myNum);
		return fanService.removeStar(fanNum);
	}
	
	@RequestMapping("/chkFan")
	@ResponseBody
	public boolean chkStar(String toUserId, HttpSession session){
		boolean isCheck = false;
		User user = userService.findUserWithId(toUserId);
		int num = user.getUserNum();
		int myNum = (int)session.getAttribute("userNum");
		int fanNum = fanService.findFanNum(num, myNum);
		if(fanNum > 0){
			isCheck = true;
		}
		return isCheck;
	}
	
	@ResponseBody
	@RequestMapping("/listFans")
	public List<User> listFans(String toUserId, HttpSession session) {
		User user = userService.findUserWithId(toUserId);
		int num = user.getUserNum();
		List<Integer> fans = fanService.listFans(num);
		List<User> users = new ArrayList<>();
		for(int fan:fans) {
			User user2 = userService.findUserWithNum(fan);
			users.add(user2);
		}
		return users;
	}
	
	@ResponseBody
	@RequestMapping("/listStars")
	public List<User> listStars(HttpSession session, String toUserId) {
		User user = userService.findUserWithId(toUserId);
		int num = user.getUserNum();
		List<Integer> stars = fanService.listStars(num);
		List<User> users = new ArrayList<>();
		for(int star:stars) {
			User user2 = userService.findUserWithNum(star);
			users.add(user2);
		}
		session.setAttribute("fans", users);
		return users;
	}
}