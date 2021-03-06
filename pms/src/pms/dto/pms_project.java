package pms.dto;
/*
create table pms_project(			-- 오버뷰, PM의 프로젝트 생성
		project_no number,				// 프로젝트번호
        project_name varchar2(100),		// 프로젝트명
        project_content varchar2(500),	// 프로젝트내용
        start1 varchar2(200),			// 시작일
        end1 varchar2(200),				// 종료일
        pm_pno number,					// pm번호
        project_status varchar2(50)		// 프로젝트 상태
); 
*/
public class pms_project {
	private int project_no;
	private String project_name;
	private String project_content;
	private String start1;
	private String end1;
	private int pm_pno;
	private String project_status;
	private int pno;		// 멤버번호로 프로젝트 검색시 사용
	private String id;		// 추가_오버뷰화면
	private String name;	// 추가_오버뷰화면
	private int taskcount;	// 추가_오버뷰화면
	private long allday;	// 추가_대시_총기간
	private long doday;		// 추가_대시_진행기간
	
	
	private String pm_name;
	
	public pms_project(int project_no, String project_name, String project_content, String start1, String end1,
			int pm_pno, String project_status) {
		super();
		this.project_no = project_no;
		this.project_name = project_name;
		this.project_content = project_content;
		this.start1 = start1;
		this.end1 = end1;
		this.pm_pno = pm_pno;
		this.project_status = project_status;
	}
	public pms_project() {
		super();
		// TODO Auto-generated constructor stub
	}
	public pms_project(String project_name) {
		super();
		this.project_name = project_name;
	}
	
	public pms_project(int project_no) {
		super();
		this.project_no = project_no;
	}
	public int getProject_no() {
		return project_no;
	}
	public void setProject_no(int project_no) {
		this.project_no = project_no;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getProject_content() {
		return project_content;
	}
	public void setProject_content(String project_content) {
		this.project_content = project_content;
	}
	public String getStart1() {
		return start1;
	}
	public void setStart1(String start1) {
		this.start1 = start1;
	}
	public String getEnd1() {
		return end1;
	}
	public void setEnd1(String end1) {
		this.end1 = end1;
	}
	public int getPm_pno() {
		return pm_pno;
	}
	public void setPm_pno(int pm_pno) {
		this.pm_pno = pm_pno;
	}
	public String getProject_status() {
		return project_status;
	}
	public void setProject_status(String project_status) {
		this.project_status = project_status;
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTaskcount() {
		return taskcount;
	}
	public void setTaskcount(int taskcount) {
		this.taskcount = taskcount;
	}
	public long getAllday() {
		return allday;
	}
	public void setAllday(long allday) {
		this.allday = allday;
	}
	public long getDoday() {
		return doday;
	}
	public void setDoday(long doday) {
		this.doday = doday;
	}
	public String getPm_name() {
		return pm_name;
	}
	public void setPm_name(String pm_name) {
		this.pm_name = pm_name;
	}
	
}
