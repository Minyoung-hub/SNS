package leehyun.sns.post.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Comment {
	private int commentNum;
	private int postNum;
	private int userNum;
	private String commentContent;
	private Date commentTime;
	
	public int getCommentNum() {
		return commentNum;
	}
	
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	
	public int getPostNum() {
		return postNum;
	}
	
	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
	
	public int getUserNum() {
		return userNum;
	}
	
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	
	public String getCommentContent() {
		return commentContent;
	}
	
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	public Date getCommentTime() {
		return commentTime;
	}
	
	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}
}
