package pms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pms.dto.Member;
import pms.dto.RiskBoard;
import pms.dto.UptStatus;
import pms.service.MypageService;
import pms.service.RiskService;
import pms.service.TaskDetailService;

@Controller
@RequestMapping("risk.do")
public class RiskController {
   @Autowired(required = false)
   private RiskService service;
   
   @Autowired(required=false)
   private TaskDetailService service2; // 프로젝트명 불러오려고 추가했습니다
   @Autowired(required=false)
   private MypageService service3;
   
   
   // http://localhost:7080/pms/risk.do?method=riskBoard
   @RequestMapping(params="method=riskBoard")
   public String riskform(@RequestParam("no") int no,Model d) {
      d.addAttribute("risklist", service.rBoard(no));
      System.out.println(no+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      d.addAttribute("project",service2.getProject_name(no)); // 프로젝트명 불러오려고 추가했습니다
      return "riskBoard";
   }
   
   @RequestMapping(params="method=riskRequestwk")
   public String riskrequestwk(Model d,HttpSession session) {
      Member mem = (Member)session.getAttribute("mem");
      d.addAttribute("riskrequestwk",service.rBoard_requestwk(mem.getName()));
      return "risk_request_wk";
   }
   
   
   // http://localhost:7080/pms/risk.do?method=riskBoardAll
   @RequestMapping(params="method=riskBoardAll")
   public String riskform(Model d) {
      d.addAttribute("risklistAll", service.rBoardAll());
      return "riskBoardAll";
   }
   // http://localhost:7080/pms/risk.do?method=riskRequest
   @RequestMapping(params="method=riskRequest")
   public String riskrequest(@RequestParam("no") int no,Model d) {
      d.addAttribute("requestlist",service.rBoard_request(no));
      d.addAttribute("project",service2.getProject_name(no)); 
      return"risk_request";      
   }
   // http://localhost:7080/pms/risk.do?method=riskDetail
   @RequestMapping(params="method=riskDetail")
   public String riskdetail(@RequestParam("no") int no,@RequestParam("risk_no") int risk_no, Model d) {
      System.out.println("리스크넘버:"+risk_no);
      d.addAttribute("riskboard",service.getBoard(risk_no));
      return"risk_detail";
   }
   
   // http://localhost:7080/pms/risk.do?method=riskBoardCreate
   @RequestMapping(params="method=riskBoardCreate")
   public String riskformCreate(@RequestParam("no") int no,@ModelAttribute("riskboard") RiskBoard b) {
      return"riskBoardCreate";      
   }
   // http://localhost:7080/pms/risk.do?method=insert
   @RequestMapping(params = "method=insert")
   public String insertBoard(@RequestParam("no") int no,RiskBoard insert, Model d) {
      service.insertBoard(no, insert);
      d.addAttribute("proc","insert");
      d.addAttribute("risklist",service.rBoard(no));
      d.addAttribute("project",service2.getProject_name(no)); // 프로젝트명 불러오려고 추가했습니다
      return "riskBoard";
   }
   
   // http://localhost:7080/pms/risk.do?method=uptStatus
   @RequestMapping(params = "method=uptStatus")
   public String uptStatus (@RequestParam("no") int no, @RequestParam("risk_no") int risk_no, Model d) {
      System.out.println("test:"+risk_no);
      UptStatus upt_satus = new UptStatus("승인", risk_no);
      
      service.uptStatus(upt_satus);
      d.addAttribute("uptFinish", "Y");
      return "forward:risk.do?method=riskDetail";      // 요청값을 갖고 리스크 디테일 컨트롤러로 이동.
   }
   
   
   // http://localhost:7080/pms/risk.do?method=download
   // 화면단에 클릭시, 
   // http://localhost:7080/board/risk.do?method=download&filename=파일명
   @RequestMapping(params="method=download")
   public String download(@RequestParam("no") int no, @RequestParam("filename") String filename, Model d) {
      System.out.println("파일명 : "+filename);
      d.addAttribute("downloadFile", filename);
      // viewer안에 선언한 모델명 - 파일다운로드뷰어에 같은 이름을 사용해준다.
      // 컨테이너 안에 있는 viewer명.
      return"downloadviewerrisk";
   }
   // http://localhost:7080/pms/risk.do?method=insForm
   @RequestMapping(params = "method=insForm")
   public String insForm(@RequestParam("no") int no, @ModelAttribute("riskboard") RiskBoard b, Model d) {
      d.addAttribute("reply","Y");
      System.out.println("project_no: " + no);
      System.out.println("risk_no: " + b.getRisk_no());
      System.out.println("risk_category: " + b.getRisk_category());
      System.out.println("regdte: " + b.getRegdte());
      System.out.println("status: " + b.getRisk_status());
      System.out.println("content: " +b.getRisk_content());
      System.out.println("writer: " + b.getRisk_writer());
      System.out.println("risktitle: " + b.getRisk_title());
      System.out.println("parentno: " + b.getRisk_parent_no());
      return "riskBoardCreate";
   }
   // http://localhost:7080/pms/risk.do?method=uptForm
   @RequestMapping(params = "method=uptForm")
   public String uptForm(@RequestParam("no") int no, @ModelAttribute("riskboard") RiskBoard b, Model d) {
      System.out.println(b.getRisk_no());
      System.out.println(b.getFileInfo());
      System.out.println(b.getFnames());
      System.out.println(b.getRisk_content());
      d.addAttribute("update","Y");
      d.addAttribute("riskboard",service.getBoard(b.getRisk_no()));

      return "riskBoardCreate";
   }
   // http://localhost:7080/pms/risk.do?method=update
   // http://localhost:7080/pms/risk.do?method=riskRequestwk
   @RequestMapping(params="method=update")
   public String update(@RequestParam("no") int no,@ModelAttribute("riskboard") RiskBoard upt, Model d) {
      System.out.println(upt.getRisk_title());
      System.out.println(upt.getRisk_content());
      System.out.println(upt.getFnames());
      System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+upt.getRisk_no());
      d.addAttribute("proc","update");
      service.updateRisk(upt);
      return "redirect:risk.do?method=riskRequestwk&no="+no;
   }
   
   
   // http://localhost:7080/pms/risk.do?method=delete
   @RequestMapping(params="method=delete")
   public String deleteRisk(@RequestParam("no") int no, @RequestParam("risk_no") int risk_no, Model d) {
      System.out.println(risk_no+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      d.addAttribute("proc","delete");
      service.deleteRisk(risk_no);
      return "riskBoard";
   }
   
   // http://localhost:7080/pms/risk.do?method=deleteNA
   @RequestMapping(params="method=deleteNA")
   public String deleteRiskNA(@RequestParam("no") int no, @RequestParam("risk_no") int risk_no, Model d) {
	   System.out.println(risk_no+"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
	   d.addAttribute("proc","delete");
	   service.deleteRisk(risk_no);
	   return "redirect:risk.do?method=riskRequest&no="+no;
   }
   
   @ModelAttribute("showprofile")  // 멤버 프로필 사진 공통 어트리뷰트  
   public Member showMember(HttpSession session){
      Member m = (Member)session.getAttribute("mem");
      int pno=0;
      if(m!=null) pno = m.getPno();
      return service3.showProfile(pno);
   }
   
   
}