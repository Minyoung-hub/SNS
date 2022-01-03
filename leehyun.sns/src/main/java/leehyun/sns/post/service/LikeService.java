package leehyun.sns.post.service;

import java.util.List;

import leehyun.sns.post.domain.Like;

public interface LikeService {
	int plusLike(Like like);
	int minusLike(int postNum, int userNum);
	int modifyLike(int postNum, int userNum, String likeType);
	List<Like> listLikes(int userNum);
	Like findLike(int postNum, int userNum);
}
