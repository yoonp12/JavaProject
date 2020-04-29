package com.paulyoon.javaproject.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.paulyoon.javaproject.models.Post;
import com.paulyoon.javaproject.models.Tag;
import com.paulyoon.javaproject.models.User;
import com.paulyoon.javaproject.services.MainService;
import com.paulyoon.javaproject.services.UserService;

/**
 * Handles requests for the application file upload requests
 */
@Controller
public class UploadController {

	@Autowired
	private MainService mainServ;
	
	@Autowired
	private UserService userServ;
	
	
	private static final Logger logger = LoggerFactory
			.getLogger(UploadController.class);

	/**
	 * Upload single file using Spring Controller
	 */
	@RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
	public String uploadFileHandler(@ModelAttribute("post") Post post,
			@RequestParam("name") String name,
			@RequestParam("file") MultipartFile file, HttpSession session, Model model,
			@RequestParam("tags") String tags) {
		String[] splitTags = tags.split(",");
		Long userId = (Long) session.getAttribute("userId");
		User user = userServ.findUserById(userId);
		Post newPost = mainServ.newPost(post);
		for(int i = 0; i < splitTags.length; i++) {
			Tag x = mainServ.findTagByString(splitTags[i]);
			if(x == null) {
				Tag y = mainServ.newTag(new Tag(splitTags[i]));
				newPost.getTags().add(y);
			}else {
				newPost.getTags().add(x);
			}
		}
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				String rootPath = System.getProperty("catalina.home");
				File dir = new File(rootPath + File.separator + "tmpFiles");
				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath()
						+ File.separator + name);
				BufferedOutputStream stream = new BufferedOutputStream(
						new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

				logger.info("Server File Location="
						+ serverFile.getAbsolutePath());
				String postPath = serverFile.getAbsolutePath();
				newPost.setFilePath(postPath);

				return "You successfully uploaded file=" + name;
			} catch (Exception e) {
				return "You failed to upload " + name + " => " + e.getMessage();
			}
		} else {
			return "You failed to upload " + name
					+ " because the file was empty.";
		}
		
	}

	/**
	 * Upload multiple file using Spring Controller
	 */
//	@RequestMapping(value = "/uploadMultipleFile", method = RequestMethod.POST)
//	public @ResponseBody
//	String uploadMultipleFileHandler(@RequestParam("name") String[] names,
//			@RequestParam("file") MultipartFile[] files) {
//
//		if (files.length != names.length)
//			return "Mandatory information missing";
//
//		String message = "";
//		for (int i = 0; i < files.length; i++) {
//			MultipartFile file = files[i];
//			String name = names[i];
//			try {
//				byte[] bytes = file.getBytes();
//
//				// Creating the directory to store file
//				String rootPath = System.getProperty("catalina.home");
//				File dir = new File(rootPath + File.separator + "tmpFiles");
//				if (!dir.exists())
//					dir.mkdirs();
//
//				// Create the file on server
//				File serverFile = new File(dir.getAbsolutePath()
//						+ File.separator + name);
//				BufferedOutputStream stream = new BufferedOutputStream(
//						new FileOutputStream(serverFile));
//				stream.write(bytes);
//				stream.close();
//
//				logger.info("Server File Location="
//						+ serverFile.getAbsolutePath());
//
//				message = message + "You successfully uploaded file=" + name
//						+ "<br />";
//			} catch (Exception e) {
//				return "You failed to upload " + name + " => " + e.getMessage();
//			}
//		}
//		return message;
//	}
}