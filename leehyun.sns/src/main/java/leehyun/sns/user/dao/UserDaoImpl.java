package leehyun.sns.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.user.dao.map.UserMap;
import leehyun.sns.user.domain.User;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired private UserMap userMap;
	
	private List<User> users;
	boolean isCheck;
	
	public UserDaoImpl() {
		this.users = new ArrayList<User>();
	}
	
	@Override
	public List<User> getUsers(){
		users = userMap.getUsers(); 
		return users;
	}
	
	@Override
	public List<User> searchUsers(String partUserName){
		users = userMap.searchUsers(partUserName); 
		return users;
	}
	
	@Override
	public List<User> getUserList(String userName) {
		List<User> user = userMap.getUserList(userName); 
		return user;
	}
	
	@Override
	public User getUser(String userName) {
		User user = userMap.getUser(userName); 
		return user;
	}
	
	@Override
	public User getUserWithNum(int userNum) {
		User user = userMap.getUserWithNum(userNum); 
		return user;
	}

	@Override
	public User getUserWithId(String userId) {
		User user = userMap.getUserWithId(userId); 
		return user;
	}	
	
	@Override
	public boolean addUser(User user) {
		isCheck = false;
		int cnt = userMap.addUser(user);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean updateUser(User user) {
		isCheck = false;
		int cnt = userMap.updateUser(user);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean adminUpdateUser(User user) {
		isCheck = false;
		int cnt = userMap.adminUpdateUser(user);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean updatePenaltyDate(User user) {
		isCheck = false;
		int cnt = userMap.updatePenaltyDate(user);
		if(cnt > 0)
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean updatePenaltyDate2(int userNum) {
		isCheck = false;
		int cnt = userMap.updatePenaltyDate2(userNum);
		if(cnt > 0)
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean pwChk(HashMap<String, Object> map) {
		isCheck = false;
		userMap.pwChk(map);
		int cnt = userMap.pwChk(map);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean delUser(int userNum) {
		isCheck = false;
		int cnt = userMap.delUser(userNum);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public User pwUser(String userId) {
		User user = userMap.pwUser(userId);
		return user;
	}
	
	@Override
	public User loginChk(String userId) {
		User user = userMap.loginChk(userId);
		return user;
	}
}