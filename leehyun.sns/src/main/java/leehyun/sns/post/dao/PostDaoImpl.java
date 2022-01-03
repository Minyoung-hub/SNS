package leehyun.sns.post.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.post.dao.map.PostMap;
import leehyun.sns.post.domain.Post;

@Repository
public class PostDaoImpl implements PostDao{
	@Autowired private PostMap postMap;
	boolean isCheck;
	
	@Override
	public List<Post> getPosts(int userNum) {
		return postMap.getPosts(userNum);
	}
	
	@Override
	public List<Post> getPostsMain(int userNum) {
		return postMap.mainPosts(userNum);
	}
	
	@Override
	public int findLastPost() {
		return postMap.findLastPost();
	}
	
	@Override
	public Post getPost(int postNum) {
		return postMap.getPost(postNum);
	}
	
	@Override
	public int addPost(Post post) {
		return postMap.addPost(post);
	}
	
	@Override
	public int updatePost(Post post) {
		return postMap.updatePost(post);
	}
	
	@Override
	public boolean delPost(int postNum) {
		isCheck = false;
		int cnt = postMap.delPost(postNum);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean delComments(int postNum) {
		isCheck = false;
		int cnt = postMap.delComments(postNum);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
}
