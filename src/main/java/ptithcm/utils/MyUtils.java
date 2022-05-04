package ptithcm.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class MyUtils {
	public static final DateFormat DF_DATE = new SimpleDateFormat("yyyy-MM-dd");
	public static final DateFormat DF_TIME = new SimpleDateFormat("HH:mm");
	public static BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	public static void main(String[] args) {
		String shift = "shift     tHUAN 1";
		System.out.println(
		MyUtils.formatString(shift));
	}
	
	public static String formatString(String s) {
		s = s.trim();
		String des = s.toLowerCase();
		String[] splitStr = des.split(" ");
		des = "";
		for(var i : splitStr) {
			if(i.isBlank()) continue;
			i = ((i.charAt(0) + "").toUpperCase()) + i.substring(1, i.length());
			des += i + " "; 
		}
		
		return des.substring(0, des.length()-1);
	}
	
	public static String formatDate(DateFormat df, Date date) {
		return df.format(date);
	}
}
