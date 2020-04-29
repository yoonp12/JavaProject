package com.paulyoon.javaproject.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.paulyoon.javaproject.models.Comment;
import com.paulyoon.javaproject.models.Post;
import com.paulyoon.javaproject.models.Tag;
import com.paulyoon.javaproject.repositories.CommentRepository;
import com.paulyoon.javaproject.repositories.PostRepository;
import com.paulyoon.javaproject.repositories.TagRepository;

@Service
public class MainService {

	private final PostRepository postRepo;
	private final CommentRepository commentRepo;
	private final TagRepository tagRepo;
	
	public MainService(PostRepository postRepo, CommentRepository commentRepo, TagRepository tagRepo) {
		this.postRepo = postRepo;
		this.commentRepo = commentRepo;
		this.tagRepo = tagRepo;
	}
	
	
	//  CREATE EVENT/COMMENT
	public Post newPost(Post post) {
		return postRepo.save(post);	
	}
	
	public Comment newComment(Comment comment) {
		return commentRepo.save(comment);
	}
	
	public Tag newTag(Tag tag) {
		return tagRepo.save(tag);
	}
	
	
	//  FIND POST/TAG
	public Post findPost(Long id) {
		Optional<Post> post = postRepo.findById(id);
		if(post.isPresent()) {
			return post.get();
		}else {
			return null;
		}
	}
	
	public Tag findTag(Long id) {
		Optional<Tag> tag = tagRepo.findById(id);
		if(tag.isPresent()) {
			return tag.get();
		}else {
			return null;
		}
	}
	
	public Tag findTagByString(String tag) {
		Optional<Tag> optionalTag = tagRepo.findByTag(tag);
		if(optionalTag.isPresent()) {
			return optionalTag.get();
		}else {
			return null;
		}
	}
	
	
	//  FIND ALL POSTS/COMMENTS/TAGS
	public List<Post> findAllPosts(){
		return postRepo.findAll();
	}
	
	public List<Comment> findAllComments(){
		return commentRepo.findAll();
	}
	
	public List<Tag> findAllTags(){
		return tagRepo.findAll();
	}
	
	
	//  UPDATE POST
	public Post updatePost(Post post) {
		return postRepo.save(post);
	}
	
	
	//  DELETE POST/COMMENT
	public void deletePost(Long id) {
		postRepo.deleteById(id);
	}
	
	public void deleteComment(Long id) {
		commentRepo.deleteById(id);
	}
	
}
