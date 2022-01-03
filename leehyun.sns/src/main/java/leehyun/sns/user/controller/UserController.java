package leehyun.sns.user.controller;
 
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import leehyun.sns.user.domain.User;
import leehyun.sns.user.service.FanService;
import leehyun.sns.user.service.UserService;

@Controller
@RequestMapping
	public class UserController {
	@Autowired private UserService userService;
	@Autowired private FanService fanService;
	@Value("${attachDir}") private String attachDir;
	
	@RequestMapping("/user/addUser")
	public String addUser() {
		return "/user/addUser";
	}
	
	@RequestMapping("/user/login")
	public String login() {
		return "/user/login";
	} 
	
	@ResponseBody
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	public boolean login(HttpSession session, String userId, String userPw) {
		User chkUser = userService.chkUser(userId);
		User user = new User();
		boolean isLogin = false; 
 
		if(chkUser.getUserId() != null) {
			if(userPw.equals(chkUser.getPassword())) {
				if(userId != null) session.setAttribute("userId", userId);
				if(userPw != null) session.setAttribute("userPw", userPw);
				session.setAttribute("userNum", chkUser.getUserNum());
				session.setAttribute("user", chkUser);
				List<Integer> fanNums = fanService.listStars(chkUser.getUserNum());
				List<User> users = new ArrayList<>();
				for(int fanNum: fanNums) {
				user = userService.findUserWithNum(fanNum);
				users.add(user);
				}
				session.setAttribute("fans", users);
				isLogin = true;
			}
		}
		return isLogin;
	}
	
	@RequestMapping("/user/logout")
	public String logout(HttpSession session) {
			session.invalidate();
		return "/user/login";
	}
	
	@ResponseBody
	@RequestMapping("/user/findUser")
	public String finduser(String userId) {
		User user = userService.findUserWithId(userId);
		userId = user.getUserId();
		return userId;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/addUser", method=RequestMethod.POST)
	public String addUser(User user) {
		
		userService.join(user);
		return "/user/addUser";
	}
	
	@RequestMapping("/user/mail")
	public void send(String email, int emailNum) {
		userService.send(email, emailNum);
	}
	
	@RequestMapping("/user/findId")
	public String findId() {
		return "/user/findId";
	}
	
	@RequestMapping("/user/findPw")
	public String findPw() {
		return "/user/findPw";
	}
	
	@RequestMapping("/user/search")
	public String search() {
		return "user/search";
	}
	
	@RequestMapping("/user/modifyUser")
	public String modifyUser() {
		return "user/modifyUser";
	}
	
	@RequestMapping("/user/modifyUserPw")
	public String modifyUserPw() {
		return "user/modifyUserPw";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/modifyUserPw", method=RequestMethod.POST)
	public void modifyUserPw(String userId, String password) {
		User user = userService.findUserWithId(userId);
		user.setPassword(password);
		userService.correctUser(user);
	}
	
	@ResponseBody
	@RequestMapping(value="/user/modifyUser", method=RequestMethod.POST)
	public void modifyUser(HttpSession session, String userId, String userName, String phoneNum, String email, String gender, String birthday) {
		User user = userService.findUserWithId(userId);
		user.setUserName(userName);
		user.setPhoneNum(phoneNum);
		user.setEmail(email);
		user.setGender(gender);
		user.setBirthday(birthday);
		userService.correctUser(user);
		session.setAttribute("user", userService.findUserWithId(userId));
	}
	
	@RequestMapping(value="/user/search", method=RequestMethod.POST)
	public List<User> nameSearch(HttpSession session, String partUserName) {
		List<User> users = userService.lookUsers(partUserName);
		session.setAttribute("partUserName", partUserName);
		session.setAttribute("users", users);
		return users;
	}
	
	@RequestMapping("/user/findPwOut")
	public String findPwOut(HttpServletRequest request, HttpSession session) {
		session = request.getSession(true);
		return "/user/findPwOut";
	}
	
	@RequestMapping("/user/modifyPw")
	public String modifyPw() {
		return "/user/modifyPw";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/secede", method=RequestMethod.POST)
	public boolean secede(int userNum) {
		return userService.secede(userNum);
	}
	
	@ResponseBody
	@RequestMapping("/user/findPwProc")
	public boolean findPwProc(HttpSession session, String userId, int emailNum) {
		User user = userService.findUserWithId(userId);
		String id = user.getUserId();
		session.setAttribute("chkId", id);
		String email = user.getEmail();
		boolean isFindFath = false;
		if(userId.equals(id)) {
			isFindFath = true;
			session.setAttribute("emailNum", emailNum);
			userService.send(email, emailNum);
		}
		return isFindFath;
	}
	
	@RequestMapping("/user/findIdOut")
	public String findIdOut(HttpServletRequest request, HttpSession session) {
		session = request.getSession(true);
		return "/user/findIdOut";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/findId", method=RequestMethod.POST) 
	public boolean findIdIn(HttpSession session, String userName, String phoneNum){
		List<String> userIds = new ArrayList<>();
		boolean isFindFath = false;
		
		List<User> users = userService.findUsers(userName);
		for(User user: users) {
			if(user.getPhoneNum().equals(phoneNum)) {
			userIds.add(user.getUserId());
			}
			String name = user.getUserName();
			String phone = user.getPhoneNum();
			if(userName.equals(name) && phoneNum.equals(phone)) {
				session.setAttribute("user", user);
				session.setAttribute("userIds", userIds);
				isFindFath = true;
			}
		}			
		return isFindFath;
	}
	
	@ResponseBody
	@RequestMapping(value="/user/pwChange", method=RequestMethod.POST)
	public boolean pwChange(HttpServletRequest request, HttpSession session, String password) {
		session = request.getSession(true);
		String userId = (String)session.getAttribute("chkId");
		HashMap<String, Object> map = new HashMap<>();
		map.put("password", password);
		map.put("userId", userId);
		boolean isChk = userService.pwChange(map);
		return isChk;
	}
	
	@ResponseBody
	@RequestMapping("/user/listUsers")
	public List<User> listUsers() {
		List<User> users = userService.listUsers();
		return users;
	}
	
	@RequestMapping("/admin/user/adminUser")
	public String adminUser() {
		return "/admin/user/adminUser";
	}
	
	@ResponseBody
	@RequestMapping("/user/findUserWithNum")
	public User findUserWithNum(int userNum) {
		User getUser = userService.findUserWithNum(userNum);
		return getUser;
	}
	
	@ResponseBody
	@RequestMapping("/user/findUserWithId")
	public User findUserWithId(String userId) {
		User user = userService.findUserWithId(userId);
		if(user.getPenaltyDate() == null || user.getPenaltyDate().equals(""))
			user.setPenaltyDate("1111-11-11");
		return user;
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user/adminCorrectUser", method = RequestMethod.POST)
	public boolean correctUser(User user) {
		return userService.adminCorrectUser(user);
	}
	
	@ResponseBody
	@RequestMapping("/admin/user/correctPenaltyDate")
	public void correctPenaltyDate(int userNum) {
		User user = userService.findUserWithNum(userNum);
		String penaltyDate = user.getPenaltyDate();
		if(user.getPenaltyDate() == null || user.getPenaltyDate().equals("")) {
			LocalDate localDate = LocalDate.now();
			LocalDate endDate = localDate.plusDays(7);
			DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			penaltyDate = endDate.format(dateFormat);
			user.setPenaltyDate(penaltyDate);
			userService.correctPenaltyDate(user);
		}else {
			LocalDate localDate = LocalDate.now();
			penaltyDate = user.getPenaltyDate();
			LocalDate pdate = LocalDate.parse(penaltyDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
			if(pdate.isBefore(localDate)) {
				LocalDate endDate = localDate.plusDays(30);
				DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				penaltyDate = endDate.format(dateFormat);
				user.setPenaltyDate(penaltyDate);
				userService.correctPenaltyDate(user);
			} else if (pdate.isAfter(localDate) || pdate.isEqual(localDate)){
				LocalDate endDate = pdate.plusDays(30);
				DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
				penaltyDate = endDate.format(dateFormat);
				user.setPenaltyDate(penaltyDate);
				userService.correctPenaltyDate(user);
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/user/profile", method = RequestMethod.POST)
	public boolean logo(HttpSession session, MultipartFile attachFile, HttpServletRequest request) {
		boolean stored = true;
		User user = (User)session.getAttribute("user");
		int userNum = user.getUserNum();
		String userNumStr = Integer.toString(userNum);
		String dir = request.getServletContext().getRealPath(attachDir);
		String fileName = userNumStr + '_' + attachFile.getOriginalFilename();
		user.setProfileImg(fileName);
		userService.correctUser(user);
		try{
			save(dir + "/" + fileName, attachFile);
		}catch(IOException e){
			stored = false;
		}
		return stored;
	}

	private void save(String saveFile, MultipartFile attachFile) throws IOException {
		attachFile.transferTo(new File(saveFile));
	}
	
	@ResponseBody
	@RequestMapping(value="/user/baseProfileImg", method=RequestMethod.POST)
	public void baseProfileImg(HttpSession session, String userId) {
		User user = userService.findUserWithId(userId);
		user.setProfileImg("profile.jpg");
		userService.correctUser(user);
		session.setAttribute("user", user);
	}
}