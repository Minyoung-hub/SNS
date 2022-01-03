package leehyun.sns.post.dao;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.post.domain.Like;

public interface LikeDao {
	int addLike(Like like);
	   
	Integer delLike(HashMap<String, Object> map);
	
	Integer changeLike(HashMap<String, Object> map);
	
	List<Like> getLikes(int userNum);
	
	Like getLike(HashMap<String, Object> map);
}
