package leehyun.sns.message.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.message.dao.ChattingDao;
import leehyun.sns.message.domain.Chatting;

@Service
public class ChattingServiceImpl implements ChattingService {
	@Autowired
	private ChattingDao chattingDao;

	@Override
	public List<Chatting> listChatting(int userNum) {
		return chattingDao.getChatting(userNum);
	}

	@Override
	public Chatting findChatting(int chatNum) {
		return chattingDao.getChattingWithNum(chatNum);
	}

	@Override
	public Chatting findChatting2(int userNum1, int userNum2) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("userNum1", userNum1);
		map.put("userNum2", userNum2);
		return chattingDao.getChattingWithNum2(map);
	}

	@Override
	public int joinChatting(int hostUserNum, int guestUserNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("hostUserNum", hostUserNum);
		map.put("guestUserNum", guestUserNum);
		return chattingDao.addChatting(map);
	}
}
