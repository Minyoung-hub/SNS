package leehyun.sns.post.dao;

import java.util.List;

import leehyun.sns.post.domain.Comment;

public interface CommentDao {
	List<Comment> getComments();
	
	Comment getComment(int commentNum);
	
	List<String> getCommentIds(int userNum);
	
	int addComment(Comment comment);
	
	int delComment(Comment comment);
}
