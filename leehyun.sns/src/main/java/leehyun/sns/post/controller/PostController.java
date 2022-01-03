package leehyun.sns.post.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import leehyun.sns.post.domain.Comment;
import leehyun.sns.post.domain.CommentUser;
import leehyun.sns.post.domain.Post;
import leehyun.sns.post.service.CommentService;
import leehyun.sns.post.service.PostService;
import leehyun.sns.user.domain.User;
import leehyun.sns.user.service.FanService;
import leehyun.sns.user.service.UserService;

@Controller
@RequestMapping
public class PostController {
	@Autowired
	PostService postService;
	@Value("${attachDir}")
	private String attachDir;
	@Autowired private FanService fanService;
	@Autowired private CommentService commentService;
	@Autowired private UserService userService;
	
	@RequestMapping("/common/mypage")
	public String myPage(Model model, HttpSession session){
		User user = (User) session.getAttribute("user");
		List<Post> posts = postService.listPosts(user.getUserNum()); 
		model.addAttribute("postList", posts);
		
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
		session.setAttribute("postCnt", posts.size());
		
		return "/common/mypage";
	}
	
	@ResponseBody
	@RequestMapping(value = "/common/post/posting", method = RequestMethod.POST)
	public boolean posting(Post post, MultipartFile attachFile, HttpServletRequest request, HttpSession session) {
		boolean stored = true;
		int postImgNum = postService.chkLastPost();
		String postImgNumStr = Integer.toString(postImgNum);
		String dir = request.getServletContext().getRealPath(attachDir);
		String fileName = postImgNumStr + '_' + attachFile.getOriginalFilename();
		post.setPostImg(fileName);
		User user = (User) session.getAttribute("user");
		post.setUserNum(user.getUserNum());
		try {
			save(dir + "/" + fileName, attachFile);
		} catch (IOException e) {
			stored = false;
		}

		return postService.posting(post);
	}

	private void save(String saveFile, MultipartFile attachFile) throws IOException {
		attachFile.transferTo(new File(saveFile));
	}

	@ResponseBody
	@RequestMapping("/common/post/findPost")
	public Post findPost(int postNum) {
		Post getPost = postService.findPost(postNum);
		return getPost;
	}

	@ResponseBody
	@RequestMapping("/common/post/updatePost")
	public boolean correctPost(Post post) {
		return postService.correctPost(post);
	}
	
	@ResponseBody
	@RequestMapping("/common/post/secedePost")
	public boolean secedePost(int postNum) {
		postService.secedeComments(postNum);
		return postService.secedePost(postNum);
	}
}
