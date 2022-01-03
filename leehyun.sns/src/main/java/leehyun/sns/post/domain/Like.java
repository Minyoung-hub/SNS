package leehyun.sns.post.domain;

import java.util.Date;

public class Like {
	private int postNum;
	private int likeCnt;
	private int disLikeCnt;
	private String myState;
	private int userNum;
	private String likeType;
	private Date likeTime;

	public Like(int postNum, int userNum, String likeType, Date likeTime) {
		this.postNum = postNum;
		this.userNum = userNum;
		this.likeType = likeType;
		this.likeTime = likeTime;
	}
	
	public Like() {
		// TODO Auto-generated constructor stub
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getLikeType() {
		return likeType;
	}

	public void setLikeType(String likeType) {
		this.likeType = likeType;
	}

	public Date getLikeTime() {
		return likeTime;
	}

	public void setLikeTime(Date likeTime) {
		this.likeTime = likeTime;
	}

	public int getPostNum() {
		return postNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public int getDisLikeCnt() {
		return disLikeCnt;
	}

	public void setDisLikeCnt(int disLikeCnt) {
		this.disLikeCnt = disLikeCnt;
	}

	public String getMyState() {
		return myState;
	}

	public void setMyState(String myState) {
		this.myState = myState;
	}
}
