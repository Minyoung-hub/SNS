package leehyun.sns.post.dao.map;

import java.util.List;

import leehyun.sns.post.domain.Complaint;

public interface ComplaintMap {
	List<Complaint> getComplaints();
	
	Complaint getComplaint(Complaint complaint);
	
	List<Complaint> getComplaintTypes();
	
	int delComplaint(int postNum);
	
	int addComplaint(Complaint complaint);
}
