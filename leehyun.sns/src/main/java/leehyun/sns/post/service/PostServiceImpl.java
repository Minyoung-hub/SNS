package leehyun.sns.post.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.post.dao.PostDao;
import leehyun.sns.post.dao.PostDaoImpl;
import leehyun.sns.post.domain.Post;

@Service
public class PostServiceImpl implements PostService{
	@Autowired private PostDao postDao;
	
	public PostServiceImpl() {
		this.postDao = new PostDaoImpl();
	}
	
	@Override
	public List<Post> listPosts(int userNum){
		return postDao.getPosts(userNum);
	}
	
	@Override
	public List<Post> mainPosts(int userNum){
		return postDao.getPostsMain(userNum);
	}
	
	@Override
	public int chkLastPost() {
		return postDao.findLastPost();
	}
	
	@Override
	public Post findPost(int postNum) {
		return postDao.getPost(postNum);
	}
	
	@Override
	public boolean posting(Post post) {
		return postDao.addPost(post)>0;
	}
	
	@Override
	public boolean correctPost(Post post) {
		return postDao.updatePost(post)>0;
	}
	
	@Override
	public boolean secedePost(int postNum) {
		return postDao.delPost(postNum);
	}
	
	@Override
	public boolean secedeComments(int postNum) {
		return postDao.delComments(postNum);
	}
}
