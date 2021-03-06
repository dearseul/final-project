package pms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pms.dao.MypageDao;
import pms.dto.Member;
import pms.service.MypageService;

@Controller
public class ChattingController {
	@Autowired(required=false)
	private MypageService service;
	@Autowired(required = false)
	private MypageDao dao;
	
	// http://localhost:7080/pms/chatting.do
		// 192.168.0.47:7080
		@RequestMapping("chatting.do")
		public String chatting(HttpSession session, @RequestParam("no") int no, Model d) {
			System.out.println(no);
			Member m = (Member)session.getAttribute("mem");
			d.addAttribute("no",no);
			
			System.out.println(m.getName()+m.getPno());
			return "chatting";
		}
		@ModelAttribute("showprofile")  // 멤버 프로필 사진 공통 어트리뷰트  
		public Member showMember(HttpSession session){
			Member m = (Member)session.getAttribute("mem");
			int pno=0;
			if(m!=null) pno = m.getPno();
			return service.showProfile(pno);
		}
		

}


