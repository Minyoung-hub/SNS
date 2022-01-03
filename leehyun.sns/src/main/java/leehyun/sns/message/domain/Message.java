package leehyun.sns.message.domain;

import java.util.Date;

public class Message {
	private int msgNum;
	private int chatNum;
	private String msgContent;
	private Date msgTime;
	private int sender;
	private String msgCheck;

	public int getMsgNum() {
		return msgNum;
	}

	public int getChatNum() {
		return chatNum;
	}

	public String getMsgContent() {
		return msgContent;
	}

	public Date getMsgTime() {
		return msgTime;
	}

	public int getSender() {
		return sender;
	}

	public String getMsgCheck() {
		return msgCheck;
	}

	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}

	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}

	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}

	public void setMsgTime(Date msgTime) {
		this.msgTime = msgTime;
	}

	public void setSender(int sender) {
		this.sender = sender;
	}

	public void setMsgCheck(String msgCheck) {
		this.msgCheck = msgCheck;
	}
}
