package leehyun.sns.post.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.post.dao.map.LikeMap;
import leehyun.sns.post.domain.Like;

@Repository
public class LikeDaoImpl implements LikeDao{
	@Autowired private LikeMap likeMap;
	@Override
	public int addLike(Like like) {
		return likeMap.addLike(like); 
	}
	   
	@Override
	public Integer delLike(HashMap<String, Object> map) {
		return likeMap.delLike(map);
	}	   

	
	@Override
	public Integer changeLike(HashMap<String, Object> map) {
		return likeMap.changeLike(map);
	}
	
	@Override
	public List<Like> getLikes(int userNum){
		return likeMap.getLikes(userNum);
	}
	
	@Override
	public Like getLike(HashMap<String, Object> map){
		return likeMap.getLike(map);
	}
	
	
}
