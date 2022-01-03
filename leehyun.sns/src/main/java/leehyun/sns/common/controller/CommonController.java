package leehyun.sns.common.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import leehyun.sns.common.domain.Notice;
import leehyun.sns.common.service.CommonService;

@Controller
@RequestMapping
public class CommonController {
	@Value("${attachDir}")
	private String attachDir;
	@Autowired private CommonService commonService;
	
	@ResponseBody
	@RequestMapping(value="/notice")
	public List<Notice> notice(HttpSession session) {
		int userNum = (int)session.getAttribute("userNum");
		return commonService.getNotice(userNum);
	}
	
	@RequestMapping("/admin/common/logo")
	public String logo() {
		return "admin/common/logo";
	}
	
	@RequestMapping("/admin/common/baseImg")
	public String baseImg() {
		return "admin/common/baseImg";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/common/baseImg", method = RequestMethod.POST)
	public boolean baseImg(MultipartFile attachFile, HttpServletRequest request) {
		boolean stored = true;
		String dir = request.getServletContext().getRealPath(attachDir);
		try{
			save(dir + "/profile.jpg", attachFile);
		}catch(IOException e){
			stored = false;
		}
		return stored;
	}

	@ResponseBody
	@RequestMapping(value="/admin/common/logo", method = RequestMethod.POST)
	public boolean logo(MultipartFile attachFile, HttpServletRequest request) {
		boolean stored = true;
		String dir = request.getServletContext().getRealPath(attachDir);
		try{
			save(dir + "/common/logo", attachFile);
		}catch(IOException e){
			stored = false;
		}
		return stored;
	}

	private void save(String saveFile, MultipartFile attachFile) throws IOException {
		attachFile.transferTo(new File(saveFile));
	}
}