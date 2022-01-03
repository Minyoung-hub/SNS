package leehyun.sns.post.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.post.dao.LikeDao;
import leehyun.sns.post.domain.Like;

@Service
public class LikeServiceImpl implements LikeService {
	@Autowired
	private LikeDao likeDao;

	@Override
	public int plusLike(Like like) {
		return likeDao.addLike(like);
	}

	@Override
	public int minusLike(int postNum, int userNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("postNum", postNum);
		map.put("userNum", userNum);
		return likeDao.delLike(map);
	}
	
	@Override
	public int modifyLike(int postNum, int userNum, String likeType) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("postNum", postNum);
		map.put("userNum", userNum);
		map.put("likeType", likeType);
		return likeDao.changeLike(map);
	}
	
	@Override
	public List<Like> listLikes(int userNum){
		return likeDao.getLikes(userNum);
	}
	
	@Override
	public Like findLike(int postNum, int userNum){
		HashMap<String, Object> map = new HashMap<>();
		map.put("postNum", postNum);
		map.put("userNum", userNum);
		return likeDao.getLike(map);
	}
}