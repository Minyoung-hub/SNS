package leehyun.sns.user.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class User {
	private int userNum;
	private String userName;
	private String userId;
	private String password;
	private String birthday;
	private String email;
	private String phoneNum;
	private String gender;
	private String profileImg;
	private Date regDate;
	private String penaltyDate;
	
	public User() {}
	
	public User(int userNum, String userName, String userId, String password, String birthday, String email, String phoneNum, String gender, String profileImg, Date regDate, String penaltyDate) {
		this.userNum = userNum;
		this.userName = userName;
		this.userId = userId;
		this.password = password;
		this.birthday = birthday;
		this.email = email;
		this.phoneNum = phoneNum;
		this.gender = gender;
		this.profileImg = profileImg;
		this.regDate = regDate;
		this.penaltyDate = penaltyDate;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirthday() {
		String birthdayFormat = birthday.substring(0, 10);
		return birthdayFormat;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getRegDate() {
		SimpleDateFormat dateFormat;
		dateFormat = new SimpleDateFormat("yyyy-MM-dd");	
		return dateFormat.format(regDate);
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getPenaltyDate() {
		return penaltyDate;
	}

	public void setPenaltyDate(String penaltyDate) {
		this.penaltyDate = penaltyDate;
	}

	public String toString() {
		return String.format("[%s, %s]", userName, password);
	}
}