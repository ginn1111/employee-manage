package ptithcm.interceptor;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

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
			List<Shift> shifts = ssFactory
						.getCurrentSession()
						.createQuery("FROM Shift AS S WHERE S.deleted=false ORDER BY S.name")
						.list();
			List<Shift> shiftNow = ssFactory.getCurrentSession().getNamedQuery("getShiftNow").list();
			request.setAttribute("shifts", shifts);
			request.setAttribute("shiftNow", shiftNow.size() == 0 ? "Ngoài thời gian" : shiftNow.get(0));
			
			Date dateNow = new Date();
			request.setAttribute("dateNow", MyUtils.formatDate(MyUtils.DF_DATE, dateNow));
			request.setAttribute("timeNow", MyUtils.formatDate(MyUtils.DF_TIME, dateNow));
		return true;
	}
}
