package leehyun.sns.post.service;

import java.util.List;

import leehyun.sns.post.domain.Post;

public interface PostService {
	List<Post> listPosts(int userNum);
	List<Post> mainPosts(int userNum);
	int chkLastPost();
	Post findPost(int postNum);
	boolean posting(Post post);
	boolean correctPost(Post post);
	boolean secedePost(int postNum);
	boolean secedeComments(int postNum);
}
