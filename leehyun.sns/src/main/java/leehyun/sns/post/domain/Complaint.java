package leehyun.sns.post.domain;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class Complaint {
	private int complaintNum;
	private int postNum;
	private int userNum;
	private Date postComplaintDate;
	private String complaintType;
	private int complaintCnt;
	
	public Complaint() {}
	
	public Complaint(int complaintNum, int postNum, int userNum, Date postComplaintDate, String complaintType, int complaintCnt) {
		this.complaintNum = complaintNum;
		this.postNum = postNum;
		this.userNum = userNum;
		this.postComplaintDate = postComplaintDate;
		this.complaintType = complaintType;
		this.complaintCnt = complaintCnt;
	}

	public int getComplaintNum() {
		return complaintNum;
	}

	public int getPostNum() {
		return postNum;
	}

	public int getUserNum() {
		return userNum;
	}

	public String getPostComplaintDate() {
		SimpleDateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
		return dateFormat.format(postComplaintDate);
	}

	public String getComplaintType() {
		return complaintType;
	}

	public void setComplaintNum(int complaintNum) {
		this.complaintNum = complaintNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public void setPostComplaintDate(Date postComplaintDate) {
		this.postComplaintDate = postComplaintDate;
	}

	public void setComplaintType(String complaintType) {
		this.complaintType = complaintType;
	}

	public int getComplaintCnt() {
		return complaintCnt;
	}

	public void setComplaintCnt(int complaintCnt) {
		this.complaintCnt = complaintCnt;
	}
}
