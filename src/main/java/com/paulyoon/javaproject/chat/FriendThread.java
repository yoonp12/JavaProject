package com.paulyoon.javaproject.chat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

import javax.json.Json;
import javax.json.JsonObject;

public class FriendThread extends Thread{

	private BufferedReader bufferedReader;
	public FriendThread(Socket socket) throws IOException {
		bufferedReader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
	}
	public void run() {
		boolean flag = true;
		while(flag) {
			try {
				JsonObject jsonObj = Json.createReader(bufferedReader).readObject();
				if(jsonObj.containsKey("username")) {
					System.out.println("[" + jsonObj.getString("username")+"]: " + jsonObj.getString("message"));
				}
			}catch (Exception e) {
				flag = false;
				interrupt();
			}
		}
	}
}
