package leehyun.sns.user.domain;

import java.util.Date;

public class Fan {
	private int fanNum;
	private Date fanTime;
	private int toUserNum;
	private int fromUserNum;
	
	public Fan() {}
	
	public Fan(int fanNum, int fromUserNum, int toUserNum, Date fanTime) {
		this.fanNum = fanNum;
		this.toUserNum = toUserNum;
		this.fromUserNum = fromUserNum;
		this.fanTime = fanTime;
	}

	public int getFanNum() {
		return fanNum;
	}

	public int getToUserNum() {
		return toUserNum;
	}

	public void setToUserNum(int toUserNum) {
		this.toUserNum = toUserNum;
	}

	public int getFromUserNum() {
		return fromUserNum;
	}

	public void setFromUserNum(int fromUserNum) {
		this.fromUserNum = fromUserNum;
	}

	public void setFanNum(int fanNum) {
		this.fanNum = fanNum;
	}

	public Date getFanTime() {
		return fanTime;
	}

	public void setFanTime(Date fanTime) {
		this.fanTime = fanTime;
	}
}