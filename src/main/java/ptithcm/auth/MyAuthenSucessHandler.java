package ptithcm.auth;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class MyAuthenSucessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authenticate)
			throws IOException, ServletException {
			Set<String> roles = AuthorityUtils.authorityListToSet(authenticate.getAuthorities());
			if(roles.contains("ROLE_Manager")) {
				response.sendRedirect(request.getContextPath() + "/manager/index.htm");
				return;
			} else if(roles.contains("ROLE_Leader")) {
				response.sendRedirect(request.getContextPath() + "/leader/index.htm");
				return;
			} 
			response.sendRedirect(request.getContextPath() + "/employee/index.htm");
	}

}
