package leehyun.sns.message.service;

import java.util.List;

import leehyun.sns.message.domain.Message;

public interface MessageService {
	List<Message> findMessages(int chatNum);
	List<Message> findAddMessages(int chatNum, int msgNum);
	Message findLastMessage(int chatNum);
	int findMessageCnt(int chatNum, int userNum);
	int readChk(int chatNum, int userNum);
	int deleteMsg(int chatNum, int myNum, int yourNum);
	boolean joinMessage(Message message);
}
