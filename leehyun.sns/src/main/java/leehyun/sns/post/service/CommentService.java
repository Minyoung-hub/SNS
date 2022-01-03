package leehyun.sns.post.service;

import java.util.List;

import leehyun.sns.post.domain.Comment;

public interface CommentService {
	List<Comment> listComments();
	
	Comment listComment(int commentNum);
	
	List<String> listCommentIds(int userNum);
	
	boolean correctComment(Comment comment);
	
	boolean secedeComment(Comment comment);
}
