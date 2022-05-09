package ptithcm.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ptithcm.entity.Employee;
import ptithcm.utils.MyUtils;

@Controller
@Transactional
public class AuthenController {
	
	private static String message;
	
	@Autowired
	SessionFactory ssFac;
	
	// GET login?error=true
	@RequestMapping(value="login")
	public String loginError(ModelMap model, @RequestParam("error") Boolean error) {
		model.addAttribute("message", "Username or password is not correct!");
		return "../../index";
	}
	
	// GET password
	@RequestMapping("password")
	public String password(ModelMap model, Principal principal) {
		
		model.addAttribute("message", message);
		message = "";
		
		return "password";
	}
	
	// POST password
	@RequestMapping(value="password", method=RequestMethod.POST)
	public String changePassword(
				@RequestParam("old-password") String oldPassword,
				@RequestParam("new-password") String newPassword,
				HttpServletRequest request
			) {
		
		oldPassword = oldPassword.trim();
		newPassword = newPassword.trim();
		Employee employee = (Employee) request.getAttribute("userInfo");
		
		if(!ManagerMethod.checkValidPassword(newPassword)) {
			message = "Password must contain at least one lowercase character, "
					+ "one uppercase character, one number, no spaces, and at least 8 characters!";
		} else {
			
			if(MyUtils.passwordEncoder.matches(oldPassword, employee.getAccount().getPassword())) {
				if(ManagerMethod.updatePassword(
						ssFac, 
						MyUtils.passwordEncoder.encode(newPassword), 
						(employee.getAccount()))
					) {
						message = "Update password successfull!";
				} else {
					message = "Update failed, try again!";
				}
			} else {
				message = "Password is wrong!";
			}
		}
		
		return "redirect:/password.htm";
	}
		
}
