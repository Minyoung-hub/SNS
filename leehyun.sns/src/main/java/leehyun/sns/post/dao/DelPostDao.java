package leehyun.sns.post.dao;

import leehyun.sns.post.domain.DelPost;

public interface DelPostDao {
	boolean addDelPost(DelPost delPost);
	
	DelPost delPostCnt(int userNum);
	
	DelPost recentDelPost(int userNum);
}
