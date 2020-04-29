package com.paulyoon.javaproject.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.paulyoon.javaproject.models.User;

@Repository
public interface UserRepository extends CrudRepository<User, Long>{
	
	List<User>findAll();
	
	User findByUserName(String userName);
	
	User findByEmail(String email);

}
