package leehyun.sns.post.domain;

import java.util.Date;

public class DelPost {
	private int delPostNum;
	private String delPostImg;
	private String delPostRegDate;
	private Date delPostDelDate;
	private String delPostContent;
	private int userNum;
	private String delPostReason;
	private int declareCnt;
	private int delPostCnt;
	
	public DelPost() {}
	
	public DelPost(int delPostNum, String delPostImg, String delPostRegDate, Date delPostDelDate, 
			String delPostContent, int userNum, String delPostReason, int declareCnt, int delPostCnt) {
		this.delPostNum = delPostNum;
		this.delPostImg = delPostImg;
		this.delPostRegDate = delPostRegDate;
		this.delPostDelDate = delPostDelDate;
		this.delPostContent = delPostContent;
		this.userNum = userNum;
		this.delPostReason = delPostReason;
		this.declareCnt = declareCnt;
		this.delPostCnt = delPostCnt;
	}

	public int getDelPostNum() {
		return delPostNum;
	}

	public String getDelPostImg() {
		return delPostImg;
	}

	public String getDelPostRegDate() {
		return delPostRegDate;
	}

	public Date getDelPostDelDate() {
		return delPostDelDate;
	}

	public String getDelPostContent() {
		return delPostContent;
	}

	public int getUserNum() {
		return userNum;
	}

	public String getDelPostReason() {
		return delPostReason;
	}

	public int getDeclareCnt() {
		return declareCnt;
	}

	public void setDelPostNum(int delPostNum) {
		this.delPostNum = delPostNum;
	}

	public void setDelPostImg(String delPostImg) {
		this.delPostImg = delPostImg;
	}

	public void setDelPostRegDate(String delPostRegDate) {
		this.delPostRegDate = delPostRegDate;
	}

	public void setDelPostDelDate(Date delPostDelDate) {
		this.delPostDelDate = delPostDelDate;
	}

	public void setDelPostContent(String delPostContent) {
		this.delPostContent = delPostContent;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public void setDelPostReason(String delPostReason) {
		this.delPostReason = delPostReason;
	}

	public void setDeclareCnt(int declareCnt) {
		this.declareCnt = declareCnt;
	}

	public int getDelPostCnt() {
		return delPostCnt;
	}

	public void setDelPostCnt(int delPostCnt) {
		this.delPostCnt = delPostCnt;
	}
}
