package com.paulyoon.javaproject.services;

import java.util.Optional;

import javax.validation.Valid;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.paulyoon.javaproject.models.User;
import com.paulyoon.javaproject.repositories.UserRepository;

@Service
public class UserService {

	private final UserRepository userRepo;
	
	public UserService(UserRepository userRepo) {
		this.userRepo = userRepo;
	}
	
	//REGISTER AND HASH PASSWORD
	public User registerUser(User user) {
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        return userRepo.save(user);
    }
	
	//FIND USER BY EMAIL
	public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }
		
	//FIND USER BY ID
	public User findUserById(Long id) {
    	Optional<User> u = userRepo.findById(id);
    	if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
    }
	
	//FIND USER BY USERNAME
	public User findUserByUsername(String userName) {
		Optional<User> u = userRepo.findByUserNameContaining(userName);
		if(u.isPresent()) {
            return u.get();
    	} else {
    	    return null;
    	}
	}
	
	public void updateUser(@Valid User user) {
		userRepo.save(user);
	}
	
	//AUTHENTICATE USER
	public boolean authenticateUser(String email, String password) {
        User user = userRepo.findByEmail(email);
        if(user == null) {
            return false;
        } else {
            if(BCrypt.checkpw(password, user.getPassword())) {
                return true;
            } else {
                return false;
            }
        }
    }
	
	
}
