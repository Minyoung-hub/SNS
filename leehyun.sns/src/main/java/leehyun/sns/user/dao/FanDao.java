package leehyun.sns.user.dao;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.user.domain.Fan;

public interface FanDao {
	List<Integer> getFans(int toUserFan);
	
	List<Integer> getStars(int fromUserFan);

	boolean addStar(Fan fan);
	
	boolean delStar(int fanNum);
	
	Integer getFanNum(HashMap<String, Object> map);
}
