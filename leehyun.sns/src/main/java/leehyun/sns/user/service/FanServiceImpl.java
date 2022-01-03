package leehyun.sns.user.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.user.dao.FanDao;
import leehyun.sns.user.domain.Fan;

@Service
public class FanServiceImpl implements FanService{
   @Autowired private FanDao fanDao;
   public FanServiceImpl(FanDao fanDao) {
      this.fanDao = fanDao;
   }
   
   @Override
   public List<Integer> listFans(int toUserFan){
      return fanDao.getFans(toUserFan);
   }
    
   @Override
   public List<Integer> listStars(int fromUserFan){
      return fanDao.getStars(fromUserFan);
   }
   
   @Override
   public boolean makeStar(Fan fan) {
      return fanDao.addStar(fan);
   }

   @Override
   public boolean removeStar(int fanNum) {
      return fanDao.delStar(fanNum);
   }
   
   @Override
	public int findFanNum(int toUserNum, int fromUserNum) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("toUserNum", toUserNum);
		map.put("fromUserNum", fromUserNum);
		return fanDao.getFanNum(map);
	}
}