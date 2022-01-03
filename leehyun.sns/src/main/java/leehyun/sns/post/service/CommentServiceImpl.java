package leehyun.sns.post.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.post.dao.CommentDao;
import leehyun.sns.post.domain.Comment;

@Service
public class CommentServiceImpl implements CommentService{
	@Autowired private CommentDao commentDao;
	
	@Override
	public boolean correctComment(Comment comment) {
		return commentDao.addComment(comment)>0;
	}
	
	@Override
	public boolean secedeComment(Comment comment) {
		return commentDao.delComment(comment)>0;
	}
	
	@Override
	public List<Comment> listComments(){
		return commentDao.getComments();
	}
	
	@Override
	public List<String> listCommentIds(int userNum){
		return commentDao.getCommentIds(userNum);
	}
	
	@Override
	public Comment listComment(int commentNum) {
		return commentDao.getComment(commentNum);
	}
}
