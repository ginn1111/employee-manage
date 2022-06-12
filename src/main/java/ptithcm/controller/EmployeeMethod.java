package ptithcm.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import ptithcm.bean.DateShift;
import ptithcm.bean.DateShiftArray;
import ptithcm.entity.Employee;
import ptithcm.entity.Salary;
import ptithcm.entity.Shift;
import ptithcm.entity.TimeTable;
import ptithcm.entity.tmp.EmpCooperateWithLeader;
import ptithcm.entity.tmp.EvaluateTmp;
import ptithcm.entity.tmp.JobForLeader;
import ptithcm.entity.tmp.JobOfShift;
import ptithcm.entity.tmp.StatusOfShift;
import ptithcm.utils.MyUtils;

@SuppressWarnings("unchecked")
public class EmployeeMethod {
	private final static int NUM_OF_WEEK = 4;
	private final static int DAY_OF_WEEK = 7;
	private final static int NUM_DAY_OF_MONTH = DAY_OF_WEEK * NUM_OF_WEEK;
	private final static DateFormat DF_DAY = new SimpleDateFormat("EEEE");
	private final static DateFormat DF_DATE = new SimpleDateFormat("dd/MM");
	
	public static void registerTimeTable(DateShiftArray dateShiftArray, String idEmp, SessionFactory ssFac) {
		Session session = ssFac.openSession();
		Transaction t = session.beginTransaction();
		try {
			for (var i : dateShiftArray.getArray()) {
				for (var j : i) {
					for (var k : j) {
						if (k.getDate() == null || !k.getIsCheck())
							continue;
						session.save(new TimeTable(new Shift(k.getShift()), k.getDate(), new Employee(idEmp)));
					}
				}
			}
			t.commit();
		} catch (Exception ex) {
			ex.printStackTrace();
			t.rollback();
		} finally {
			session.close();
		}
	}
	
	public static List<Object> jobForLeaderGroupByDateAndShift(List<JobForLeader> jobForLeaders) {
		jobForLeaders.add(null);
		List<ArrayList<JobForLeader>> matrixJobForLeader = new ArrayList<ArrayList<JobForLeader>>();
		List<Object> dateOfShiftNow = new ArrayList<Object>();
		JobForLeader tmp1, tmp2;
		ArrayList<JobForLeader> listTmp;
		int i = 0;
		while ( i < jobForLeaders.size()) {
			tmp1 = jobForLeaders.get(i);
			if(tmp1 == null) break;
			
			dateOfShiftNow.add(Arrays.asList(DF_DAY.format(tmp1.getDate()), DF_DATE.format(tmp1.getDate())));
			if (tmp1.getJob() == null) {
				matrixJobForLeader.add(null);
				i++;
				continue;
			}
			listTmp = new ArrayList<JobForLeader>();
			listTmp.add(tmp1);
			if(i == jobForLeaders.size() - 1) {
				matrixJobForLeader.add(listTmp);
				break;
			}
			for (int j = i + 1; j < jobForLeaders.size(); j++) {
				tmp2 = jobForLeaders.get(j);
				i = j;
				if(tmp2 == null || 
						!tmp1.getDate().equals(tmp2.getDate()) || 
						tmp1.getShift().getIdShift() != tmp2.getShift().getIdShift()
					) {
					matrixJobForLeader.add(listTmp);
					break;
				}
				listTmp.add(tmp2);
			}
			
		}
		
		List<Object> jobs = new ArrayList<Object>();
		for (i = 0; i < matrixJobForLeader.size(); i += DAY_OF_WEEK) {
			jobs.add(matrixJobForLeader.subList(i, i + DAY_OF_WEEK));
		}
		
		return Arrays.asList(jobs, dateOfShiftNow.subList(0, DAY_OF_WEEK));
	}
	
	public static List<Object> statusOfShiftGroupByDateAndShift(List<StatusOfShift> shiftStatus) {
		List<ArrayList<Object>> timeTable = new ArrayList<ArrayList<Object>>();
		List<ArrayList<ArrayList<DateShift>>> dateShiftArray = new ArrayList<ArrayList<ArrayList<DateShift>>>();
		List<Object> dateOfShift = new ArrayList<Object>();
		
		for (int i = 0; i < NUM_OF_WEEK; i++) {
			dateShiftArray.add(new ArrayList<ArrayList<DateShift>>());
			timeTable.add(new ArrayList<Object>());
		}

		int NUM_OF_ALL_SHIFT = shiftStatus.size();
		List<StatusOfShift> listTmp;
		for (int i = 0; i < NUM_OF_ALL_SHIFT; i += NUM_DAY_OF_MONTH) {
			for (int j = i; j < NUM_DAY_OF_MONTH * (i / NUM_DAY_OF_MONTH + 1); j += DAY_OF_WEEK) {
				listTmp = shiftStatus.subList(j, j + DAY_OF_WEEK);
				timeTable.get((j - i) / 7).add(listTmp);
				
				dateShiftArray.get((j - i)/7).add(
								(ArrayList<DateShift>) listTmp
								.stream()
								.map( e -> new DateShift(e.getDate(), e.getIdShift()))
								.collect(Collectors.toList())
							);

				dateOfShift.add(shiftStatus.subList(j, j + DAY_OF_WEEK).stream().map(s -> {
					return Arrays.asList(DF_DAY.format(s.getDate()), DF_DATE.format(s.getDate()));
				}).collect(Collectors.toList()));
			}
		}
		
		return Arrays.asList(timeTable, dateShiftArray, dateOfShift);
	}

	public static List<Object> evaluationsGroupByDateAndShift(List<EvaluateTmp> evaluations) {
		evaluations.add(null);
		List<ArrayList<EvaluateTmp>> matrixOfEvaluations = new ArrayList<ArrayList<EvaluateTmp>>();
		EvaluateTmp tmp1, tmp2;
		ArrayList<EvaluateTmp> listTmp;

		int i = 0;
		while (i < evaluations.size()) {
			tmp1 = evaluations.get(i);
			if(tmp1 == null) break;
			if (tmp1.getDescription() == null) {
				matrixOfEvaluations.add(null);
				i++;
				continue;
			}
			listTmp = new ArrayList<EvaluateTmp>();
			listTmp.add(tmp1);
			if(i == evaluations.size() - 1) {
				matrixOfEvaluations.add(listTmp);
				break;
			}
			for (int j = i + 1; j < evaluations.size(); j++) {
				tmp2 = evaluations.get(j);
				i = j;
				if (tmp2 == null || !tmp1.getDate().equals(tmp2.getDate()) || tmp1.getIdShift() != tmp2.getIdShift()) {
					matrixOfEvaluations.add(listTmp);
					break;
				}
				listTmp.add(tmp2);
			}
		}

		List<Object> evaluation = new ArrayList<Object>();
		for (i = 0; i < matrixOfEvaluations.size(); i += DAY_OF_WEEK) {
			evaluation.add(matrixOfEvaluations.subList(i, i + DAY_OF_WEEK));
		}
		return evaluation;
	}	
	
	public static List<ArrayList<Object>> groupByWeek (List<Object> list) {
		List<ArrayList<Object>> array = new ArrayList<ArrayList<Object>>();
		for (int i = 0; i < NUM_OF_WEEK; i++)
			array.add(new ArrayList<Object>());

		for (int i = 0; i < list.size(); i += NUM_OF_WEEK) {
			for (int j = i; j < NUM_OF_WEEK * (i / NUM_OF_WEEK + 1); j++) {
				array.get(j % NUM_OF_WEEK).add(list.get(j));
			}
		}
		return array;
	}
	
	public static List<Object> jobOfShiftGroupByDateAndShift(List<JobOfShift> jobOfShifts) {
		jobOfShifts.add(null);
		List<ArrayList<JobOfShift>> matrixJobOfShift = new ArrayList<ArrayList<JobOfShift>>();
		List<Object> dateOfShiftNow = new ArrayList<Object>();
		JobOfShift tmp1, tmp2;
		ArrayList<JobOfShift> listTmp;
		int i = 0;
		while (i < jobOfShifts.size()) {
			tmp1 = jobOfShifts.get(i);
			if(tmp1 == null) break;
			dateOfShiftNow.add(Arrays.asList(DF_DAY.format(tmp1.getDate()), DF_DATE.format(tmp1.getDate())));
			if (tmp1.getJob() == null) {
				matrixJobOfShift.add(null);
				i++;
				continue;
			}
			listTmp = new ArrayList<JobOfShift>();
			listTmp.add(tmp1);
			if (i == jobOfShifts.size() - 1) {
				matrixJobOfShift.add(listTmp);
				break;
			}
			for (int j = i + 1; j < jobOfShifts.size(); j++) {
				tmp2 = jobOfShifts.get(j);
				i = j;
				if (tmp2 == null || 
						!tmp1.getDate().equals(tmp2.getDate()) ||
						tmp1.getShift().getIdShift() != tmp2.getShift().getIdShift()) {
					
					matrixJobOfShift.add(listTmp);
					break;
				} 
				listTmp.add(tmp2);
			}
		}

		List<Object> jobs = new ArrayList<Object>();
		for (i = 0; i < matrixJobOfShift.size(); i += DAY_OF_WEEK) {
			jobs.add(matrixJobOfShift.subList(i, i + DAY_OF_WEEK));
		}
		return Arrays.asList(jobs, dateOfShiftNow.subList(0, DAY_OF_WEEK));
	}

	public static List<StatusOfShift> getStatusOfShiftFromDatabase(SessionFactory session, String idEmp) {
		return session.getCurrentSession()
				.getNamedQuery("getStatusTimeTable")
				.setParameter("id_emp", idEmp)
				.list();
	}
	
	public static List<JobOfShift> getJobOfShiftFromDatabase(SessionFactory session, String idEmp, Boolean isAll) {
		return session.getCurrentSession()
				.getNamedQuery("getTimeTableOfEmp")
				.setParameter("id_emp", idEmp)
				.setParameter("is_all", isAll)
				.list();
	}
	
	public static List<EvaluateTmp> getEvaluationFromDatabase(SessionFactory session, String idEmp, Boolean isAll) {
		return session.getCurrentSession()
				.getNamedQuery("getEvaluation")
				.setParameter("id_emp", idEmp)
				.setParameter("is_all", isAll)
				.list();
	}
	
	public static List<Salary> getSalariesFromDatabase(SessionFactory session, String idEmp) {
		return session.getCurrentSession()
				.createQuery("FROM Salary AS s WHERE s.employee.idEmployee = :idEmployee")
				.setParameter("idEmployee", idEmp).list();
	}
	
	public static List<JobForLeader> getJobForLeaderFromDatabase(SessionFactory session, String idLeader, Boolean isAll) {
		return session.getCurrentSession()
				.getNamedQuery("getJobForLeader")
				.setParameter("id_leader", idLeader)
				.setParameter("is_all", isAll)
				.list();
	}
	
	public static List<EmpCooperateWithLeader> getEmpCooperateWithLeaderFromDatabase(
				SessionFactory session, String idLeader, Integer idShift, Date date, Integer idUpTask) {
		return session.getCurrentSession()
				.getNamedQuery("getEmpCooperateWithLeader")
				.setParameter("id_shift", idShift)
				.setParameter("date", MyUtils.DF_DATE.format(date))
				.setParameter("id_leader", idLeader)
				.setParameter("id_up_task", idUpTask)
				.list();
	}
}
