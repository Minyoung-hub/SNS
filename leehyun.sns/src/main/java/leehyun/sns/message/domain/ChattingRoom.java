package leehyun.sns.message.domain;

public class ChattingRoom {
	private int chatNum;
	private int toUserNum;
	private String toUserImg;
	private String toUserName;
	private String lastMsg;
	private int msgCnt;

	public int getChatNum() {
		return chatNum;
	}

	public int getToUserNum() {
		return toUserNum;
	}

	public String getToUserImg() {
		return toUserImg;
	}

	public String getToUserName() {
		return toUserName;
	}

	public String getLastMsg() {
		return lastMsg;
	}

	public int getMsgCnt() {
		return msgCnt;
	}

	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}

	public void setToUserNum(int toUserNum) {
		this.toUserNum = toUserNum;
	}

	public void setToUserImg(String toUserImg) {
		this.toUserImg = toUserImg;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public void setLastMsg(String lastMsg) {
		this.lastMsg = lastMsg;
	}

	public void setMsgCnt(int msgCnt) {
		this.msgCnt = msgCnt;
	}
}
