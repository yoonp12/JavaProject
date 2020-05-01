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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.paulyoon.javaproject.models.Post;
import com.paulyoon.javaproject.models.User;
import com.paulyoon.javaproject.services.AmazonClient;
import com.paulyoon.javaproject.services.UserService;
import com.paulyoon.javaproject.validator.UserValidator;

@Controller
public class UserController {

	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private UserValidator userVal;
	
	@Autowired
	private AmazonClient amazonClient;
	
	
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
			return "redirect:/dashboard";
		}
	}
	
	
	//  LOGIN USER
	@PostMapping(value="/login")
	public String Login(@ModelAttribute("user") User user, @RequestParam("email") String email, @RequestParam("password") String password, Model model, HttpSession session) {
		boolean userObj = userServ.authenticateUser(email, password);
		if(userObj == true) {
			User userInfo = userServ.findByEmail(email);
			session.setAttribute("userId", userInfo.getId());
			return "redirect:/dashboard";
		}else {
			model.addAttribute("error", "Invalid Username or Password, please try again");
			return "login.jsp";
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
	
	
	//  FRIEND'S PROFILE
	@GetMapping("/profile/{id}")
	public String Profile(@PathVariable("id") Long id, HttpSession session, Model model) {
		User friend = userServ.findUserById(id);
		List<Post> friendPosts = friend.getPosts();
		model.addAttribute("user", friend);
		model.addAttribute("posts", friendPosts);
		return "friendProfile.jsp";
	}
	

	// UPDATE USER PROFILE 
	
	@GetMapping("/update")
	public String Update() {
		return "update.jsp";
	}
	@PostMapping(value="/updateProfile")
	public String EditProfile(@RequestParam("file") MultipartFile file, @RequestParam("bio")String bio, HttpSession session) {
		Long id = (Long)session.getAttribute("userId");
		User userObj = userServ.findUserById(id);
		String postPath = this.amazonClient.uploadFile(file);
		userObj.setFilePath(postPath);
		userObj.setBio(bio);
		userServ.updateUser(userObj);
		return "redirect:/profile";
	}
	

	//  ADD FRIEND
	

	@PostMapping(value="/addFriend")
	public String AddFriend(@RequestParam("username") String username, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		User userObj = userServ.findUserById(userId);
		User friend = userServ.findUserByUsername(username);
		if(friend == null) {
			return "redirect:/createError";
		}else {
			userObj.getFriends().add(friend);
			userServ.updateUser(userObj);
			return "redirect:/dashboard";
		}
	}
	
	//  FLASH REDIRECT
	
	@RequestMapping("/createError")
    public String flashMessages(RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "Username does not exist, please verify!");
        return "redirect:/dashboard";
    }
	
	
	//  LOGOUT 
	@GetMapping("/logout")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
}
