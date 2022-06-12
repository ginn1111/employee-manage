package ptithcm.controller;

import java.awt.PageAttributes.MediaType;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.codehaus.jackson.map.ObjectWriter;
import org.hibernate.HibernateException;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.io.UTF8Writer;
import com.fasterxml.jackson.databind.ObjectMapper;

import ptithcm.bean.ChangeEmp;
import ptithcm.bean.DateForNewTimeTable;
import ptithcm.bean.DateShiftForUpTask;
import ptithcm.bean.EvaluationEmp;
import ptithcm.bean.Gender;
import ptithcm.bean.ListChangeEmp;
import ptithcm.bean.ListEmpDelete;
import ptithcm.bean.ListEvaluationEmp;
import ptithcm.bean.ListFaultDelete;
import ptithcm.bean.ListPositionDelete;
import ptithcm.bean.ListShiftDelete;
import ptithcm.bean.ListTaskDelete;
import ptithcm.bean.ListUpTaskDelete;
import ptithcm.bean.Month;
import ptithcm.bean.MonthYear;
import ptithcm.entity.Account;
import ptithcm.entity.Constants;
import ptithcm.entity.Employee;
import ptithcm.entity.Evaluate;
import ptithcm.entity.Fault;
import ptithcm.entity.NumOfShiftOfPartTimeEmp;
import ptithcm.entity.Position;
import ptithcm.entity.Role;
import ptithcm.entity.Salary;
import ptithcm.entity.Shift;
import ptithcm.entity.Task;
import ptithcm.entity.TimeTable;
import ptithcm.entity.UpTasks;
import ptithcm.entity.tmp.JobOfEmpToManager;
import ptithcm.entity.tmp.LackOfEmployee;
import ptithcm.entity.tmp.StatistEvaluationOfEmp;
import ptithcm.entity.tmp.StatistNumOfShift;
import ptithcm.entity.tmp.Year;
import ptithcm.utils.ListEmployee;
import ptithcm.utils.MyUtils;

@Controller
@RequestMapping("manager")
@SuppressWarnings("unchecked")
@Transactional
public class ManagerController {
	private static String ID_MANAGER;
	private static String filter;
	private static String message = "";
	// index
	private List<JobOfEmpToManager> jobOfEmpToManager;
	private static List<TimeTable> listJobOfEmp;
	private static DateForNewTimeTable dateForNewTimeTable = new DateForNewTimeTable();
	private static List<TimeTable> timeTables;
	// manager
	private static String link;
	private static String btnTitle;
	private static Shift shift = new Shift();
	private static Position position = new Position();
	private static Fault fault = new Fault();
	private static Employee employee = new Employee();
	private static Task task = new Task();
	private static UpTasks tasksForShift = new UpTasks();
	private static DateShiftForUpTask dateShiftForUpTask;
	private int loadmoreCoefficient = 3;
	private int loadmore = loadmoreCoefficient;
	private List<Employee> employees = ListEmployee.getInstance();
	private boolean isShowLoadmore = true;
	private boolean isSearch = false;
	private String dataSearch;
	// report
	private static List<Salary> salaries;
	private static MonthYear monthYearForReport = new MonthYear();
	private static MonthYear monthYearForStatist = new MonthYear();
	private static Salary salary = new Salary();
	private static List<ArrayList<StatistNumOfShift>> statistNumOfShiftArray;
	private static Map<String, List<ArrayList<StatistEvaluationOfEmp>>> mapStatistEvaluationOfEmp;
	//Query
	private static String queryPosition = "FROM Position AS P WHERE P.deleted=false ORDER BY P.positionName";
	private static String queryFault = "FROM Fault AS F WHERE F.deleted=false ORDER BY F.percentOfSalary";
	private static String queryEmployee = "FROM Employee AS E WHERE E.active=true ORDER BY E.idEmployee DESC";
	private static String queryTask = "FROM Task AS T WHERE T.deleted=false ORDER BY T.job";
	private static String queryUpTasks = "FROM UpTasks AS UT WHERE UT.date=:date AND UT.idShift=:idShift";
	
	@Autowired
	SessionFactory ssFac;
	
	@InitBinder({"employee", "dateShiftForUpTask", "tasksForShift", "salary", "dateForNewTimeTable", "date-search"})
    public void customizeBinding (WebDataBinder binder) {
        MyUtils.DF_DATE.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(MyUtils.DF_DATE, false));
    }
	
	@InitBinder("shift")
	public void shiftCustomBinding (WebDataBinder binder) {
		MyUtils.DF_TIME.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(MyUtils.DF_TIME, false));
	}
	
	/********************************************************************************************************************
	 * 																													*
	 * 													INDEX															*
	 * 																													*
	 * ******************************************************************************************************************/
	// GET index
	@RequestMapping("index")
	public String index(ModelMap model, HttpServletRequest request, Principal principal) throws ParseException {
		ID_MANAGER = principal.getName();
		int idShiftNow = ManagerMethod.getIdShiftNow(request, ssFac);
		
		String dateFilter;
		
		if(filter == null) {
			timeTables = ManagerMethod.getTimeTableToManagerFromDatabase(ssFac);
			dateFilter = MyUtils.formatDate(MyUtils.DF_DATE, new Date());
			jobOfEmpToManager = ManagerMethod
					.getJobOfEmpToManagerFromDatabase(
								ssFac, new Date(), idShiftNow
							);
		} else {
			timeTables = ManagerMethod.getTimeTableToManagerFilterByDate(ssFac, filter);
			dateFilter = filter;
			filter = null;
		}
		
	
		
		List<TimeTable> listTimeTableNow = ManagerMethod.getTimeTableNowFromDatabase(ssFac, idShiftNow);
		
		List<ArrayList<TimeTable>> timeTableArray = ManagerMethod.timeTableGroupByDateAndShift(timeTables);
		List<ArrayList<JobOfEmpToManager>> jobOfEmpToManagerArray = ManagerMethod
				.jobOfEmpToManagerGroupByEmployee(jobOfEmpToManager);

		if (listJobOfEmp != null) {
			List<ChangeEmp> dummyListChangeEmp = new ArrayList<ChangeEmp>();
			List<EvaluationEmp> dummyListEvaluationEmp = new ArrayList<EvaluationEmp>();
			for (int i = 0; i < listJobOfEmp.size(); i++) {
				dummyListChangeEmp.add(new ChangeEmp());
				dummyListEvaluationEmp.add(new EvaluationEmp());
			}
				
			ListChangeEmp listChangeEmp = new ListChangeEmp();
			listChangeEmp.setListChangeEmp(dummyListChangeEmp);
			
			ListEvaluationEmp listEvaluationEmp = new ListEvaluationEmp();
			listEvaluationEmp.setList(dummyListEvaluationEmp);

			model.addAttribute("listJobOfEmp", listJobOfEmp);
			model.addAttribute("listChangeEmp", listChangeEmp);
			model.addAttribute("listEvaluationEmp", listEvaluationEmp);
		}
		
		model.addAttribute("message", message);
		model.addAttribute("listTimeTableNow", listTimeTableNow);
		model.addAttribute("timeTableArray", timeTableArray);
		model.addAttribute("jobOfEmpToMangerArray", jobOfEmpToManagerArray);
		model.addAttribute("dateForNewTimeTable", dateForNewTimeTable);
		model.addAttribute("dateFilter", dateFilter);
		
		message = "";
		
		return "manager/index";
	}

	// GET getjob
	@RequestMapping("getjob")
	public String getJobViaDateAndShift(
			@RequestParam("id_shift") int idShift,
			@RequestParam("date") String date
		) throws Exception {
		
		jobOfEmpToManager = ManagerMethod
				.getJobOfEmpToManagerFromDatabase(ssFac, MyUtils.DF_DATE.parse(date), idShift);
		filter = date;

		return "redirect:/manager/index.htm";
	}

	// POST change-emp
	@RequestMapping(value = "change-emp", method = RequestMethod.POST)
	public String changeEmp(@ModelAttribute("listChangeEmp") ListChangeEmp listChangeEmp,
			@RequestParam("date") String date, @RequestParam("id_shift") int idShift) {
		
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		filter = date;
		
		List<String> listIdEmp = listChangeEmp
					.getListChangeEmp()
					.stream()
					.map(e -> e.getIdEmp())
					.collect(Collectors.toList());
		
		List<String> listIdEmpAlter = listChangeEmp
					.getListChangeEmp().stream()
					.map(e -> e.getIdEmpAlter())
					.collect(Collectors.toList());
		
		try {
			TimeTable tt;
			Integer indexOfListEmp;
			
			for(int i = 0; i < listIdEmpAlter.size(); i++) {
				if(listIdEmpAlter.get(i) != null) {
					tt = (TimeTable) ssFac.getCurrentSession().get(TimeTable.class, 
								listChangeEmp.getListChangeEmp().get(i).getId()
							);
					indexOfListEmp = listIdEmp.indexOf(listIdEmpAlter.get(i));
//					Trường hợp nhân viên được thay thế nhưng muốn thay thế lại nhân viên cũ
					if(tt.getEmployeeAlter() != null && indexOfListEmp >= 0 && indexOfListEmp != i ||
							listIdEmp.contains(listIdEmpAlter.get(i)) && tt.getEmployeeAlter() == null ) {
						message = "Can not update, because Employee already exists!";
						throw new Exception("Error");
					}
				}
			}
			
			for(int i = 0; i < listIdEmpAlter.size() - 1 
						&& message.length() == 0 
						&& listIdEmpAlter.get(i) != null 
						&& !listIdEmpAlter.get(i).isBlank()
					; i++) {
				for(int j = 0; j < listIdEmpAlter.size() && listIdEmpAlter.get(i) != null && i != j; j++) {
					if(listIdEmpAlter.get(i).equals(listIdEmpAlter.get(j))) {
						message = "Can not update, because there are the same of two Employee!";
						throw new Exception("Error");
					}
				}
			}
			ChangeEmp tmp;
//			Employee tmpEmp;
//			List<TimeTable> tmpTimeTables;
//			boolean isWorks;
			
			for(int i = 0; i < listChangeEmp.getListChangeEmp().size(); i++) {
				tmp = listChangeEmp.getListChangeEmp().get(i);
				if(tmp.getIdEmpAlter() == null || tmp.getIdEmpAlter().isBlank()) {
					continue;
				}
				
//				tmpEmp = (Employee) ssFac.getCurrentSession().get(Employee.class, tmp.getIdEmp());
				
//				if(tmpEmp.getPosition().getIsFullTime()) {
//					tmpTimeTables = ManagerMethod.getTimeTableFromDatabase(ssFac, date, tmp.getIdEmp());
//					
//					isWorks = tmpTimeTables
//							.stream()
//							.map(e -> e.getWorks().size())
//							.collect(Collectors.toList())
//							.stream()
//							.reduce(0,(c,e) -> e + c ) > 0 ? true : false;
//							
//					if(isWorks) {
//						message = "Employee have works on another shift of this date!";
//						throw new Exception("Have work");
//					}
//					
//					for(var timeTable : tmpTimeTables) {
//						timeTable.setEmployeeAlter(new Employee(tmp.getIdEmpAlter()));
//					}
//				} else {
					ss.update (
						new TimeTable (
								tmp.getId(), 
								new Employee(tmp.getIdEmp()), 
								new Shift(idShift), 
								MyUtils.DF_DATE.parse(date), 
								new Employee(tmp.getIdEmpAlter())
							)
						);
//				}
			}
			
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.close();
		}
		return "redirect:/manager/index.htm";
	}

	// GET change-emp
	@RequestMapping(value = "change-emp", method = RequestMethod.GET)
	public String changeEmp(
			HttpSession session,
			@RequestParam("date") String date, 
			@RequestParam("id_shift") int idShift
		) throws Exception {

		Shift shift = (Shift) ssFac.getCurrentSession().get(Shift.class, idShift);
		
		session.setAttribute("date", MyUtils.DF_DATE.parse(date));
		session.setAttribute("shift", shift.getName());
		
		listJobOfEmp = ManagerMethod.getTimeTableFromDatabase(ssFac, date, idShift);
		
		filter = date;

		return "redirect:/manager/index.htm";
	}
	
	// POST evaluation
	@RequestMapping(value="evaluation", method=RequestMethod.POST)
	public String evaluation(
				@RequestParam("date") String date,
				@RequestParam("id_shift") int idShift,
				@ModelAttribute("listEvaluationEmp") ListEvaluationEmp listEvaluationEmp
			) throws Exception {
		
		filter = date;
		
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		List<Evaluate> evaluates;
		Evaluate evaTmp;
		try {
			for(var i : listEvaluationEmp.getList()) {
				if(i.getIdFault() == null) continue;
				evaluates = ManagerMethod.getEvaluationFromDatabase(ssFac, i.getIdFault(), i.getIdTimeTable());
					
				if(evaluates.size() > 0) {
					evaTmp = evaluates.get(0);
					if(i.getNum() == 0) {
						ss.delete(new Evaluate(evaTmp.getIdEvaluate()));
						message = "Delete evaluation successful!";
					}
					else if(evaTmp.getNum() != i.getNum()) {
						ss.update(
								new Evaluate(
									evaTmp.getIdEvaluate(), 
									ID_MANAGER, 
									evaTmp.getFault(), 
									evaTmp.getTimeTable(), 
									i.getNum()
								)
							);
						message = "Update evaluation successful!";
					}
					
				} else {
					if(i.getNum() == 0) {
						message = "Delete failed, employee has not been evaluated yet!";
					} else {
						ss.save(new Evaluate(ID_MANAGER, new Fault(i.getIdFault()), new TimeTable(i.getIdTimeTable()), i.getNum()));
						message = "Add evaluation successful!";
					}
				}
			}
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.close();
		}
		
		return "redirect:/manager/index.htm";
	}

	// GET search
	@RequestMapping("/index/search")
	public String search(@RequestParam("date-search") Date date) {
		filter = MyUtils.formatDate(MyUtils.DF_DATE, date);
		return "redirect:/manager/index.htm";
	}
	
	// POST new-timetable
	@RequestMapping(value="index/new-timetable", method=RequestMethod.POST)
	public String newTimeTable(@ModelAttribute("dateForNewTimeTable") DateForNewTimeTable dateForTimeTable) {
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		try {
			ss.save(new Constants(dateForTimeTable.getDate()));
			message = "Add new date for time table successful!";
			t.commit();
		} catch (Exception ex) {
			message = "Add new date for time table failed!";
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.clear();
		}
		ManagerMethod.insertTimeTableForFullTimeEmp(ssFac, dateForTimeTable.getDate());
		
		return "redirect:/manager/index.htm";
	}

	// GET num-of-shift-of-pt-emp
	@RequestMapping(value="num-of-shift-of-pt-emp",headers= "Accept=*/*;charset=utf-8", produces = { "application/json; charset=utf-8" },
				method=RequestMethod.GET)
	@ResponseBody()
	public String getNumOfShiftOfPartTimeEmp() throws JsonProcessingException {
		List<NumOfShiftOfPartTimeEmp> res = ssFac.getCurrentSession().getNamedQuery("getNumOfShiftOfPartTimeEmp")
				.list();
		com.fasterxml.jackson.databind.ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
		String json = new String(ow.writeValueAsBytes(res), StandardCharsets.ISO_8859_1);
		return json;
	}
	
/************************************************************************************************************************
 * 																														*
 * 													MANAGE																*
 * 																														*
 * **********************************************************************************************************************/
	// GET manage
	@RequestMapping("manage")
	public String manage(ModelMap model) throws HibernateException, ParseException {
	
		List<Shift> shifts = ManagerMethod.getShiftsFromDatabase(ssFac);
		
		List<Object> initPositionDel = ManagerMethod.initListPositionDelete(ssFac, queryPosition);
		List<Object> initFaultDel = ManagerMethod.initListFaultDelete(ssFac, queryFault);
		
		ListShiftDelete listShiftDel = ManagerMethod.initListShiftDelete(shifts);
		
		List<Position> positions = (List<Position>) initPositionDel.get(0);
		ListPositionDelete listPositionDel = (ListPositionDelete) initPositionDel.get(1);
		
		List<Fault> faults = (List<Fault>) initFaultDel.get(0);
		ListFaultDelete listFaultDel = (ListFaultDelete) initFaultDel.get(1);
			
		model.addAttribute("listShiftDel", listShiftDel);
		model.addAttribute("positions", positions);
		model.addAttribute("listPositionDel", listPositionDel);
		model.addAttribute("faults", faults);
		model.addAttribute("listFaultDel", listFaultDel);
		model.addAttribute("allOfShift", shifts);
		
		model.addAttribute("message", message);
		model.addAttribute("link", link);
		model.addAttribute("btnTitle", btnTitle);
		model.addAttribute("shift", shift);
		model.addAttribute("position", position);
		model.addAttribute("fault", fault);
		
		message = "";
		
		return "manager/manage";
	}
	
	// -------------------------------------------------- MANAGE/SHIFTS -------------------------------------------------

	// POST manage/shifts?delete
	@RequestMapping(value="manage/shifts", method=RequestMethod.POST, params = "delete")
	public String shiftEdit(@ModelAttribute("listShiftDel") ListShiftDelete listShiftDel) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		
		Shift shiftTmp;
		try {
			for(var shiftDel : listShiftDel.getList()) {
				if(shiftDel == null) continue;
				shiftTmp = (Shift) session.get(Shift.class, shiftDel);
				if(shiftTmp.getTimeTables().size() > 0) {
					message = "Can't delete a shift " + shiftTmp.getName() + " already registered by an employee";
					throw new Exception("Deleted Shift Exception");
				} else {
					session.delete(shiftTmp);
				}
			}
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/shifts?insert
	@RequestMapping(value="manage/shifts", method=RequestMethod.POST, params = "insert")
	public String shiftInsert(
				@ModelAttribute("shift") Shift shift
			) throws Exception {
		String checkValidTime = ManagerMethod.checkValidateTime(ssFac, shift.getTimeStart(), shift.getTimeEnd(), shift.getIdShift());
		if (checkValidTime != null) {
			message = checkValidTime;
		} else if(shift.getName().trim().length() == 0) {
			message = "Entered name of shift please!";
		} else {
			Session session = ssFac.openSession();
			Transaction t = session.beginTransaction();	
			try {
				shift.setName(MyUtils.formatString(shift.getName()));
				session.save(shift);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
		
		return "redirect:/manager/manage.htm";
	}
	
	//GET manage/shifts/{id}
	@RequestMapping(value="manage/shifts/{id}")
	public String editShift(@PathVariable("id") Integer idShift) {
		
		shift = (Shift) ssFac.getCurrentSession().get(Shift.class, idShift);
		
		link = "manager/manage/shifts.htm?edit";
		btnTitle = "Update";
		
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/shifts?edit
	@RequestMapping(value="manage/shifts", method=RequestMethod.POST, params = "edit")
	public String editShift(@ModelAttribute("shift") Shift shift) {
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		String checkValidTime = ManagerMethod.checkValidateTime(ssFac, shift.getTimeStart(), shift.getTimeEnd(), shift.getIdShift());
		if (checkValidTime != null) {
			message = checkValidTime;
		} else {
			try {
				shift.setName(MyUtils.formatString(shift.getName()));
				ss.update(shift);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				ss.close();
			}
		}
		return "redirect:/manager/manage.htm";
	}
	
	//GET manage/shifts?new
	@RequestMapping(value="manage/shifts", params = "new")
	public String newShift() {
		shift = new Shift();
		link = "manager/manage/shifts.htm?insert";
		btnTitle = "Add";
		return "redirect:/manager/manage.htm";
	}
	
	// -------------------------------------------------- MANAGE/POSITIONS -------------------------------------------------
	
	//GET manage/positions?new
	@RequestMapping(value="manage/positions", params = "new")
	public String newPosition() {
		position = new Position();
		link="manager/manage/positions.htm?insert";
		btnTitle="Add";
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/positions?delete
	@RequestMapping(value="manage/positions", method=RequestMethod.POST, params="delete")
	public String positionsDelete(@ModelAttribute("listPositionDel") ListPositionDelete listPositionDel) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		Position posTmp;
		try {
			for(var positionDel : listPositionDel.getList()) {
				if(positionDel == null) continue;
				posTmp = (Position) session.get(Position.class, positionDel);
				if(posTmp.getEmployees().size() > 0) {
					message = "This position " + posTmp.getPositionName() +" is currently occupied by employee, cannot be deleted";
					throw new Exception("Deleted Position Exception");
				} else {
					session.delete(posTmp);
				}
			}
			t.commit();
		} catch (Exception ex) {
			
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/manage.htm";
	}
	
	//GET manage/positions/{id}
	@RequestMapping(value="manage/positions/{id}")
	public String editPosition(@PathVariable("id") int idPosition) {
		position = (Position) ssFac.getCurrentSession().get(Position.class, idPosition);
		link="manager/manage/positions.htm?edit";
		btnTitle="Update";
		return "redirect:/manager/manage.htm";
	}
	
	//POST manager/positions?edit
	@RequestMapping(value="manage/positions", method=RequestMethod.POST, params="edit")
	public String editPosition(@ModelAttribute("position") Position position) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		// set attribute and format
		position.setAttribute();
		try {
			session.update(position);
			
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/positions?insert
	@RequestMapping(value="manage/positions", method=RequestMethod.POST, params="insert")
	public String insertPosition(@ModelAttribute("position") Position position) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		if(position.getPositionName().trim().length() == 0) {
			message = "Entered name of position please!";
			return "redirect:/manager/manage.htm";
		} 
		List<Position> positions = ssFac.getCurrentSession()
				.createQuery("FROM Position P where P.positionName=:name AND P.isFullTime=:fulltime")
				.setParameter("name", position.getPositionName())
				.setParameter("fulltime", position.getIsFullTime())
				.list();
		System.out.println(positions.size());
		if(positions.size() != 0) {
			message = "Add failed, because this position is existed!";
		} else {
			// set attribute and format
			position.setAttribute();
			try {
				session.save(position);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
	
		return "redirect:/manager/manage.htm";
	}

	// -------------------------------------------------- MANAGE/FAULTS -------------------------------------------------
	
	//GET manage/faults?new
		@RequestMapping(value="manage/faults", params = "new")
	public String newFault() {
		fault = new Fault();
		link="manager/manage/faults.htm?insert";
		btnTitle="Add";
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/faults?delete
	@RequestMapping(value="manage/faults", method=RequestMethod.POST, params="delete")
	public String faultDelete(@ModelAttribute("listFaultDel") ListFaultDelete listFaultDel) {
		
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		Fault faultTmp;
		try {
			for(var faultDel : listFaultDel.getList()) {
				if(faultDel == null) continue;
				faultTmp = (Fault) session.get(Fault.class, faultDel);
				if(faultTmp.getEvaluates().size() > 0) {
					message = "This fault " + faultTmp.getDescription() + " is being used to calculate salary, cannot be deleted";
					throw new Exception("Deleted Fault Exception");
				} else {
					session.delete(faultTmp);
				}
			}
			t.commit();
		} catch (Exception ex) {
			
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/manage.htm";
	}
	
	//GET manage/faults/{id}
	@RequestMapping(value="manage/faults/{id}")
	public String editFault(@PathVariable("id") int idFault) {
		fault = (Fault) ssFac.getCurrentSession().get(Fault.class, idFault);
		link="manager/manage/faults.htm?edit";
		btnTitle="Update";
		return "redirect:/manager/manage.htm";
	}
	
	//POST manager/faults?edit
	@RequestMapping(value="manage/faults", method=RequestMethod.POST, params="edit")
	public String editFault(@ModelAttribute("fault") Fault fault) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		try {
			session.update(fault);
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/manage.htm";
	}
	
	//POST manage/faults?insert
	@RequestMapping(value="manage/faults", method=RequestMethod.POST, params="insert")
	public String insertFault(@ModelAttribute("fault") Fault fault) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		if(fault.getDescription().trim().length() == 0) {
			message = "Entered description of fault please!";
		} else {
			try {
				session.save(fault);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
		
		return "redirect:/manager/manage.htm";
	}
	
	// -------------------------------------------------- MANAGE/EMPLOYEES -------------------------------------------------
	
	// GET /employees
	@RequestMapping(value="employees")
	public String employee(ModelMap model) {
		employees.clear();
		if(isSearch) {
			employees.addAll(ManagerMethod.searchEmployee(ssFac, dataSearch));
			isSearch = false;
		} else {
			employees.addAll(ManagerMethod.loadmoreEmployee(ssFac, 0, loadmore));
			if(loadmore > employees.size()) {
				loadmore = employees.size();
				isShowLoadmore = false;
			} else {
				isShowLoadmore = true;
			}
		}
		ListEmpDelete listEmpDel = ManagerMethod.initListEmplDelete(employees);

		model.addAttribute("employees", employees);
		model.addAttribute("listEmpDel", listEmpDel);
		model.addAttribute("message", message);
		model.addAttribute("employee", employee);
		model.addAttribute("link", link);
		model.addAttribute("btnTitle", btnTitle);
		model.addAttribute("isShow", isShowLoadmore);
		
		message = "";
		return "/manager/employees";
	}
	// GET manage/employees?load-more
	@RequestMapping(value="manage/employees/{n}", params="load-more")
	public String loadmoreEmployees(@PathVariable("n") int n) {
		loadmore = n + loadmoreCoefficient;
		return "redirect:/manager/employees.htm";
	}
	
	//GET manage/employees?new
	@RequestMapping(value="manage/employees", params = "new")
	public String newEmployee() {
		
		List<Employee> emps = ssFac.getCurrentSession()
				.createQuery("FROM Employee AS E ORDER BY E.idEmployee DESC").list();
		
		employee = new Employee(ManagerMethod.getNewIdEmployee(emps.get(0).getIdEmployee()));
		link="manager/manage/employees.htm?insert";
		btnTitle="Add";
		return "redirect:/manager/employees.htm";
	}
	
	//POST manage/employees?delete
	@RequestMapping(value="manage/employees", method=RequestMethod.POST, params="delete")
	public String employeeDelete(@ModelAttribute("listEmptDel") ListEmpDelete listEmpDel, HttpServletRequest request) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		Employee empTmp;
		Integer idShiftNow = ManagerMethod.getIdShiftNow(request, ssFac);
		Shift shiftNow = (Shift) ssFac.getCurrentSession().get(Shift.class, idShiftNow);
		int counter = 0;
		try {
			for(var empDel : listEmpDel.getList()) {
				if(empDel == null) continue;
				counter++;
				empTmp = (Employee) session.get(Employee.class, empDel);
				if(empTmp.getTimeTables().size() > 0) {
					empTmp.setActive(false);
					empTmp.getAccount().setEnable(false);
					for(var timeTableOfEmp : empTmp.getTimeTables()) {
						if(ManagerMethod.compareShiftDateOfTimeTableWithNow(timeTableOfEmp, shiftNow)) {
							session.delete(timeTableOfEmp);
						}
					}
				} else {
					session.delete(empTmp);
				}
			}
			t.commit();
			if(loadmore > employees.size())
				loadmore -= counter;
		} catch (Exception ex) {
			
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/employees.htm";
	}
	
	//GET manage/employees/{id}?edit
	@RequestMapping(value="manage/employees/{id}", params = "edit")
	public String editEmployee(@PathVariable("id") String idEmployee) {
		employee = (Employee) ssFac.getCurrentSession().get(Employee.class, idEmployee);
		link="manager/manage/employees.htm?edit";
		btnTitle="Update";
		return "redirect:/manager/employees.htm";
	}
	
	//GET manage/employees/{id}?change-password
	@RequestMapping(value="manage/employees/{id}", params = "change-password")
	public String changePassword(@PathVariable("id") String idEmployee) {
		employee = (Employee) ssFac.getCurrentSession().get(Employee.class, idEmployee);
		link="manager/manage/employees.htm?edit";
		btnTitle="Update";
		return "redirect:/manager/employees.htm";
	}
		
	//POST manage/employees/change-password
	@RequestMapping(value="manage/employees/change-password", method=RequestMethod.POST)
	public String changePassword1(@RequestParam("new-password") String newPassword) {
		newPassword = newPassword.trim();
		if(!ManagerMethod.checkValidPassword(newPassword)) {
			message = "Password must contain at least one lowercase character, "
					+ "one uppercase character, one number, no spaces, and at least 8 characters!";
		} else {
			if(ManagerMethod.updatePassword(
					ssFac, 
					MyUtils.passwordEncoder.encode(newPassword), 
					(employee.getAccount()))
				) {
					message = "Update password successfull!";
			} else {
				message = "Update failed, try again!";
			}
		}
		return "redirect:/manager/employees.htm";
	}
	
	//POST manage/employees?edit
	@RequestMapping(value="manage/employees", method=RequestMethod.POST, params="edit")
	public String editEmployee(@ModelAttribute("employee") Employee employee) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		employee.setPosition(ManagerController.employee.getPosition());
		employee.setAccount(ManagerController.employee.getAccount());
		// set attribute and format
		employee.setAttribute();
		if(!employee.validatePhone()) {
			message = "Phone is not valid";
		} else {
			try {
				session.update(employee);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
		
		return "redirect:/manager/employees.htm";
	}
	
	//POST manage/employees?insert
	@RequestMapping(value="manage/employees", method=RequestMethod.POST, params="insert")
	public String insertEmployee(@ModelAttribute("employee") Employee employee) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		// set attribute and format
		employee.setAttribute();
		employee.setAccountForEmp();
		if(employee.getLastName().trim().length() == 0 || employee.getFirstName().trim().length() == 0) {
			message = "Entered first name and last name please!";
		} else if(!employee.validatePhone()) {
			message = "Phone is not valid";
		} else if(employee.getPosition().getIdPosition() == null) {
			message = "Choose position please!";
		} else {
			try {
				session.save(employee);
				session.save(employee.getAccount());
				message = "Account for " + employee.getFullName() + " (Username: " 
						+ employee.getIdEmployee() + ", Password: " + Account.DEFAULT_PASSWORD + ")";
				t.commit();
				isShowLoadmore = true;
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
		
		return "redirect:/manager/employees.htm";
	}
	
	//GET manage/employees?search
	@RequestMapping(value="manage/employees/search", method=RequestMethod.POST)
	public String searchEmployee(@RequestParam("data") String data) {
		dataSearch = data.replaceAll(MyUtils.SPECIAL_CHARACTERS, "");
		if(dataSearch.trim().length() == 0	) {
			return "redirect:/manager/employees.htm";
		}
		isSearch = true;
		isShowLoadmore = false;
		return "redirect:/manager/employees.htm";
	}
	
	// -------------------------------------------------- MANAGE/TASK -------------------------------------------------
	
	// GET /tasks
	@RequestMapping(value="tasks")
	public String tasks(ModelMap model, HttpServletRequest request) throws HibernateException, ParseException {
		
		if(dateShiftForUpTask == null) {
			int idShiftNow = ManagerMethod.getIdShiftNow(request, ssFac);
			dateShiftForUpTask = new DateShiftForUpTask(new Date(), idShiftNow);
		} 
		
		List<Object> initTaskDel = ManagerMethod.initListTaskDelete(ssFac, queryTask);
		List<Object> initUpTaskDel = ManagerMethod.initListUpTaskDelete(ssFac, queryUpTasks, dateShiftForUpTask);
		List<Task> tasks = (List<Task>) initTaskDel.get(0);
		ListTaskDelete listTaskDel = (ListTaskDelete) initTaskDel.get(1);
		
		List<UpTasks> upTasks = (List<UpTasks>) initUpTaskDel.get(0);
		ListUpTaskDelete listUpTaskDel = (ListUpTaskDelete) initUpTaskDel.get(1);
		
		model.addAttribute("tasks", tasks);
		model.addAttribute("listTaskDel", listTaskDel);
		model.addAttribute("listUpTaskDel", listUpTaskDel);
		model.addAttribute("upTasks", upTasks);
		model.addAttribute("message", message);
		model.addAttribute("link", link);
		model.addAttribute("btnTitle", btnTitle);
		model.addAttribute("message", message);
		model.addAttribute("task", task);
		model.addAttribute("tasksForShift", tasksForShift);
		model.addAttribute("dateShiftForUpTask", dateShiftForUpTask);
		
		message = "";
		return "/manager/tasks";
	}
	
	//GET manage/tasks?new
	@RequestMapping(value="manage/tasks", params = "new")
	public String newTask() {
		task = new Task();
		link="manager/manage/tasks.htm?insert";
		btnTitle="Add";
		return "redirect:/manager/tasks.htm";
	}
	
	//POST manage/tasks?delete
	@RequestMapping(value="manage/tasks", method=RequestMethod.POST, params="delete")
	public String taskDelete(@ModelAttribute("listTaskDel") ListTaskDelete listTaskDel) {
		
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		Task taskTmp;
		try {
			for(var taskDel : listTaskDel.getList()) {
				if(taskDel == null) continue;
				taskTmp = (Task) session.get(Task.class, taskDel);
				if(taskTmp.getUpTasks().size() > 0) {
					message = "This task " + taskTmp.getJob() + " has been posted, cannot be deleted";
				} else {
					session.delete(taskTmp);
				}
			}
			t.commit();
		} catch (Exception ex) {
			
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/tasks.htm";
	}
	
	//GET manage/tasks/{id}
	@RequestMapping(value="manage/tasks/{id}")
	public String editTask(@PathVariable("id") int idTask) {
		task = (Task) ssFac.getCurrentSession().get(Task.class, idTask);
		link="manager/manage/tasks.htm?edit";
		btnTitle="Update";
		return "redirect:/manager/tasks.htm";
	}
	
	//POST manage/tasks?edit
	@RequestMapping(value="manage/tasks", method=RequestMethod.POST, params="edit")
	public String editTask(@ModelAttribute("task") Task task) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		task.setJob(MyUtils.formatString(task.getJob()));
		
		try {
			session.update(task);
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/tasks.htm";
	}
	
	//POST manage/tasks?insert
	@RequestMapping(value="manage/tasks", method=RequestMethod.POST, params="insert")
	public String insertTask(@ModelAttribute("task") Task task) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		if(task.getJob().trim().length() == 0) {
			message = "Entered job please!";
		} else {
			task.setJob(MyUtils.formatString(task.getJob()));
			
			try {
				session.save(task);
				t.commit();
			} catch (Exception ex) {
				ex.printStackTrace();
				t.rollback();
			} finally {
				session.close();
			}
		}
		
		
		return "redirect:/manager/tasks.htm";
	}
	
	
	// -------------------------------------------------- MANAGE/TASKS-FOR-SHIFT-------------------------------------------------
	
	// GET manage/get-uptasks
	@RequestMapping("manage/get-uptasks")
	public String getTasksForShift(
				@ModelAttribute("dateShiftForUpTask") DateShiftForUpTask dateShiftForUpTask
			) {
		ManagerController.dateShiftForUpTask = dateShiftForUpTask;
		return "redirect:/manager/tasks.htm";
	}
	
	// GET manage/uptasks?new
	@RequestMapping(value="manage/uptasks", params = "new")
	public String newTaskForShift() {
		tasksForShift = new UpTasks();
		tasksForShift.setDate(dateShiftForUpTask.getDate());
		tasksForShift.setIdShift(dateShiftForUpTask.getShift());
		link="manager/manage/uptasks.htm?insert";
		btnTitle="Add";
		return "redirect:/manager/tasks.htm";
	}
	
	// POST manage/uptasks?delete
	@RequestMapping(value="manage/uptasks", method=RequestMethod.POST, params="delete")
	public String taskForShiftDelete(@ModelAttribute("listUpTaskDel") ListUpTaskDelete listUpTaskDel) {
		
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		UpTasks upTaskTmp;
		try {
			for(var upTaskDel : listUpTaskDel.getList()) {
				if(upTaskDel == null) continue;
				upTaskTmp = (UpTasks) session.get(UpTasks.class, upTaskDel);
				if(upTaskTmp.getWorks().size() > 0) {
					message = "This task has been done by employees!";
					throw new Exception("Up Task Delete Error");
				}
				session.delete(upTaskTmp);
			}
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
		return "redirect:/manager/tasks.htm";
	}
	
	// POST manage/uptasks?insert
	@RequestMapping(value="manage/uptasks", method=RequestMethod.POST, params="insert")
	public String insertTaskForShift(@ModelAttribute("tasksForShift") UpTasks tasksForShift, HttpServletRequest request) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		
		try {
			if(ManagerMethod.compareDateAndTimeWithDateNow(tasksForShift.getDate(), request, tasksForShift.getIdShift())) {
				message = "Not add task for date in the past!";
				throw new Exception("past");
			} 
			session.save(tasksForShift);
			dateShiftForUpTask.setShift(tasksForShift.getIdShift());
			dateShiftForUpTask.setDate(tasksForShift.getDate());
			t.commit();
		} catch (Exception ex) {
			if(!ex.getMessage().equals("past"))
				message = "Each task can only be added once!";
			ex.printStackTrace();
			t.rollback();
			return "redirect:/manager/manage.htm#uptasks";
		} finally {
			session.close();
		}

		return "redirect:/manager/tasks.htm";
	}
	
/************************************************************************************************************************
 * 																														*
 * 													REPORT																*
 * 																														*
 * **********************************************************************************************************************/
	
	// GET report
	@RequestMapping("report")
	public String report(ModelMap model) {
		List<LackOfEmployee> lackOfEmps;
		String dateFilter;
		if(filter != null) {
			lackOfEmps = ManagerMethod.getLackOfEmpFromDatabase(ssFac, filter);
			dateFilter = filter;
			filter = null;
		} else {
			dateFilter = MyUtils.formatDate(MyUtils.DF_DATE, new Date());
			lackOfEmps = ManagerMethod.getLackOfEmpFromDatabase(ssFac, "");
		}
		salaries = ManagerMethod
				.getSalaryFromDatabase(ssFac, monthYearForReport.getMonth().getMonth(), monthYearForReport.getYear().getYear());
			
		
		 statistNumOfShiftArray = ManagerMethod.statistNumOfShiftGroupByEmployee(
				 			ManagerMethod.statistNumOfShift(
				 					ssFac, monthYearForStatist.getMonth().getMonth(),
				 					monthYearForStatist.getYear().getYear()
							)
				 	);
		 
		 List<StatistEvaluationOfEmp> listStatistEvaluationOfEmp =
				 	ManagerMethod.statistEvaluationOfEmp(ssFac, monthYearForStatist.getMonth().getMonth(),
				 				monthYearForStatist.getYear().getYear());
		 
		 List<ArrayList<StatistEvaluationOfEmp>> statistEvaluationOfEmpArray =
				 ManagerMethod.statistEvaluationOfEmpGroupByDateAndShift(listStatistEvaluationOfEmp);
		 
		 List<ArrayList<ArrayList<StatistEvaluationOfEmp>>> statistEvaluationOfEmpArrayOfArray =
				 ManagerMethod.statistEvaluationOfEmpGroupByEmployee(statistEvaluationOfEmpArray);
		 
		 mapStatistEvaluationOfEmp = 
				 ManagerMethod.statistEvaluationOfEmpArrayOfArray2Map(statistEvaluationOfEmpArrayOfArray);
			
		model.addAttribute("monthYear", monthYearForReport);
		model.addAttribute("monthYearForStatist", monthYearForStatist);
		model.addAttribute("lackOfEmps", lackOfEmps);
		model.addAttribute("salaries", salaries);
		model.addAttribute("salary", salary);
		model.addAttribute("message", message);
		model.addAttribute("dateFilter", dateFilter);
		model.addAttribute("statistNumOfShiftArray", statistNumOfShiftArray);
		model.addAttribute("mapStatistEvaluationOfEmp", mapStatistEvaluationOfEmp);
		
		message = "";
		
		return "manager/report";
	}

	// POST report/get-salary
	@RequestMapping(value="report/get-salary", method=RequestMethod.POST)
	public String getSalary(@ModelAttribute("monthYear") MonthYear monthYear) {
		monthYearForReport.setYear(monthYear.getYear());
		monthYearForReport.setMonth(monthYear.getMonth());
		return "redirect:/manager/report.htm";
	}
	
	// GET report/{id}
	@RequestMapping(value="report/{id}")
	public String reportSalary(@PathVariable("id") Integer idSalary) {
		salary = (Salary) ssFac.getCurrentSession().get(Salary.class, idSalary);
		
		return "redirect:/manager/report.htm";
	}
	
	// POST report/salary?edit
	@RequestMapping(value="report/salary", method=RequestMethod.POST, params = "edit")
	public String updateSalary(@ModelAttribute("salary") Salary salary) {
		Session ss = ssFac.openSession();
		Transaction t = ss.beginTransaction();
		
		try {
			ss.update(salary);
			message = "Update successfull!";
			t.commit();
		} catch(Exception ex) {
			message = "Update failed!, try again";
			ex.printStackTrace();
			t.rollback();
		} finally {
			ss.close();
		}
		
		return "redirect:/manager/report.htm";
	}
	
	// GET report/compute-salary
	@RequestMapping("report/compute-salary")
	public String computeSalary() {
	
		ManagerMethod.computeSalary(ssFac, monthYearForReport.getMonth().getMonth(), monthYearForReport.getYear().getYear());
		
		return "redirect:/manager/report.htm";
	}
	
	// GET report/search
	@RequestMapping("report/search")
	public String searchReport(@RequestParam("date-search") Date date) {
		filter = MyUtils.formatDate(MyUtils.DF_DATE, date);
		return "redirect:/manager/report.htm";
	}
	
	// GET report/statist-num-of-shift
	@RequestMapping("report/statist-num-of-shift.htm")
	public String statisttNumOfShift(@ModelAttribute("monthYearForStatist") MonthYear monthYear) {
		monthYearForStatist.setMonth(monthYear.getMonth());
		monthYearForStatist.setYear(monthYear.getYear());
		return "redirect:/manager/report.htm";
	}
	
	/************************************************************************************************************************
	 * 																														*
	 * 													PASSWORD															*
	 * 																														*
	 * **********************************************************************************************************************/
	

	// --------------------------------------------------------------------------------------------------------------------

	@ModelAttribute("listGender")
	public List<Gender> getListGender() {
		List<Gender> listGender = new ArrayList<Gender>();
		listGender.add(new Gender(0, "Nữ"));
		listGender.add(new Gender(1, "Nam"));
		listGender.add(new Gender(2, "Khác"));
		
		return listGender;
	}
	
	@ModelAttribute("listRole")
	public List<Role> getListRole() {
		return ManagerMethod.getListRoleFromDatabase(ssFac);
	}
	
	@ModelAttribute("listDateForNewTimeTable")
	public List<DateForNewTimeTable> getListDateForTimeTable() {
		
		final int NUM_DAY_OF_MONTH = 28;
		final int NUM_DAY_OF_WEEK = 7;
		final int ONE_DAY = 1;
		
		List<DateForNewTimeTable> listDateForTimeTable = new ArrayList<DateForNewTimeTable>();
	
		Date dateStartMax = (Date) ssFac
					.getCurrentSession()
					.createQuery("SELECT MAX(C.dateStart) FROM Constants AS C")
					.uniqueResult();
		
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		TimeUnit time = TimeUnit.DAYS;
		long dateDistance = time.convert(date.getTime() - dateStartMax.getTime(), TimeUnit.MILLISECONDS);
		
		while(cal.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY || dateDistance < NUM_DAY_OF_WEEK*3) {
			cal.add(Calendar.DAY_OF_YEAR, ONE_DAY);
			dateDistance = time.convert(cal.getTime().getTime() - dateStartMax.getTime(), TimeUnit.MILLISECONDS);
		}
		
		for(int i = 1; i <= NUM_DAY_OF_MONTH; i+=NUM_DAY_OF_WEEK) {
			listDateForTimeTable.add(new DateForNewTimeTable(cal.getTime()));
			cal.add(Calendar.DAY_OF_YEAR, NUM_DAY_OF_WEEK);
		}
		
		return listDateForTimeTable;
	}
	
	@ModelAttribute("listYear")
	public List<Year> getListYear() {
		List<Year> years = ssFac.getCurrentSession().getNamedQuery("getStartYear").list();
		int yearNow = Year.getYearNow();
		List<Year> listYear = new ArrayList<Year>();
		for(int i = yearNow;  i >= years.get(0).getYear() ; i--)
			listYear.add(new Year(i));
		return listYear;
	}
	
	@ModelAttribute("listMonth")
	public List<Month> getListMonth() {
		
		List<Month> months = new ArrayList<Month>();
		Map<Integer, String> monthKey = Month.getNameOfMonths();
		for(int i = 1; i <= 12; i++) {
			months.add(new Month(monthKey.get(i), i));
		}
		
		return months;
	}
	
	@ModelAttribute("listPosition")
	public List<Position> getListPosition() {
		List<Position> listPosition = ssFac
					.getCurrentSession()
					.createQuery(queryPosition)
					.list();
		return listPosition;
	}
	
	@ModelAttribute("listFault")
	public List<Fault> getListFault() {
		List<Fault> listFault = ssFac
				.getCurrentSession()
				.createQuery(queryFault)
				.list();
		listFault.add(0, new Fault(null, "none"));
		return listFault;
	}
	
	@ModelAttribute("listEmp")
	public List<Employee> getListEmp() {
		List<Employee> listEmp = ssFac
					.getCurrentSession()
					.createQuery(queryEmployee)
					.list();
		listEmp.add(0, new Employee(null, "none"));
		return listEmp;
	}
	
	@ModelAttribute("listEmpPartTime")
	public List<Employee> getListEmpPartTime() {
		List<Employee> listEmpAllDay = ssFac
					.getCurrentSession()
					.createQuery("FROM Employee E WHERE E.position.isFullTime=0").list();
		listEmpAllDay.add(0, new Employee(null, "none"));
		return listEmpAllDay;
	}
	
}
