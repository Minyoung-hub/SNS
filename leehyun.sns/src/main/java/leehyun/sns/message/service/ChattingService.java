package leehyun.sns.message.service;

import java.util.List;

import leehyun.sns.message.domain.Chatting;

public interface ChattingService {
	List<Chatting> listChatting(int userNum);
	Chatting findChatting(int chatNum);
	Chatting findChatting2(int userNum1, int userNum2);
	int joinChatting(int hostUserNum, int guestUserNum);
}
