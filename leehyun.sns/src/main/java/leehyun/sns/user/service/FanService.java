package leehyun.sns.user.service;

import java.util.List;

import leehyun.sns.user.domain.Fan;

public interface FanService {
	List<Integer> listFans(int toUserFan);

	List<Integer> listStars(int fromUserFan);

	boolean makeStar(Fan fan);

	boolean removeStar(int fanNum);
	
	int findFanNum(int toUserNum, int fromUserNum);
}
