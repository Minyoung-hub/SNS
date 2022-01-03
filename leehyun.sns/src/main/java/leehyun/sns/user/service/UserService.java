package leehyun.sns.user.service;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.user.domain.User;

public interface UserService {
	List<User> listUsers();
	
	List<User> lookUsers(String partUserName);
	
	User findUser(String userName);
	
	User findUserWithNum(int userNum);
	
	User findUserWithId(String userId);
	
	List<User> findUsers(String userName);

	boolean join(User user);

	boolean correctUser(User user);
	
	boolean adminCorrectUser(User user);
	
	boolean correctPenaltyDate(User user);
	
	boolean correctPenaltyDate2(int userNum);

	boolean secede(int userNum);
	
	User findPw(String userId);
	
	User chkUser(String userId);
	
	boolean pwChange(HashMap<String, Object> map);
	
	void send(String email, int emailNum);
}
