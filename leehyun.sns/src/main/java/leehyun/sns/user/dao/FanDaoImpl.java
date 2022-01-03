package leehyun.sns.user.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.user.dao.map.FanMap;
import leehyun.sns.user.domain.Fan;

@Repository
public class FanDaoImpl implements FanDao{
	
	@Autowired private FanMap fanMap;
	
	private List<Integer> fans;
	boolean isCheck;
	
	public FanDaoImpl() {
		this.fans = new ArrayList<Integer>();
	}
	
	@Override
	public List<Integer> getFans(int toUserFan){
		fans = fanMap.getFans(toUserFan); 
		return fans;
	}
	
	@Override
	public List<Integer> getStars(int fromUserFan){
		fans = fanMap.getStars(fromUserFan); 
		return fans;
	}

	@Override
	public boolean addStar(Fan fan) {
		isCheck = false;
		int cnt = fanMap.addStar(fan);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}

	@Override
	public boolean delStar(int fanNum) {
		isCheck = false;
		int cnt = fanMap.delStar(fanNum);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	public Integer getFanNum(HashMap<String, Object> map) {
		return fanMap.getFanNum(map);
	}
}