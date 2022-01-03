package leehyun.sns.post.dao.map;

import leehyun.sns.post.domain.DelPost;

public interface DelPostMap {
	int addDelPost(DelPost delPost);
	
	DelPost delPostCnt(int userNum);
	
	DelPost recentDelPost(int userNum);
}
