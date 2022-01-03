package leehyun.sns.message.dao;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.message.domain.Chatting;

public interface ChattingDao {
	List<Chatting> getChatting(int userNum);
	Chatting getChattingWithNum(int chatNum);
	Chatting getChattingWithNum2(HashMap<String, Object> map);
	int addChatting(HashMap<String, Object> map);
}
