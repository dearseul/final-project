package pms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import pms.dto.pms_project;
import pms.service.DashboardService;
import pms.service.ProjectService;
import pms.service.TaskDetailService;

@Controller
@RequestMapping("dashboard.do")
public class DashBoardController {
	@Autowired(required=false)
	private DashboardService service;
	@Autowired(required=false)
	private ProjectService pservice;
	@Autowired(required=false)
	private TaskDetailService service2; // 프로젝트명 불러오려고 추가했습니다
	
	// http://localhost:7080/pms/dashboard.do?method=list
	@RequestMapping(params="method=list")
	public String gantt(@RequestParam("no") int no, Model d) {
		d.addAttribute("no", no);
		
		pms_project project = pservice.getProject(no);

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		try {
			Date start = df.parse(project.getStart1());	// 시작일(4.1)
			Date end = df.parse(project.getEnd1());		// 완료일(4.30)
			Date today = new Date();					// 현재날짜(4.22)
			// 진행도
			long startday = Math.abs( start.getTime() / (24*60*60*1000) ); // 시작일수(숫자값)
			long endday = Math.abs( end.getTime() / (24*60*60*1000) ); // 종료일수(숫자값)
			long todayday = Math.abs( today.getTime() / (24*60*60*1000) ); // 현재일수(숫자값)
			long allday = endday - startday;			// 분모:프로젝트총숫자
			// 진행숫자(현재-시작= 진행수)
			long doday = todayday - startday;			// 분자:프로젝트진행일
			if(todayday>endday) {	// 만약 오늘날짜가 종료일보다 크다면
				doday = endday - startday;
			}
			
			project.setAllday(allday);
			project.setDoday(doday);
			
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		d.addAttribute("project",project); // 프로젝트명 불러오려고 추가했습니다 // 프로젝트정보
		
		
		
		d.addAttribute("task",service.getTaskNum(no));
		d.addAttribute("risk",service.getRiskNum(no));
		d.addAttribute("member",service.getMemcnt(no));
		return "dashboard";
	}
	
}
