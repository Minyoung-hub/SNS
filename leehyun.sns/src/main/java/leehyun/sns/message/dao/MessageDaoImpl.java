package leehyun.sns.message.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.message.dao.map.MessageMap;
import leehyun.sns.message.domain.Message;

@Repository
public class MessageDaoImpl implements MessageDao {
	@Autowired
	private MessageMap messageMap;

	@Override
	public List<Message> getMessages(int chatNum) {
		return messageMap.getMessages(chatNum);
	}

	@Override
	public List<Message> getAddMessages(HashMap<String, Object> map) {
		return messageMap.getAddMessages(map);
	}

	@Override
	public Message getLastMessage(int chatNum) {
		return messageMap.getLastMessage(chatNum);
	}

	@Override
	public int getMessageCnt(HashMap<String, Object> map) {
		return messageMap.getMessageCnt(map);
	}

	@Override
	public int readChk1(HashMap<String, Object> map) {
		return messageMap.readChk1(map);
	}

	@Override
	public int readChk2(HashMap<String, Object> map) {
		return messageMap.readChk2(map);
	}

	@Override
	public int deleteMsg11(HashMap<String, Object> map) {
		return messageMap.deleteMsg11(map);
	}

	@Override
	public int deleteMsg12(HashMap<String, Object> map) {
		return messageMap.deleteMsg12(map);
	}

	@Override
	public int deleteMsg13(HashMap<String, Object> map) {
		return messageMap.deleteMsg13(map);
	}

	@Override
	public int deleteMsg14(HashMap<String, Object> map) {
		return messageMap.deleteMsg14(map);
	}

	@Override
	public int deleteMsg21(HashMap<String, Object> map) {
		return messageMap.deleteMsg21(map);
	}

	@Override
	public int deleteMsg22(HashMap<String, Object> map) {
		return messageMap.deleteMsg22(map);
	}

	@Override
	public int addMessage(Message message) {
		return messageMap.addMessage(message);
	}
}
