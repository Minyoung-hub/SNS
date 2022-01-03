package leehyun.sns.message.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.message.dao.map.ChattingMap;
import leehyun.sns.message.domain.Chatting;

@Repository
public class ChattingDaoImpl implements ChattingDao {
	@Autowired
	private ChattingMap chattingMap;

	@Override
	public List<Chatting> getChatting(int userNum) {
		return chattingMap.getChatting(userNum);
	}

	@Override
	public Chatting getChattingWithNum(int chatNum) {
		return chattingMap.getChattingWithNum(chatNum);
	}

	@Override
	public Chatting getChattingWithNum2(HashMap<String, Object> map) {
		return chattingMap.getChattingWithNum2(map);
	}

	@Override
	public int addChatting(HashMap<String, Object> map) {
		return chattingMap.addChatting(map);
	}
}
