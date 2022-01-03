package leehyun.sns.user.dao.map;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.user.domain.Fan;

public interface FanMap {
	List<Integer> getFans(int toUserFan);
	
	List<Integer> getStars(int fromUserFan);

	int addStar(Fan fan);
	
	int delStar(int fanNum);
	
	Integer getFanNum(HashMap<String, Object> map);
}
