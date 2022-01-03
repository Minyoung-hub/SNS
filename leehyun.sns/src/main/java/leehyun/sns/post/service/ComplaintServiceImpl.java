package leehyun.sns.post.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import leehyun.sns.post.dao.ComplaintDao;
import leehyun.sns.post.dao.ComplaintDaoImpl;
import leehyun.sns.post.domain.Complaint;

@Service
public class ComplaintServiceImpl implements ComplaintService{
	@Autowired private ComplaintDao complaintDao;
	
	public ComplaintServiceImpl() {
		this.complaintDao = new ComplaintDaoImpl();
	}
	
	@Override
	public List<Complaint> listComplaints() {
		return complaintDao.getComplaints();
	}
	
	
	
	@Override
	public Complaint findComplaint(Complaint complaint) {
		return complaintDao.getComplaint(complaint);
	}

	@Override
	public List<Complaint> listComplaintTypes() {
		return complaintDao.getComplaintTypes();
	}
	
	@Override
	public boolean cancelComplaint(int postNum) {
		return complaintDao.delComplaint(postNum);
	}
	
	@Override
	public boolean joinComplaint(Complaint complaint) {
		return complaintDao.addComplaint(complaint);
	}
}
