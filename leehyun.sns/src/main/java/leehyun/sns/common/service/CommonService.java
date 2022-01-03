package leehyun.sns.common.service;

import java.util.List;

import leehyun.sns.common.domain.Notice;

public interface CommonService {
	List<Notice> getNotice(int userNum);
}
