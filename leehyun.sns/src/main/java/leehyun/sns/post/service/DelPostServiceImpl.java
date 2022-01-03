package leehyun.sns.post.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.post.dao.DelPostDao;
import leehyun.sns.post.dao.DelPostDaoImpl;
import leehyun.sns.post.domain.DelPost;

@Service
public class DelPostServiceImpl implements DelPostService{
	@Autowired private DelPostDao delPostDao;
	
	public DelPostServiceImpl() {
		this.delPostDao = new DelPostDaoImpl();
	}
	
	@Override
	public boolean putDelPost(DelPost delPost) {
		return delPostDao.addDelPost(delPost);
	}
	
	@Override
	public DelPost getDelPostCnt(int userNum) {
		return delPostDao.delPostCnt(userNum);
	}
	
	@Override
	public DelPost latestDelPost(int userNum) {
		return delPostDao.recentDelPost(userNum);
	}
}
