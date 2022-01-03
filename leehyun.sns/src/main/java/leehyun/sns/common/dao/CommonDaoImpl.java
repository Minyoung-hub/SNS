package leehyun.sns.common.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.common.dao.map.CommonMap;
import leehyun.sns.common.domain.Notice;

@Repository
public class CommonDaoImpl implements CommonDao {
	@Autowired private CommonMap commonMap;

	@Override
	public List<Notice> getFans(int userNum) {
		return commonMap.getFans(userNum);
	}

	@Override
	public List<Notice> getLikes(int userNum) {
		return commonMap.getLikes(userNum);
	}

	@Override
	public List<Notice> getComments(int userNum) {
		return commonMap.getComments(userNum);
	}
}
