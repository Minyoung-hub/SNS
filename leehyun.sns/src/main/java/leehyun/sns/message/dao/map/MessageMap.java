package leehyun.sns.message.dao.map;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.message.domain.Message;

public interface MessageMap {
	List<Message> getMessages(int chatNum);
	List<Message> getAddMessages(HashMap<String, Object> map);
	Message getLastMessage(int chatNum);
	int getMessageCnt(HashMap<String, Object> map);
	int readChk1(HashMap<String, Object> map);
	int readChk2(HashMap<String, Object> map);
	int deleteMsg11(HashMap<String, Object> map);
	int deleteMsg12(HashMap<String, Object> map);
	int deleteMsg13(HashMap<String, Object> map);
	int deleteMsg14(HashMap<String, Object> map);
	int deleteMsg21(HashMap<String, Object> map);
	int deleteMsg22(HashMap<String, Object> map);
	int addMessage(Message message);
}
