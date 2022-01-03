package leehyun.sns.post.service;

import leehyun.sns.post.domain.DelPost;

public interface DelPostService {
	boolean putDelPost(DelPost delPost);
	
	DelPost getDelPostCnt(int userNum);
	
	DelPost latestDelPost(int userNum);
}
