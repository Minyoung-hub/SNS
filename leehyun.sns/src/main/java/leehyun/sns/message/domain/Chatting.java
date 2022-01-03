package leehyun.sns.message.domain;

public class Chatting {
	private int chatNum;
	private int hostUserNum;
	private int guestUserNum;

	public int getChatNum() {
		return chatNum;
	}

	public int getHostUserNum() {
		return hostUserNum;
	}

	public int getGuestUserNum() {
		return guestUserNum;
	}

	public void setChatNum(int chatNum) {
		this.chatNum = chatNum;
	}

	public void setHostUserNum(int hostUserNum) {
		this.hostUserNum = hostUserNum;
	}

	public void setGuestUserNum(int guestUserNum) {
		this.guestUserNum = guestUserNum;
	}
}
