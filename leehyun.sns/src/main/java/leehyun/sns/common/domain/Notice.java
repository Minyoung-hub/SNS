package leehyun.sns.common.domain;

import java.util.Date;

public class Notice {
	private int type;
	private int userNum;
	private String userName;
	private String userId;
	private Date noticeTime;
	private int postNum;

	public int getType() {
		return type;
	}

	public int getUserNum() {
		return userNum;
	}

	public String getUserName() {
		return userName;
	}

	public String getUserId() {
		return userId;
	}

	public Date getNoticeTime() {
		return noticeTime;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setNoticeTime(Date noticeTime) {
		this.noticeTime = noticeTime;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}
}
