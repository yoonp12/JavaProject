package com.paulyoon.javaproject.chat;

import java.io.PrintWriter;
import java.net.Socket;

public class ServerThreadThread extends Thread{

	private ServerThread serverThread;
	private Socket socket;
	private PrintWriter printWriter;
	public ServerThreadThread(Socket socket, ServerThread serverThread) {
		this.serverThread = serverThread;
		this.socket = socket;
	}
	public PrintWriter getPrintWriter() {
		return printWriter;
	}
}
