package leehyun.sns.common.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.common.dao.CommonDao;
import leehyun.sns.common.domain.Notice;
import leehyun.sns.user.service.UserService;

@Service
public class CommonServiceImpl implements CommonService {
	@Autowired private CommonDao commonDao;
	@Autowired private UserService userService;

	@Override
	public List<Notice> getNotice(int userNum) {
		List<Notice> fans = commonDao.getFans(userNum);
		List<Notice> comments = commonDao.getComments(userNum);
		List<Notice> likes = commonDao.getLikes(userNum);
		List<Notice> notice = new ArrayList<Notice>();
		
		if(fans.size() + comments.size() + likes.size() == 0)
			return new ArrayList<Notice>();
		
		notice.addAll(fans);
		notice.addAll(comments);
		notice.addAll(likes);
		
		notice.sort(new Comparator<Notice>() {
		       @Override
		       public int compare(Notice arg0, Notice arg1) {
		              Date date0 = arg0.getNoticeTime();
		              Date date1 = arg1.getNoticeTime();
		              
		              int compare = date0.compareTo(date1);
		              
		              if ( compare > 0 ) return 1;
		              else if ( compare < 0 ) return -1;
		              else return 0;
		       }
		});
		
		for(Notice not : notice) {
			not.setUserName(userService.findUserWithNum(not.getUserNum()).getUserName());
			not.setUserId(userService.findUserWithNum(not.getUserNum()).getUserId());
		}
		
		return notice;
	}
}
