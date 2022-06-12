package ptithcm.interceptor;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ptithcm.entity.Employee;
import ptithcm.entity.Shift;
import ptithcm.utils.MyUtils;

public class GlobalInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	SessionFactory ssFactory;

	@SuppressWarnings("unchecked")
	@Transactional
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
			List<Shift> shifts = ssFactory.getCurrentSession().getNamedQuery("getShiftsOfTimeTalbe").list();
			Shift shiftNow = null;
			Date now = new Date();
			String dateNow = MyUtils.formatDate(MyUtils.DF_DATE, now);
			String timeNow = MyUtils.formatDate(MyUtils.DF_TIME, now);
			for(var i : shifts) {
				if(i.getTimeStart().toString().compareTo(timeNow) <= 0 &&
					i.getTimeEnd().toString().compareTo(timeNow) >= 0) {
					shiftNow = i;
					break;
				}
			}

			request.setAttribute("shifts", shifts);
			request.setAttribute("shiftNow",  shiftNow == null ? "Ngoài thời gian" : shiftNow);
			request.setAttribute("dateNow", dateNow);
			request.setAttribute("timeNow", timeNow);
			request.setAttribute("userInfo", 
						(Employee) ssFactory.getCurrentSession().get(Employee.class, 
							SecurityContextHolder.getContext().getAuthentication().getName())
					);
		return true;
	}
}
