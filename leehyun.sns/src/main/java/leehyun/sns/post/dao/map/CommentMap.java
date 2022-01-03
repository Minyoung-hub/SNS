package leehyun.sns.post.dao.map;

import java.util.List;

import leehyun.sns.post.domain.Comment;

public interface CommentMap {
	List<Comment> getComments();
	
	Comment getComment(int commentNum);
	
	List<String> getCommentIds(int userNum);
	
	int addComment(Comment comment);
	
	int delComment(Comment comment);
}
