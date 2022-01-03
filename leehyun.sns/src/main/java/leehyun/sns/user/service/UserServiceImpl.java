package leehyun.sns.user.service;

import java.util.HashMap;
import java.util.List;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import leehyun.sns.user.dao.UserDao;
import leehyun.sns.user.domain.User;

@Service
public class UserServiceImpl implements UserService{
   @Autowired private UserDao userDao;
   @Autowired JavaMailSender mailSender;
   public UserServiceImpl(UserDao userDao) {
      this.userDao = userDao;
   }
   
   @Override
   public List<User> listUsers(){
      return userDao.getUsers();
   }
   
   @Override
   public List<User> lookUsers(String partUserName){
      return userDao.searchUsers(partUserName);
   }
   
   @Override
   public User findUser(String userName) {
      return userDao.getUser(userName);
   }
   
   @Override
   public User findUserWithNum(int userNum) {
      return userDao.getUserWithNum(userNum);
   }
   
   @Override
   public User findUserWithId(String userId) {
      return userDao.getUserWithId(userId);
   }
   
   @Override
   public List<User> findUsers(String userName) {
      return userDao.getUserList(userName);
   }
   
   @Override
   public boolean join(User user) {
      return userDao.addUser(user);
   }
   
   @Override
   public boolean correctUser(User user) {
      return userDao.updateUser(user);
   }
   
   @Override
   public boolean adminCorrectUser(User user) {
	   return userDao.adminUpdateUser(user);
   }
   
   @Override
	public boolean correctPenaltyDate(User user) {
		return userDao.updatePenaltyDate(user);
	}
   
   @Override
	public boolean correctPenaltyDate2(int userNum) {
		return userDao.updatePenaltyDate2(userNum);
	}
   
   @Override
   public boolean pwChange(HashMap<String, Object> map) {
      return userDao.pwChk(map);
   }
   
   @Override
   public boolean secede(int userNum) {
      return userDao.delUser(userNum);
   }
   
   @Override
   public User findPw(String userId) {
      return userDao.pwUser(userId);
   }
   
   @Override
   public User chkUser(String userId) {
      return userDao.loginChk(userId);
   }
   
   @Override
   public void send(String email, int emailNum) {
      MimeMessage message = mailSender.createMimeMessage(); // 메일 내용으로 html 문장을 넣고싶을 때
      String txt = "<div class='container' style='border:1px solid #A593E0;'>\r\n" + 
               "   <div style='background:#A593E0; height:30px;'></div>\r\n" + 
               "   <h1 style='color: gray; margin-left: 30px;'><b style='color:#A593E0;'> FANPLE의 인증번호</b>를<br> 안내해 드립니다.</h1>\r\n" + 
               "   <br>\r\n" + 
               "   <h4 style='margin-left: 30px;'>안녕하세요 회원님, <b style='color:#A593E0;'>FANPLE</b>입니다.<div style='height: 10px;'></div>\r\n" + 
               "   요청하신 인증번호를 안내해 드립니다. <div style='height: 10px;'></div>\r\n" + 
               "   아래 번호를 인증번호 입력란에 입력하시면 인증이 완료됩니다.<br>\r\n" + 
               "   </h4>\r\n" + 
               "   <br>\r\n" + 
               "   <div style='margin-left: 30px; margin-right: 30px; border: 1px solid #A593E0; width: 600px'>\r\n" + 
               "      <div style='display: inline-block; height: 50px; width: 150px; font-size: 25px; background:#A593E0; color: white;'>&nbsp;인증번호</div>\r\n" + 
               "      <div style='display: inline-block; height: 50px; width: 350px; font-size: 25px; color: gray;'>&nbsp;"+ emailNum +"</div>\r\n" + 
               "   </div>\r\n" + 
               "   <br>\r\n" + 
               "   <p style='color: gray; margin-left: 30px;'>\r\n" + 
               "   - 인증코드가 타인에게 노출되지 않도록 해주세요.<br>\r\n" + 
               "   - 잘못 수신된 이메일인 경우 FANPLE 고객센터에 문의해주세요.<br>\r\n" + 
               "   </p>\r\n" + 
               "   <br><hr style='margin-left: 30px; margin-right: 30px;'>\r\n" + 
               "   <br><p style='color: gray; margin-left: 30px;'> \r\n" + 
               "   본 메일은 발신 전용으로 회신되지 않습니다. 추가 문의는 FANPLE 고객센터 : 02-0000-0000 를 이용해주시기 바랍니다.\r\n" + 
               "<br></div>";
      try {
         message.addRecipient(RecipientType.TO, new InternetAddress(email));
         message.setSubject("FANPLE - 이메일 인증 번호");
         message.setText(txt, "utf-8", "html");
      }catch(Exception e) {}
      
      mailSender.send(message);
   }
}