package leehyun.sns.post.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.post.dao.map.CommentMap;
import leehyun.sns.post.domain.Comment;

@Repository
public class CommentDaoImpl implements CommentDao{
	@Autowired private CommentMap commentMap;
	
	@Override
	public int addComment(Comment comment) {
		return commentMap.addComment(comment);
	}
	
	@Override
	public int delComment(Comment comment) {
		return commentMap.delComment(comment);
	}
	
	@Override
	public List<Comment> getComments(){
		return commentMap.getComments();
	}
	
	@Override
	public List<String> getCommentIds(int userNum){
		return commentMap.getCommentIds(userNum);
	}
	
	@Override
	public Comment getComment(int commentNum) {
		return commentMap.getComment(commentNum);
	}
}
