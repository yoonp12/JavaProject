package com.paulyoon.javaproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.paulyoon.javaproject.models.Comment;
import com.paulyoon.javaproject.models.Post;

@Repository
public interface CommentRepository extends CrudRepository<Comment,Long>{
	
	List<Comment>findAll();
	
	List<Comment>findAllByPost(Post post);

}
