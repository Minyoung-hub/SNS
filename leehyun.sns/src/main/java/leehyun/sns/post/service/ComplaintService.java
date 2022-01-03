package leehyun.sns.post.service;

import java.util.List;

import leehyun.sns.post.domain.Complaint;

public interface ComplaintService {
	List<Complaint> listComplaints();
	
	Complaint findComplaint(Complaint complaint);
	
	List<Complaint> listComplaintTypes();
	
	boolean cancelComplaint(int postNum);
	
	boolean joinComplaint(Complaint complaint);
}