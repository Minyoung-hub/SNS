package leehyun.sns.post.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.post.dao.map.DelPostMap;
import leehyun.sns.post.domain.DelPost;

@Repository
public class DelPostDaoImpl implements DelPostDao{
	@Autowired private DelPostMap delPostMap;
	
	boolean isCheck;
	
	@Override
	public boolean addDelPost(DelPost delPost) {
		isCheck = false;
		int cnt = delPostMap.addDelPost(delPost);
		if(cnt > 0)
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public DelPost delPostCnt(int userNum) {
		return delPostMap.delPostCnt(userNum);
	}
	
	@Override
	public DelPost recentDelPost(int userNum) {
		return delPostMap.recentDelPost(userNum);
	}
}
