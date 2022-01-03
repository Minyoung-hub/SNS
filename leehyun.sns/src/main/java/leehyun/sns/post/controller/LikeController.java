package leehyun.sns.post.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import leehyun.sns.post.domain.Like;
import leehyun.sns.post.service.LikeService;

@Controller
@RequestMapping
public class LikeController {
	@Autowired
	LikeService likeService;
	
	@ResponseBody
	@RequestMapping("/plusLike")
	public int plusLike(HttpSession session, int postNum, String likeType) {
		int result = 0;
		int myNum = (int) session.getAttribute("userNum");
		Like like = new Like();
		like.setPostNum(postNum);
		like.setUserNum(myNum);
		like.setLikeType(likeType);
		Like like2 = likeService.findLike(postNum, myNum);
		if(like2 == null) {
			result = likeService.plusLike(like);
		}else {
			if(like2.getLikeType().equals(likeType))
				result = likeService.minusLike(postNum, myNum);
			else
				result = likeService.modifyLike(postNum, myNum, likeType);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/like")
	public List<Like> listLikes(HttpSession session) {
		int myNum = (int) session.getAttribute("userNum");
		return likeService.listLikes(myNum);
	}
}