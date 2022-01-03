package leehyun.sns.post.dao;

import java.util.List;

import leehyun.sns.post.domain.Post;

public interface PostDao {
	List<Post> getPosts(int userNum);
	
	List<Post> getPostsMain(int userNum);
	
	int findLastPost();
	
	Post getPost(int postNum);
	
	int addPost(Post post);
	
	int updatePost(Post post);
	
	boolean delPost(int postNum);
	
	boolean delComments(int postNum);
}
