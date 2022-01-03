package leehyun.sns.common.dao;

import java.util.List;

import leehyun.sns.common.domain.Notice;

public interface CommonDao {
	List<Notice> getFans(int userNum);
	List<Notice> getLikes(int userNum);
	List<Notice> getComments(int userNum);
}
