package leehyun.sns.post.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import leehyun.sns.post.dao.map.ComplaintMap;
import leehyun.sns.post.domain.Complaint;

@Repository
public class ComplaintDaoImpl implements ComplaintDao{
	@Autowired private ComplaintMap complaintMap;
	boolean isCheck;
	
	@Override
	public List<Complaint> getComplaints() {
		return complaintMap.getComplaints();
	}
	
	@Override
	public Complaint getComplaint(Complaint complaint) {
		return complaintMap.getComplaint(complaint);
	}

	@Override
	public List<Complaint> getComplaintTypes() {
		return complaintMap.getComplaintTypes();
	}
	
	@Override
	public boolean delComplaint(int postNum) {
		isCheck = false;
		int cnt = complaintMap.delComplaint(postNum);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
	
	@Override
	public boolean addComplaint(Complaint complaint) {
		isCheck = false;
		int cnt = complaintMap.addComplaint(complaint);
		if(cnt > 0 )
			isCheck = true;
		return isCheck;
	}
}
