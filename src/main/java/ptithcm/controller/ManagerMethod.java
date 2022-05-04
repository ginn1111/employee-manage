package ptithcm.controller;

import java.sql.Time;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import ptithcm.bean.DateShiftForUpTask;
import ptithcm.bean.ListEmpDelete;
import ptithcm.bean.ListFaultDelete;
import ptithcm.bean.ListPositionDelete;
import ptithcm.bean.ListShiftDelete;
import ptithcm.bean.ListTaskDelete;
import ptithcm.bean.ListUpTaskDelete;
import ptithcm.entity.Account;
import ptithcm.entity.Employee;
import ptithcm.entity.Evaluate;
import ptithcm.entity.Fault;
import ptithcm.entity.Position;
import ptithcm.entity.Role;
import ptithcm.entity.Salary;
import ptithcm.entity.Shift;
import ptithcm.entity.Task;
import ptithcm.entity.TimeTable;
import ptithcm.entity.UpTasks;
import ptithcm.entity.tmp.JobOfEmpToManager;
import ptithcm.entity.tmp.LackOfEmployee;
import ptithcm.utils.MyUtils;

@SuppressWarnings("unchecked")
public class ManagerMethod {
	
	public static boolean checkValidPassword(String password) {
		final String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=\\S+$).{8,}$";
		Pattern pattern = Pattern.compile(regex);
		Matcher match = pattern.matcher(password);
		return match.matches();
	}
	
	public static Boolean updatePassword(SessionFactory session, String password, Account account) {
		Session ss = session.openSession();
		Transaction t = ss.beginTransaction();
		
		try {
			account.setPassword(password);
			ss.update(account);
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
			return false;
		} finally {
			ss.close();
		}
		return true;
	}
	
	public static int getIdShiftNow(HttpServletRequest request, SessionFactory session) {
		Object o = (request.getAttribute("shiftNow"));
		if(!o.getClass().getSimpleName().equals("String")) {
			return ((Shift) o).getIdShift();
		} 
		
		return (int) session
					.getCurrentSession()
					.createQuery("SELECT S.idShift FROM Shift AS S WHERE timeStart <= ALL (SELECT S2.timeStart FROM  Shift AS S2)")
					.uniqueResult();
	}
	
	public static List<Role> getListRoleFromDatabase(SessionFactory session) {
		return session.getCurrentSession()
				.createQuery("FROM Role")
				.list();
	}
	
 	public static List<JobOfEmpToManager> getJobOfEmpToManagerFromDatabase(SessionFactory session, Date date, Integer idShift) {
		return session.getCurrentSession()
				.getNamedQuery("getJobOfEmpToManager")
				.setParameter("date", MyUtils.DF_DATE.format(date))
				.setParameter("id_shift", idShift)
				.list();
	}
	
	public static List<TimeTable> getTimeTableToManagerFromDatabase(SessionFactory session) {
		return session.getCurrentSession()
				.getNamedQuery("getAllTimeTable")
				.list();
	}
	
	public static List<TimeTable> getTimeTableToManagerFilterByDate(SessionFactory session, String filter) {
		return session.getCurrentSession()
				.getNamedQuery("getAllTimeTableFilterByDate")
				.setParameter("date", filter)
				.list();
	}
	
	public static List<TimeTable> getTimeTableNowFromDatabase(SessionFactory session) {
		return session.getCurrentSession()
				.getNamedQuery("getEmpOfShiftNow")
				.list();
	}
	
	public static List<ArrayList<TimeTable>> timeTableGroupByDateAndShift(List<TimeTable> timeTables) {
		timeTables.add(null);
		List<ArrayList<TimeTable>> timeTableArray = new ArrayList<ArrayList<TimeTable>>();
		TimeTable tmp1, tmp2;
		ArrayList<TimeTable> listTmp;

		int i = 0;
		while (i < timeTables.size()) {
			tmp1 = timeTables.get(i);
			if(tmp1 == null) break;
			listTmp = new ArrayList<TimeTable>();
			listTmp.add(tmp1);
			if (i == timeTables.size() - 1) {
				timeTableArray.add(listTmp);
				break;
			}
			for (int j = i + 1; j < timeTables.size(); j++) {
				tmp2 = timeTables.get(j);
				i = j;
				if(tmp2 == null || !tmp1.getDate().equals(tmp2.getDate())
						|| tmp1.getShift().getIdShift() != tmp2.getShift().getIdShift()) {
					timeTableArray.add(listTmp);
					break;
				}
				listTmp.add(tmp2);
			}
		}
		return timeTableArray;
	}
	
	public static List<ArrayList<JobOfEmpToManager>> jobOfEmpToManagerGroupByEmployee (List<JobOfEmpToManager> jobOfEmpToManager) {
		jobOfEmpToManager.add(null);
		List<ArrayList<JobOfEmpToManager>> jobOfEmpToManagerArray = new ArrayList<ArrayList<JobOfEmpToManager>>();
		JobOfEmpToManager tmp1, tmp2;
		ArrayList<JobOfEmpToManager> listTmp;
		int i = 0;
		while (i < jobOfEmpToManager.size()) {
			tmp1 = jobOfEmpToManager.get(i);
			if(tmp1 == null) break;
			listTmp = new ArrayList<JobOfEmpToManager>();

			listTmp.add(tmp1);
			if (i == jobOfEmpToManager.size() - 1) {
				jobOfEmpToManagerArray.add(listTmp);
				break;
			}
			for (int j = i + 1; j < jobOfEmpToManager.size(); j++) {
				tmp2 = jobOfEmpToManager.get(j);
				i = j;
				if(tmp2 == null || !tmp1.getEmployee().getIdEmployee().equals(tmp2.getEmployee().getIdEmployee())) {
					jobOfEmpToManagerArray.add(listTmp);
					break;
				}
				listTmp.add(tmp2);
			}
		}
		
		return jobOfEmpToManagerArray;
	}
	
	public static List<TimeTable> getTimeTableFromDatabase(SessionFactory session, String date, String idEmp) throws HibernateException, ParseException {
		return session.getCurrentSession()
				.createQuery("FROM TimeTable T WHERE "
						+ "T.date=:date AND T.employee.idEmployee=:idEmployee")
				.setParameter("date", MyUtils.DF_DATE.parse(date))
				.setParameter("idEmployee", idEmp)
				.list();
	}
	
	public static List<TimeTable> getTimeTableFromDatabase(SessionFactory session, String date, int idShift) throws HibernateException, ParseException {
		return  session.getCurrentSession()
				.createQuery("FROM TimeTable T where T.date=:date AND T.shift.idShift=:id_shift")
				.setParameter("date", MyUtils.DF_DATE.parse(date))
				.setParameter("id_shift", idShift)
				.list();
	}
	
	public static List<Evaluate> getEvaluationFromDatabase(SessionFactory session, int idFault, int idTimeTable) {
		return  session.getCurrentSession()
				.createQuery("FROM Evaluate AS E WHERE E.fault.idFault=:idFault AND E.timeTable.idTimeTable=:idTimeTable")
				.setParameter("idFault", idFault)
				.setParameter("idTimeTable", idTimeTable)
				.list();
	}

	public static List<Salary> getSalaryFromDatabase(SessionFactory session, int month, int year) {
		return session.getCurrentSession()
				.createQuery("FROM Salary AS S WHERE month(date)=:month AND year(date)=:year")
				.setParameter("month", month)
				.setParameter("year", year)
				.list();
	}

	public static List<LackOfEmployee> getLackOfEmpFromDatabase(SessionFactory session, String date) {
		return session.getCurrentSession().getNamedQuery("getLackOfEmp").setParameter("date", date).list();
	}

	public static void insertTimeTableForFullTimeEmp(SessionFactory session, Date date) {
		Query query = session.getCurrentSession()
				.getNamedQuery("insertTimeTableForFulltimeEmp")
				.setParameter("date", date);
		query.executeUpdate();
	}
	
	public static void computeSalary(SessionFactory session, int month, int year) {
		Query query = session.getCurrentSession()
				.getNamedQuery("computeSalary")
				.setParameter("month", month)
				.setParameter("year", year);
		
		query.executeUpdate();
	}

	public static Boolean compareDateAndTimeWithDateNow(Date date, HttpServletRequest request, int idShiftAddTaskForShift) {
		// Get shiftNow for get time end
		List<Shift> shifts = (List<Shift>) request.getAttribute("shifts");
		
		Shift shift = shifts
					.stream()
					.filter(e -> e.getIdShift() == idShiftAddTaskForShift)
					.collect(Collectors.toList())
					.get(0);
		
		Date dateNow = new Date();
		return MyUtils.DF_DATE.format(date).compareTo(MyUtils.DF_DATE.format(dateNow)) < 0 ||
				(MyUtils.DF_DATE.format(date).compareTo(MyUtils.DF_DATE.format(dateNow)) == 0 && 
						MyUtils.DF_TIME.format(shift.getTimeEnd()).compareTo(MyUtils.DF_TIME.format(new Time(dateNow.getTime()))) < 0);
	}
	
	public static ListShiftDelete initListShiftDelete(HttpServletRequest request) {
		List<Shift> shifts = (List<Shift>) request.getAttribute("shifts");
		ListShiftDelete listShiftDel = new ListShiftDelete();
		List<Integer> dummyList = new ArrayList<Integer>();
		for(int i = 0; i < shifts.size(); i++) {
			dummyList.add(null);
		}
		listShiftDel.setList(dummyList);
		return listShiftDel;
	}
	
	public static List<Object> initListEmplDelete(SessionFactory ssFac, String queryEmployee) {
		List<Employee> employees = ssFac
				.getCurrentSession()
				.createQuery(queryEmployee)
				.list();
		List<String> dummyList = new ArrayList<String>();
		for(int i = 0; i < employees.size(); i++)
			dummyList.add(null);
		
		ListEmpDelete listEmpDel = new ListEmpDelete(dummyList);
		return Arrays.asList(employees, listEmpDel);
	}
	
	public static List<Object> initListTaskDelete(SessionFactory ssFac, String queryTask) {
		List<Task> tasks = ssFac
				.getCurrentSession()
				.createQuery(queryTask)
				.list();
		
		List<Integer> dummyList = new ArrayList<Integer>();
		for(int i = 0; i < tasks.size(); i++)
			dummyList.add(null);
		ListTaskDelete listTaskDel = new ListTaskDelete(dummyList);
		
		return Arrays.asList(tasks, listTaskDel);
	}
	
	public static List<Object> initListUpTaskDelete(SessionFactory ssFac, String queryUpTasks, 
				DateShiftForUpTask dateShiftForUpTask
			) throws HibernateException, ParseException {
		
		if(dateShiftForUpTask == null) {
			dateShiftForUpTask = new DateShiftForUpTask(new Date(), 5);
		}
		
		List<UpTasks> upTasks = ssFac	
					.getCurrentSession()
					.createQuery(queryUpTasks)
					.setParameter("date", dateShiftForUpTask.getDate())
					.setParameter("idShift", dateShiftForUpTask.getShift())
					.list();
		List<Integer> dummyList = new ArrayList<Integer>();
		for(int i = 0; i < upTasks.size(); i++)
			dummyList.add(null);
		ListUpTaskDelete listUpTaskDel = new ListUpTaskDelete(dummyList);
		
	
		return Arrays.asList(upTasks, listUpTaskDel);
	}
	
	public static List<Object> initListFaultDelete(SessionFactory ssFac, String queryFault) {
		List<Fault> faults = ssFac
					.getCurrentSession()
					.createQuery(queryFault)
					.list();
		
		ListFaultDelete listFaultDel = new ListFaultDelete();
		List<Integer> dummyList = new ArrayList<Integer>();
		for(int i = 0; i < faults.size(); i++)
			dummyList.add(null);
		
		listFaultDel.setList(dummyList);
		
		return Arrays.asList(faults, listFaultDel);
	}
	
	public static List<Object> initListPositionDelete(SessionFactory ssFac, String queryPosition) {
		List<Position> positions = ssFac
					.getCurrentSession()
					.createQuery(queryPosition)
					.list();
		
		ListPositionDelete listPositionDel = new ListPositionDelete();
		List<Integer> dummyList = new ArrayList<Integer>();
		for(int i= 0; i < positions.size(); i++)
			dummyList.add(null);
		listPositionDel.setList(dummyList);
		
		return Arrays.asList(positions, listPositionDel);
	}

	public static String getNewIdEmployee(String idEmpLast) {
		idEmpLast= idEmpLast.trim();
		String prefix = idEmpLast.substring(0, 2);
		String tmp = idEmpLast.substring(2);
		String suffix = ((Integer)(Integer.parseInt(tmp) + 1)).toString();
		
		return prefix + getSuffixForIdEmp(tmp.length(), suffix);
	}
	
	private static String getSuffixForIdEmp(int len, String suffix) {
		if(len == 0) return "001";
		int lenGenZero = len - suffix.length();
		for(int i = 0; i < lenGenZero; i++) {
			suffix = '0' + suffix;
		}
		return suffix;
	}
}
