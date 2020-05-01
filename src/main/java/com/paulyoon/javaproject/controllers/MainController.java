package com.paulyoon.javaproject.controllers;

import java.util.ArrayList;
import java.util.List;

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
//		String[] splitTags = tags.split(",");
//		for(int i = 0; i < splitTags.length; i++) {
//			Tag x = mainServ.findTagByString(splitTags[i]);
//			if(x == null) {
//				Tag y = mainServ.newTag(new Tag(splitTags[i]));
//				newPost.getTags().add(y);
//			}else {
//				newPost.getTags().add(x);
//			}
//		}
		mainServ.newPost(newPost);
		return"redirect:/profile";
	}
	
	
	//  FIND ALL POSTS
	@GetMapping("/dashboard")
	public String allPosts(Model model, HttpSession session) {
		Long id = (Long) session.getAttribute("userId");
		User userObj = userServ.findUserById(id);
		List<Post> allPosts = mainServ.findAllPosts();
		ArrayList<User>friends = userObj.getFriends();
		model.addAttribute("posts", allPosts);
		model.addAttribute("friends", friends);
		return "dashboard.jsp";
	}
	//  FIND POST BY TAGS
	@PostMapping(value="/postsByTags")
	public String findPostsByTags(@RequestParam("tags") String tag, Model model) {
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
		return "redirect:/taggedPosts";
	}
	
	
	//  FIND SINGLE POST
	@GetMapping("/post/{id}")
	public String showPost(@PathVariable("id") Long id, Model model) {
		Post post = mainServ.findPost(id);
		List<Comment> postComments = post.getComments();
		List<Tag> postTags = post.getTags();
		model.addAttribute("posts", post);
		model.addAttribute("comments", postComments);
		model.addAttribute("tags", postTags);
		return "showPost.jsp";
	}
	
	
	//  LIKE A POST
	@PostMapping(value="/likePost/{id}")
	public String likePost(Long id, HttpSession session) {
		Post post = mainServ.findPost(id);
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		List<User> usersLiked = post.getUsersliked();
		usersLiked.add(user);
		return "redirect:/showPost{id}";
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
