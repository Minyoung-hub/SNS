package leehyun.sns.post.dao.map;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.post.domain.Like;

public interface LikeMap {	
	int addLike(Like like);
		   
	Integer delLike(HashMap<String, Object> map);
		   
	List<Integer> likeCnt(HashMap<String, Object> map);
	
	Integer changeLike(HashMap<String, Object> map);
	
	List<Like> getLikes(int userNum);
	
	Like getLike(HashMap<String, Object> map);
}
