package leehyun.sns.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import leehyun.sns.post.domain.DelPost;
import leehyun.sns.post.service.DelPostService;

@Controller
@RequestMapping
public class DelPostController {
	@Autowired private DelPostService delPostService;
	
	@ResponseBody
	@RequestMapping("/admin/post/putDelPost")
	public boolean putDelPost(DelPost delPost) {
		return delPostService.putDelPost(delPost);
	}
	
	@ResponseBody
	@RequestMapping("/post/delPostCnt")
	public DelPost getDelPostCnt(int userNum) {
		DelPost delPost = delPostService.getDelPostCnt(userNum);
		return delPost;
	}
	
	@ResponseBody
	@RequestMapping("/post/latestDelPost")
	public DelPost latestDelPost(int userNum) {
		DelPost delPost = delPostService.latestDelPost(userNum);
		return delPost;
	}
}
