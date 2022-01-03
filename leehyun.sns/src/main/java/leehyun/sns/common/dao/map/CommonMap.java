package leehyun.sns.common.dao.map;

import java.util.List;

import leehyun.sns.common.domain.Notice;

public interface CommonMap {
	List<Notice> getFans(int userNum);
	List<Notice> getLikes(int userNum);
	List<Notice> getComments(int userNum);
}
