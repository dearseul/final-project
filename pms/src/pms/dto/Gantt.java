package pms.dto;

public class Gantt {
	private int id;
	private String start_date;
	private String end_date;
	private String title;
	private String text;
	private int priority;
	private float progress;
	private int sortorder;
	private int parent;
	private String holder;
	private String status;
	
	public Gantt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Gantt(int id, String start_date, String end_date, String title, String text, int priority, float progress,
			int sortorder, int parent, String holder, String status) {
		super();
		this.id = id;
		this.start_date = start_date;
		this.end_date = end_date;
		this.title = title;
		this.text = text;
		this.priority = priority;
		this.progress = progress;
		this.sortorder = sortorder;
		this.parent = parent;
		this.holder = holder;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public float getProgress() {
		return progress;
	}

	public void setProgress(float progress) {
		this.progress = progress;
	}

	public int getSortorder() {
		return sortorder;
	}

	public void setSortorder(int sortorder) {
		this.sortorder = sortorder;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public String getHolder() {
		return holder;
	}

	public void setHolder(String holder) {
		this.holder = holder;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}