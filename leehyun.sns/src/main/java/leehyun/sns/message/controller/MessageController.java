package leehyun.sns.message.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import leehyun.sns.message.domain.Chatting;
import leehyun.sns.message.domain.ChattingRoom;
import leehyun.sns.message.domain.Message;
import leehyun.sns.message.service.ChattingService;
import leehyun.sns.message.service.MessageService;
import leehyun.sns.user.domain.User;
import leehyun.sns.user.service.UserService;

@Controller
@RequestMapping("/message")
public class MessageController {
	@Autowired private ChattingService chattingService;
	@Autowired private MessageService messageService;
	@Autowired private UserService userService;

	@RequestMapping
	public ModelAndView chatting(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/message/chatting");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/reload")
	public List<ChattingRoom> reload(HttpSession session) {
		int myUserNum = (int)session.getAttribute("userNum");

		List<Chatting> chattings = chattingService.listChatting(myUserNum);
		List<ChattingRoom> cr = new ArrayList<>();
		Message message = null;
		
		for(Chatting chatting: chattings){
			ChattingRoom r = new ChattingRoom();
			r.setChatNum(chatting.getChatNum());
			if(chatting.getHostUserNum() == myUserNum){
				r.setToUserNum(chatting.getGuestUserNum());
				r.setToUserName(userService.findUserWithNum(chatting.getGuestUserNum()).getUserName());
				r.setToUserImg(userService.findUserWithNum(chatting.getGuestUserNum()).getProfileImg());
			}else{
				r.setToUserNum(chatting.getHostUserNum());
				r.setToUserName(userService.findUserWithNum(chatting.getHostUserNum()).getUserName());
				r.setToUserImg(userService.findUserWithNum(chatting.getHostUserNum()).getProfileImg());
			}
			if(messageService.findLastMessage(chatting.getChatNum()) != null) {
				message = messageService.findLastMessage(chatting.getChatNum());
				if(message.getSender() == myUserNum && (message.getMsgCheck().equals("2") || message.getMsgCheck().equals("3") || message.getMsgCheck().equals("4") || message.getMsgCheck().equals("8")))
					continue;
				else if(message.getSender() != myUserNum && (message.getMsgCheck().equals("6") || message.getMsgCheck().equals("7") || message.getMsgCheck().equals("4") || message.getMsgCheck().equals("8")))
					continue;
				else
					r.setLastMsg(message.getMsgContent().replace("'", "\\'").replace("\\", "\\\\"));
			}
			else
				continue;
			r.setMsgCnt(messageService.findMessageCnt(chatting.getChatNum(), myUserNum));
			cr.add(r);
		}

		return cr;
	}
	
	@RequestMapping("/{chatNum}")
	public ModelAndView message(@PathVariable int chatNum, HttpSession session) {
		int myUserNum = (int)session.getAttribute("userNum");
		messageService.readChk(chatNum, myUserNum);
		int toUserNum = 0;
		ModelAndView mv = new ModelAndView();
		Chatting c =  chattingService.findChatting(chatNum);
		
		if(c == null || c.getGuestUserNum() != myUserNum && c.getHostUserNum() != myUserNum ) {
			mv.setViewName("main");
			return mv;
		}
		
		if(c.getGuestUserNum() == myUserNum) {
			toUserNum = c.getHostUserNum();
		}else {
			toUserNum = c.getGuestUserNum();
		}
		
		User toUser = userService.findUserWithNum(toUserNum);
		
		List<Message> msgs = messageService.findMessages(chatNum);
		List<Message> msgs1 = new ArrayList<>();
		
		for(int i = 0; i < msgs.size(); i++) {
			msgs.get(i).setMsgContent(msgs.get(i).getMsgContent().replace("'", "\\'").replace("\\", "\\\\"));
			if(!((msgs.get(i).getSender() == myUserNum && (msgs.get(i).getMsgCheck().equals("2") || msgs.get(i).getMsgCheck().equals("3") || msgs.get(i).getMsgCheck().equals("4") || msgs.get(i).getMsgCheck().equals("8"))) || (msgs.get(i).getSender() != myUserNum && (msgs.get(i).getMsgCheck().equals("6") || msgs.get(i).getMsgCheck().equals("7") || msgs.get(i).getMsgCheck().equals("4") || msgs.get(i).getMsgCheck().equals("8"))))) {
				msgs1.add(msgs.get(i));
			}
		}
		
		mv.addObject("myUserNum", myUserNum);
		mv.addObject("toUser", toUser);
		session.setAttribute("toUserNum", toUserNum);
		mv.addObject("messages", msgs1);
		mv.addObject("chatNum", chatNum);
		mv.setViewName("/message/message");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("/readChk")
	public int readChk(HttpSession session, int chatNum) {
		int myUserNum = (int)session.getAttribute("userNum");
		return messageService.readChk(chatNum, myUserNum);
	}
	
	@ResponseBody
	@RequestMapping("/send")
	public boolean send(HttpSession session, String msg, int chatNum) {
		Message message = new Message();
		message.setChatNum(chatNum);
		message.setMsgContent(msg);
		message.setSender((int)session.getAttribute("userNum"));
		return messageService.joinMessage(message);
	}
	
	@ResponseBody
	@RequestMapping("/addchatting")
	public int addchatting(HttpSession session, int toUserNum) {
		int myUserNum = (int)session.getAttribute("userNum");
		int chatNum = 0;
		Chatting chatting = chattingService.findChatting2(myUserNum, toUserNum);
		if(chatting == null) {
			chattingService.joinChatting(myUserNum, toUserNum);
			chatting = chattingService.findChatting2(myUserNum, toUserNum);
			chatNum = chatting.getChatNum();
		}else {
			chatNum = chatting.getChatNum();
		}
		return chatNum;
	}
	
	@ResponseBody
	@RequestMapping("/addMsg")
	public List<Message> addMsg(HttpSession session, int msgNum, int chatNum) {
		int myUserNum = (int)session.getAttribute("userNum");
		
		List<Message> msgs = messageService.findAddMessages(chatNum, msgNum);
		List<Message> msgs1 = new ArrayList<>();
		for(int i = 0; i < msgs.size(); i++) {
			msgs.get(i).setMsgContent(msgs.get(i).getMsgContent().replace("'", "\\'").replace("\\", "\\\\"));
			if(!((msgs.get(i).getSender() == myUserNum && (msgs.get(i).getMsgCheck().equals("2") || msgs.get(i).getMsgCheck().equals("3") || msgs.get(i).getMsgCheck().equals("4") || msgs.get(i).getMsgCheck().equals("8"))) || (msgs.get(i).getSender() != myUserNum && (msgs.get(i).getMsgCheck().equals("6") || msgs.get(i).getMsgCheck().equals("7") || msgs.get(i).getMsgCheck().equals("4") || msgs.get(i).getMsgCheck().equals("8"))))) {
				msgs1.add(msgs.get(i));
			}
		}
		
		return msgs1;
	}
	
	@ResponseBody
	@RequestMapping("/deleteMsg")
	public int deleteMsg(HttpSession session, int chatNum) {
		int myNum = (int)session.getAttribute("userNum");
		int yourNum = (int)session.getAttribute("toUserNum");
		return messageService.deleteMsg(chatNum, myNum, yourNum);
	}
}