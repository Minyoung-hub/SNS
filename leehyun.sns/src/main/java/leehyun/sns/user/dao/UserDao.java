package leehyun.sns.user.dao;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.user.domain.User;

public interface UserDao {
	List<User> getUsers(); 
	
	List<User> getUserList(String userName);
	
	List<User> searchUsers(String partUserName);
	
	User getUser(String userName);
	
	User getUserWithNum(int userNum);
	
	User getUserWithId(String userId);

	boolean addUser(User user);

	boolean updateUser(User user);
	
	boolean adminUpdateUser(User user);
	
	boolean updatePenaltyDate(User user);
	
	boolean updatePenaltyDate2(int userNum);

	boolean delUser(int userNum);
	
	User pwUser(String userId);
	
	User loginChk(String userId);

	boolean pwChk(HashMap<String, Object> map);
}
