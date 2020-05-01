package com.paulyoon.javaproject.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.paulyoon.javaproject.models.Post;
import com.paulyoon.javaproject.models.User;
import com.paulyoon.javaproject.services.UserService;
import com.paulyoon.javaproject.validator.UserValidator;

@Controller
public class UserController {

	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private UserValidator userVal;
	
	
	@GetMapping("/login")
	public String LoginReg(@ModelAttribute("user") User user) {
		return "login.jsp";
	}
	
	@GetMapping("/register")
	public String Register(@ModelAttribute("user") User user) {
		return "registration.jsp";
	}
	
	//  REGISTER USER
	@PostMapping(value="/register")
	public String Register(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session, Model model) {
		userVal.validate(user, result);
		if(result.hasErrors()) {
			return "registration.jsp";
		}else {
			User userObj = userServ.registerUser(user);
			session.setAttribute("users", userObj);
			Long userId = user.getId();
			session.setAttribute("userId", userId);
			return "redirect:/new";
		}
	}
	
	
	//  LOGIN USER
	@PostMapping(value="/login")
	public String Login(@ModelAttribute("user") User user, @RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		boolean userObj = userServ.authenticateUser(email, password);
		if(userObj == true) {
			User userInfo = userServ.findByEmail(email);
			session.setAttribute("userId", userInfo.getId());
			return "redirect:/new";
		}else {
			model.addAttribute("error", "Invalid Username or Password, please try again");
			return "/login.jsp";
		}
	}
	
	
	//  USER PROFILE 
	@GetMapping("/profile")
	public String Profile(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		List<Post> userPosts = user.getPosts();
		model.addAttribute("user", user);
		model.addAttribute("posts", userPosts);
		return "profile.jsp";
	}
	
	
	//  LOGOUT 
	@GetMapping("/logout")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
}
