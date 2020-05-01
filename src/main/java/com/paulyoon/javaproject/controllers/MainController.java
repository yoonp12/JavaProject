package com.paulyoon.javaproject.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.paulyoon.javaproject.models.Comment;
import com.paulyoon.javaproject.models.Post;
import com.paulyoon.javaproject.models.Tag;
import com.paulyoon.javaproject.models.User;
import com.paulyoon.javaproject.services.AmazonClient;
import com.paulyoon.javaproject.services.MainService;
import com.paulyoon.javaproject.services.UserService;

@Controller
public class MainController {

	@Autowired
	private MainService mainServ;
	
	@Autowired
	private UserService userServ;
	
	@Autowired
	private AmazonClient amazonClient;

	
	//  CREATE POST PAGE
	@GetMapping("/new")

	public String newPost(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		List<Post> userPosts = user.getPosts();
		model.addAttribute("user", user);
		model.addAttribute("posts", userPosts);
		return "myPosts.jsp";

	}
	
	
	//  CREATE POST METHOD
	@PostMapping(value="/newPost")
	public String createPost(@RequestParam("file") MultipartFile file, @RequestParam("description") String description, @RequestParam("tags") String tags, HttpSession session) {
		Long id = (Long) session.getAttribute("userId");
		User userObj = userServ.findUserById(id);
		Post newPost = new Post();
		String postPath = this.amazonClient.uploadFile(file);
		newPost.setFilePath(postPath);
		newPost.setUser(userObj);
		newPost.setDescription(description);
		String[] splitTags = tags.split(",");
		List <Tag> postTags = new ArrayList<Tag>();
		newPost.setTags(postTags);
		for(int i = 0; i < splitTags.length; i++) {
			Tag x = mainServ.findTagByString(splitTags[i]);
			if(x != null) {
				postTags.add(x);
			}else {
				Tag y = mainServ.newTag(new Tag(splitTags[i]));
				postTags.add(y);
			}
		}
		mainServ.newPost(newPost);
		return"redirect:/profile";
	}
	
	
	//  FIND ALL POSTS
	@GetMapping("/dashboard")
	public String allPosts(Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("userId");
		User userObj = userServ.findUserById(id);
		List<Post> allPosts = mainServ.findAllPosts();
		List<User>friends = userObj.getFriends();
		model.addAttribute("user", userObj);
		model.addAttribute("posts", allPosts);
		model.addAttribute("friends", friends);
		return "dashboard.jsp";
	}
	
	
	//  FIND POST BY TAGS
	@PostMapping(value="/searchTags")
	public String findPostsByTags(@RequestParam("tags") String tag, Model model, RedirectAttributes redirectAttributes) {
		List<Post> allPosts = mainServ.findAllPosts();
		List<Post> foundPosts = new ArrayList<Post>();
		Tag x = mainServ.findTagByString(tag);
		if(x != null) {
			for(int i = 0; i < allPosts.size(); i ++) {
				Post y = allPosts.get(i);
				List<Tag> postTags = y.getTags();
				if(postTags.contains(x)) {
					foundPosts.add(y);
				}
			}
		}else {
			return null;
		}
		model.addAttribute("posts", foundPosts);
		redirectAttributes.addAttribute("taggedPosts", foundPosts);
		return "redirect:/taggedPosts";
	}
	
	
	//  DASHBOARD WITH TAGS SEARCHED
	@GetMapping("/taggedPosts")
	public String searchedTags(@RequestParam("taggedPosts") List<Post> taggedPosts, Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("userId");
		User userObj = userServ.findUserById(id);
		List<User>friends = userObj.getFriends();
		model.addAttribute("friends", friends);
		model.addAttribute("posts", taggedPosts);
		return "taggedPosts.jsp";
	}
	
	
	//  FIND SINGLE POST
	@GetMapping("/post/{id}")
	public String showPost(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		Post post = mainServ.findPost(id);
		List<Comment> postComments = post.getComments();
		List<Tag> postTags = post.getTags();
		model.addAttribute("user", user);
		model.addAttribute("posts", post);
		model.addAttribute("comments", postComments);
		model.addAttribute("tags", postTags);
		return "showPost.jsp";
	}
	
	
	//  LIKE A POST
	@PostMapping(value="/likePost/{id}")

	public String likePost(@PathVariable("id") Long id, HttpSession session) {
		Post post = mainServ.findPost(id);
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		List<User>usersLiked = post.getUsersliked();
		if(usersLiked.contains(user)) {
			usersLiked.remove(user);
		}else {
			usersLiked.add(user);
		}
		mainServ.updatePost(post);
		return "redirect:/dashboard";
	}
	
	//  LIKE A POST ON SHOW POST
	@PostMapping(value="/show/likePost/{id}")
	public String showLikePost(@PathVariable("id") Long id, HttpSession session) {
		Post post = mainServ.findPost(id);
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		List<User>usersLiked = post.getUsersliked();
		if(usersLiked.contains(user)) {
			usersLiked.remove(user);
		}else {
			usersLiked.add(user);
		}
		mainServ.updatePost(post);
		return "redirect:/post/{id}";
	}
	
	
	//  COMMENT ON POST
	@PostMapping(value="/postComment/{id}")
	public String postComment(@PathVariable("id") Long id, @RequestParam("comment") String comment, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		Post post = mainServ.findPost(id);
		Comment newComment = new Comment();
		newComment.setPost(post);
		newComment.setUser(user);
		newComment.setComment(comment);
		mainServ.newComment(newComment);
		return "redirect:/post/{id}";

	}
	
	// DELETE A POST
	@DeleteMapping(value="/post/{id}")
	public String deletePost(@PathVariable("id")Long id, Model model) {
		mainServ.deletePost(id);
		return "redirect:/dashboard";

	}
}
