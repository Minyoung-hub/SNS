package leehyun.sns.post.dao;

import java.util.List;

import leehyun.sns.post.domain.Complaint;

public interface ComplaintDao {
	List<Complaint> getComplaints();
	
	Complaint getComplaint(Complaint complaint);
	
	List<Complaint> getComplaintTypes();
	
	boolean delComplaint(int postNum);
	
	boolean addComplaint(Complaint complaint);
}
