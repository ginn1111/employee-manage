package ptithcm.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.bean.DateShift;
import ptithcm.bean.DateShiftArray;
import ptithcm.entity.Salary;
import ptithcm.entity.UpTasks;
import ptithcm.entity.Work;
import ptithcm.entity.tmp.EmpCooperateWithLeader;
import ptithcm.entity.tmp.EvaluateTmp;
import ptithcm.entity.tmp.JobForLeader;
import ptithcm.entity.tmp.StatusOfShift;
import ptithcm.utils.MyUtils;

@Controller
@RequestMapping("leader")
@Transactional
@SuppressWarnings("unchecked")
public class LeaderController {
	private static String ID_LEADER;
	private static List<Object> dateOfShiftNow = new ArrayList<Object>();
	private static List<Object> dateOfShift = new ArrayList<Object>();
	private static Integer idUpTask;
	private static String message;
	private static List<Work> listEmpOfWork;
	private static String route;
	private List<EmpCooperateWithLeader> listEmpCooperateWithLeader;
	
	@Autowired
	SessionFactory ssFac;
	
	@InitBinder
    public void customizeBinding (WebDataBinder binder) {
        MyUtils.DF_DATE.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(MyUtils.DF_DATE, false));
    }
	
	// GET index
	@RequestMapping("index")
	public String index(ModelMap model, Principal principal) {
		ID_LEADER = principal.getName();
		
		List<JobForLeader> jobForLeaders = EmployeeMethod.getJobForLeaderFromDatabase(ssFac, ID_LEADER, false);
		
		List<StatusOfShift> shiftStatus = EmployeeMethod.getStatusOfShiftFromDatabase(ssFac, ID_LEADER);
		
		List<Object> timeTableAndDaShiftArray = EmployeeMethod.statusOfShiftGroupByDateAndShift(shiftStatus);
		List<ArrayList<ArrayList<StatusOfShift>>> timeTable = 
				(List<ArrayList<ArrayList<StatusOfShift>>>) timeTableAndDaShiftArray.get(0);
		DateShiftArray dateShiftArray = 
				new DateShiftArray((List<ArrayList<ArrayList<DateShift>>>) timeTableAndDaShiftArray.get(1));
		dateOfShift = (List<Object>) timeTableAndDaShiftArray.get(2);
		
		List<Object> jobForLeaderAndDateNow = EmployeeMethod.jobForLeaderGroupByDateAndShift(jobForLeaders);
		List<Object> jobForLeaderArr = (List<Object>) jobForLeaderAndDateNow.get(0);
		dateOfShiftNow = (List<Object>) jobForLeaderAndDateNow.get(1);
		
		model.addAttribute("dateOfShiftNow", dateOfShiftNow);
		model.addAttribute("jobForLeaderArr", jobForLeaderArr);
		model.addAttribute("listEmpCooperateWithLeader", listEmpCooperateWithLeader);
		model.addAttribute("work", new Work());
		model.addAttribute("message", message);
		model.addAttribute("listEmpOfWork", listEmpOfWork);
		model.addAttribute("timeTable", timeTable);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("dateShiftArray", dateShiftArray);
		
		message = "";
		
		return "leader/index";
	}
	
	// GET tasks
	@RequestMapping("tasks")
	public String tasks(ModelMap model) {
		
		List<JobForLeader> jobForLeaders = EmployeeMethod.getJobForLeaderFromDatabase(ssFac, ID_LEADER, true);
		
		List<Object> jobForLeaderAndDateNow = EmployeeMethod.jobForLeaderGroupByDateAndShift(jobForLeaders);
		List<Object> jobForLeaderArr = (List<Object>) jobForLeaderAndDateNow.get(0);
		List<ArrayList<Object>> jobForLeaderArray = EmployeeMethod.groupByWeek(jobForLeaderArr);
		
		model.addAttribute("jobForLeaderArray", jobForLeaderArray);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("message", message);
		model.addAttribute("listEmpOfWork", listEmpOfWork);
		model.addAttribute("work", new Work());
		model.addAttribute("listEmpCooperateWithLeader", listEmpCooperateWithLeader);
		
		message = "";
		return "leader/tasks";
	}
		
	// GET salary
	@RequestMapping("salary")
	public String salary(ModelMap model) {

		List<EvaluateTmp> evals = EmployeeMethod.getEvaluationFromDatabase(ssFac, ID_LEADER, true);

		List<Object> evaluationArray = EmployeeMethod.evaluationsGroupByDateAndShift(evals);
		List<ArrayList<Object>> evaluationArrayOfArray = EmployeeMethod.groupByWeek(evaluationArray);

		List<Salary> salaries = EmployeeMethod.getSalariesFromDatabase(ssFac, ID_LEADER);
		
		model.addAttribute("evaluationArray", evaluationArrayOfArray);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("salaries", salaries);
		
		return "leader/salary";
	}
	
	// GET delete-work
	@RequestMapping(value="delete-work/{id}")
	public String deleteWork(@PathVariable("id") Integer idWork) {
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		try {
			ss.delete(new Work(idWork));
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.close();
		}
		return "redirect:/leader/" + route + ".htm";
	}
	
	// GET get-emp-cooperate-with-leader
		@RequestMapping(value="get-emp-cooperate-with-leader")
	public String getEmpCooperateWithLeader(
					@RequestParam("date") Date date,
					@RequestParam("id-shift") Integer idShift,
					@RequestParam("id-uptask") Integer idUpTask,
					@RequestParam("route") String route
				) {
			
			LeaderController.idUpTask = idUpTask;
			
			UpTasks upTask = (UpTasks) ssFac.getCurrentSession().get(UpTasks.class, idUpTask);
			listEmpOfWork = (List<Work>) upTask.getWorks();
				
			listEmpCooperateWithLeader = EmployeeMethod
					.getEmpCooperateWithLeaderFromDatabase(ssFac, ID_LEADER, idShift, date, idUpTask);
			
			LeaderController.route = route;
				
			return "redirect:/leader/" + route + ".htm";
		}

	// POST insert-work
	@RequestMapping(value="insert-work", method=RequestMethod.POST)
	public String insertWork(@ModelAttribute("work") Work work) {
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		work.setUpTasks(new UpTasks(LeaderController.idUpTask));
		
		try {
			ss.save(work);
			t.commit();
		} catch (Exception ex) {
			message = "Each employee only added once!";
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.close();
		}
		return "redirect:/leader/" + route + ".htm";
	}
	
	// POST register-shift
	@RequestMapping(value = "register-shift", method = RequestMethod.POST)
	public String registerShift(@ModelAttribute("dateShiftArray") DateShiftArray dateShiftArray) {
		EmployeeMethod.registerTimeTable(dateShiftArray, ID_LEADER, ssFac);
		return "redirect:/leader/index.htm";
	}
}