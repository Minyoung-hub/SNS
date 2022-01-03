package leehyun.sns.post.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import leehyun.sns.post.domain.Complaint;
import leehyun.sns.post.service.ComplaintService;
import leehyun.sns.post.service.DelPostService;
import leehyun.sns.post.service.PostService;

@Controller
@RequestMapping
public class ComplaintController {
	@Autowired private ComplaintService complaintService;
	@Autowired private PostService postService; 
	@Autowired private DelPostService delPostService;
	
	@ResponseBody
	@RequestMapping("/admin/post/listComplaints")
	public List<Complaint> listComplaints() {
		List<Complaint> complaints = complaintService.listComplaints();
		List<Complaint> compTypes = complaintService.listComplaintTypes();
		for(Complaint comp: complaints) {
			for(Complaint comp2: compTypes) {
				if(comp.getPostNum() == comp2.getPostNum()) {
					comp.setComplaintType(comp2.getComplaintType());
					break;
				}
			}
		}		
		return complaints;
	}
	
	@RequestMapping("/admin/post/complaintPost")
	public String complaintPost() {
		return "/admin/post/complaintPost";
	}
	
	@RequestMapping("/admin/post/adminComplaintPost")
	public String adminComplaintPost() {
		return "/admin/post/adminComplaintPost";
	}
	
	@ResponseBody
	@RequestMapping("/admin/post/cancelComplaint")
	public boolean cancelComplaint(int postNum) {
		return complaintService.cancelComplaint(postNum);
	}
	
	@ResponseBody
	@RequestMapping("/complaint")
	public int complaint(String complaintType, int postNum, int userNum) {
		int isContent = 0;
		if(!complaintType.equals("")) {
			Complaint complaint = new Complaint();
			complaint.setPostNum(postNum);
			complaint.setUserNum(userNum);
			complaint.setComplaintType(complaintType);
			
			if(complaintService.findComplaint(complaint) == null) {
				complaintService.joinComplaint(complaint);
				isContent = 1;
			}else {
				isContent = 2;
			}
		}
		return isContent;
	}
}
