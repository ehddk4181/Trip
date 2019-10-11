package com.trip.guide.Except;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalException {

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Model model , Exception ex){
		model.addAttribute("Message", "기타 에러 발생");
		model.addAttribute("ex", ex);
		return "error";
	}
}
