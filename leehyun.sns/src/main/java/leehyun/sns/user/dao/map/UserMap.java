package leehyun.sns.user.dao.map;

import java.util.HashMap;
import java.util.List;

import leehyun.sns.user.domain.User;

public interface UserMap {
	List<User> getUsers();

	List<User> getUserList(String userName);
	
	List<User> searchUsers(String partUserName);
	
	User getUser(String userName);
	
	User getUserWithNum(int userNum);
	
	User getUserWithId(String userId);

	int addUser(User user);

	int updateUser(User user);
	
	int adminUpdateUser(User user);
	
	int updatePenaltyDate(User user);
	
	int updatePenaltyDate2(int userNum);
	
	int delUser(int userNum);
	
	User pwUser(String userId);
	
	User loginChk(String userId);

	int pwChk(HashMap<String, Object> map);
}
