package com.paulyoon.javaproject.chat;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.net.Socket;

import javax.json.Json;

public class Friend {

	public static void main(String[] args) throws Exception{
		BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("> Enter friend's username:");
		String[] setupValues = bufferedReader.readLine().split("");
		ServerThread serverThread = new ServerThread(setupValues[1]);
		serverThread.start();
		new Friend().updateListenToFriends(bufferedReader, setupValues[0], serverThread);
	}
	
	public void updateListenToFriends(BufferedReader bufferedReader, String username, ServerThread serverThread) throws Exception {
		System.out.println("> Enter");
		System.out.println(" Friends to receive messages from (s to skip)");
		String input = bufferedReader.readLine();
		String[] inputValues = input.split("");
		if(!input.equals("s")) for (int i = 0; i < inputValues.length; i++) {
			String[] address = inputValues[i].split(":");
			Socket socket = null;
			try {
				socket = new Socket(address[0], Integer.valueOf(address[1]));
				new FriendThread(socket).start();
			}catch (Exception e) {
				if(socket != null) {
					socket.close();
				}else {
					System.out.println("Invalid input. skipping to next step.");
				}
			}
		}
		communicate(bufferedReader, username, serverThread);	
	}
	
	public void communicate(BufferedReader bufferedReader, String username, ServerThread serverThread) {
		try {
			System.out.println("> send your message (e to exit, c to chnage)");
			boolean flag = true;
			while(flag) {
				String message = bufferedReader.readLine();
				if(message.equals("e")) {
					flag = false;
					break;
				}else if (message.equals("c")){
					updateListenToFriends(bufferedReader, username, serverThread);
				}else {
					StringWriter stringWriter = new StringWriter();
					Json.createWriter(stringWriter).writeObject(Json.createObjectBuilder()
													.add("username", username)
													.add("message", message)
													.build());
					serverThread.sendMessage(stringWriter.toString());
					
				}
			}
			System.exit(0);
			
		}catch (Exception e) {
			
		}
	}
}
















