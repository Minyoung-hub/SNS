package leehyun.sns.post.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Post {
	private int postNum;
	private String postImg;
	private Date regDate;
	private String postContent;
	private int userNum;
	private String userId;
	private String userImg;

	public Post() {
	}

	public Post(int postNum, String postImg, Date regDate, String postContent, int userNum, String userId, String userImg) {
		this.postNum = postNum;
		this.postImg = postImg;
		this.regDate = regDate;
		this.postContent = postContent;
		this.userNum = userNum;
		this.userId = userId;
		this.userImg = userImg;
	}
	
	public String getUserImg() {
		return userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getPostNum() {
		return postNum;
	}

	public String getPostImg() {
		return postImg;
	}

	public String getRegDate() {
		SimpleDateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		return dateFormat.format(regDate);
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public void setPostImg(String postImg) {
		this.postImg = postImg;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
}
