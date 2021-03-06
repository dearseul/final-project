package pms.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import pms.dto.ProjectAdd;
import pms.dto.Task;
import pms.dto.pms_project;

@Repository
public interface GanttDao {
	public ArrayList<Task> getTask(pms_project project);
	public String getName(int pno);
	public int getPnoUsingName(String name);
	public void insertTask(Task task);
	public int getMaxPno();
	public void updateTask(Task task);
	public void deleteTask(HashMap<String,Integer> hm);
	public pms_project getProject(int project_no);
	public void uptProject(pms_project project);
	public ArrayList<ProjectAdd> getProjectAdd(int project_no);
}
