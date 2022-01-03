package leehyun.sns.post.dao.map;

import java.util.List;

import leehyun.sns.post.domain.Post;

public interface PostMap {
	List<Post> getPosts(int userNum);
	
	List<Post> mainPosts(int userNum);
	
	int findLastPost();
	
	Post getPost(int postNum);
	
	int addPost(Post post);
	
	int updatePost(Post post);
	
	int delPost(int postNum);
	
	int delComments(int postNum);
}
