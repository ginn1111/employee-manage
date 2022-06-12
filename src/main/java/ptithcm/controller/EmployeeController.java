package ptithcm.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ptithcm.bean.DateShift;
import ptithcm.bean.DateShiftArray;
import ptithcm.entity.Salary;
import ptithcm.entity.tmp.EvaluateTmp;
import ptithcm.entity.tmp.JobOfShift;
import ptithcm.entity.tmp.StatusOfShift;
import ptithcm.utils.MyUtils;

@Controller
@RequestMapping("employee")
@Transactional
@SuppressWarnings("unchecked")
public class EmployeeController {
	
	protected static String ID_EMP;
	private List<Object> dateOfShiftNow = new ArrayList<Object>();
	private List<Object> dateOfShift = new ArrayList<Object>();
	
	@Autowired
	SessionFactory ssFac;

	@InitBinder
	public void customizeBinding(WebDataBinder binder) {
		MyUtils.DF_DATE.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(MyUtils.DF_DATE, false));
	}

	// GET index
	@RequestMapping("index")
	public String index(ModelMap model, Principal principal) {
		ID_EMP = principal.getName();
		
		List<StatusOfShift> shiftStatus = EmployeeMethod.getStatusOfShiftFromDatabase(ssFac, ID_EMP);

		List<Object> timeTableAndDateShiftArray = EmployeeMethod.statusOfShiftGroupByDateAndShift(shiftStatus);
		List<ArrayList<ArrayList<StatusOfShift>>> timeTable = 
				(List<ArrayList<ArrayList<StatusOfShift>>>) timeTableAndDateShiftArray.get(0);
		DateShiftArray dateShiftArray = 
				new DateShiftArray((List<ArrayList<ArrayList<DateShift>>>) timeTableAndDateShiftArray.get(1));
		dateOfShift = (List<Object>) timeTableAndDateShiftArray.get(2);

		List<JobOfShift> jobOfShifts = EmployeeMethod.getJobOfShiftFromDatabase(ssFac, ID_EMP, false);

		List<Object> jobOfShiftAndDateOfShiftNow =  EmployeeMethod.jobOfShiftGroupByDateAndShift(jobOfShifts);
		List<Object> jobOfShiftArray = (List<Object>) jobOfShiftAndDateOfShiftNow.get(0);
		dateOfShiftNow = (List<Object>) jobOfShiftAndDateOfShiftNow.get(1);
		
		model.addAttribute("dateOfShiftNow", dateOfShiftNow);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("jobArray", jobOfShiftArray);
		model.addAttribute("timeTable", timeTable);
		model.addAttribute("dateShiftArray", dateShiftArray);
		return "employee/index";
	}

	// GET tasks
	@RequestMapping(value = "tasks")
	public String tasks(ModelMap model) {

		List<JobOfShift> jobOfShifts = EmployeeMethod.getJobOfShiftFromDatabase(ssFac, ID_EMP, true);
		
		List<Object> jobOfShiftAndDateOfShiftNow =  EmployeeMethod.jobOfShiftGroupByDateAndShift(jobOfShifts);
		List<Object> jobOfShiftArray = (List<Object>) jobOfShiftAndDateOfShiftNow.get(0);
		List<ArrayList<Object>> allJobFmt = EmployeeMethod.groupByWeek(jobOfShiftArray);

		List<EvaluateTmp> evaluations = EmployeeMethod.getEvaluationFromDatabase(ssFac, ID_EMP, false);
		List<Object> evaluationArr = EmployeeMethod.evaluationsGroupByDateAndShift(evaluations);

		model.addAttribute("jobArray", allJobFmt);
		model.addAttribute("dateOfShiftNow", dateOfShiftNow);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("evaluationArray", evaluationArr);
		return "employee/tasks";
	}

	// GET salary
	@RequestMapping("salary")
	public String salary(ModelMap model) {

		List<EvaluateTmp> evaluations = EmployeeMethod.getEvaluationFromDatabase(ssFac, ID_EMP, true);
		List<Object> evaluationArray = EmployeeMethod.evaluationsGroupByDateAndShift(evaluations);
		List<ArrayList<Object>> evaluationArrayOfArray = EmployeeMethod.groupByWeek(evaluationArray);

		List<Salary> salaries = EmployeeMethod.getSalariesFromDatabase(ssFac, ID_EMP);

		model.addAttribute("evaluationArray", evaluationArrayOfArray);
		model.addAttribute("dateOfShift", dateOfShift);
		model.addAttribute("salaries", salaries);
		return "employee/salary";
	}

	// POST register-shift
	@RequestMapping(value = "register-shift", method = RequestMethod.POST)
	public String registerShift(@ModelAttribute("dateShiftArray") DateShiftArray dateShiftArray) {
		EmployeeMethod.registerTimeTable(dateShiftArray, ID_EMP, ssFac);
		return "redirect:/employee/index.htm";
	}
}
