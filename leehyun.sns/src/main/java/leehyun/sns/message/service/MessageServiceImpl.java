package leehyun.sns.message.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import leehyun.sns.message.dao.MessageDao;
import leehyun.sns.message.domain.Message;

@Service
public class MessageServiceImpl implements MessageService{
	@Autowired private MessageDao messageDao;

	@Override
	public List<Message> findMessages(int chatNum) {
		return messageDao.getMessages(chatNum);
	}

	@Override
	public List<Message> findAddMessages(int chatNum, int msgNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chatNum", chatNum);
		map.put("msgNum", msgNum);
		return messageDao.getAddMessages(map);
	}

	@Override
	public Message findLastMessage(int chatNum) {
		return messageDao.getLastMessage(chatNum);
	}
	
	@Override
	public int findMessageCnt(int chatNum, int userNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chatNum", chatNum);
		map.put("userNum", userNum);
		return messageDao.getMessageCnt(map);
	}
	
	@Override
	public int readChk(int chatNum, int userNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chatNum", chatNum);
		map.put("userNum", userNum);
		return messageDao.readChk1(map) + messageDao.readChk2(map);
	}
	
	@Override
	@Transactional
	public int deleteMsg(int chatNum, int myNum, int yourNum) {
		int result = 0;
		HashMap<String, Object> map1 = new HashMap<>();
		map1.put("chatNum", chatNum);
		map1.put("userNum", myNum);
		HashMap<String, Object> map2 = new HashMap<>();
		map2.put("chatNum", chatNum);
		map2.put("userNum", yourNum);
		result += messageDao.deleteMsg21(map1);
		result += messageDao.deleteMsg22(map2);
		result += messageDao.deleteMsg11(map1);
		result += messageDao.deleteMsg12(map1);
		result += messageDao.deleteMsg13(map2);
		result += messageDao.deleteMsg14(map2);
		return result;
	}

	@Override
	public boolean joinMessage(Message message) {
		return messageDao.addMessage(message) > 0;
	}
}
