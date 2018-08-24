package com.cif;

/**
 * Class implements admin thread for CIF.  At this time, the thread is not
 * fault tolerant.  It should get good commands.  If bad command is received,
 * this thread will not give help.  Will just respond as bad command.  Also,
 * if the thread receives commands lines that are more than the accepted length,
 * the thread will terminate connection with client with error.
 *
 * If there is any exception during accept, thread will close the socket and
 * try to re-open it.  Failure to do so, will mark all threads to terminate.
 * Send interrupt to all not running threads.
 */
import java.net.*;
import java.io.*;
import java.util.*;

public class CIFAdminThread implements Runnable {
	public static final int MAX_COMMAND_LINE_LENGTH = 80;

	private static CIFAdminThread instance = null;

	private ServerSocket serverSocket = null;

	boolean doNotStop = true;

	private CIFAdminThread(ServerSocket serverSocket) {
		this.serverSocket = serverSocket;
	}

	public static synchronized CIFAdminThread getInstance(ServerSocket
															serverSocket)
	{
		if (serverSocket == null && instance == null) {
			return null;
		}

		if (instance == null && serverSocket != null
			&& serverSocket.getLocalPort() != 0)
		{
			instance =  new CIFAdminThread(serverSocket);
		}
		return instance;
	}

	public void run() {
		CIFLogger.getInstance().logInfo("Admin thread starting");

		while (doNotStop) {
			// Accept message from socket and take action
			Socket client = null;
			try {
				client = serverSocket.accept();
			} catch (Exception e) {
				retryOpenServerSocket();
				continue;
			}

			// Admin session
			try {
				boolean clientOK = false;
				String cmdLine = null;
				BufferedReader br = new BufferedReader(
										new InputStreamReader(
											client.getInputStream()
										)
									);
				PrintStream ps = new PrintStream(client.getOutputStream());

				// Make sure that the connection originates from localhost
				InetAddress selfAddress = client.getLocalAddress();
				InetAddress clientAddress = client.getInetAddress();

				CIFLogger.getInstance().logDebug(
					"* Local Address: " + selfAddress +
					"* Client Address: " + clientAddress);

				if (selfAddress.equals(clientAddress)) {
					clientOK = true;
				} else {
					ps.print("Must telnet from local host only.  Bye.\n");
				}

				while (clientOK) {
					ps.print("\n*" + new Date() + "\n*CIF Command> ");
					cmdLine = br.readLine().trim();
					CIFLogger.getInstance().logInfo(
						"Received command line: " + cmdLine);
					StringTokenizer st = new StringTokenizer(cmdLine);
					if (st.countTokens() <= 0) {
						continue;
					}
					String[] tokens = new String[st.countTokens()];

					int i=0;
					while (st.hasMoreTokens()) {
						if (i == 0) {
							tokens[i++]=st.nextToken().toLowerCase();
						} else {
							tokens[i++]=st.nextToken();
						}
					}

					int cmd = -1;
					if (tokens[0].equals("shutdown")) {
						CIFManager.getInstance("CIFManager").shutdown();
						tokens[0] = "quit";
					}
					if (tokens[0].equals("quit")) {
						ps.println("Closing connection.  Bye.");
						clientOK = false;
						continue;
					} else if (tokens[0].equals("interfaces")) {
						ps.println(CIFManager.getInstance("CIFManager").getInterfacesList());
						continue;
					} else if (tokens[0].equals("threads")) {
						CIFManager.getInstance("CIFManager").getInterfaceThreads(ps);
						continue;
					} else {
						// Check if command should be sent to interface thread
						if (tokens[0].equals("stop")) {
							cmd = InterfaceThread.COMMAND_STOP;
						} else if (tokens[0].equals("skip")) {
							cmd = InterfaceThread.COMMAND_SKIP;
						} else if (tokens[0].equals("resume")) {
							cmd = InterfaceThread.COMMAND_RESUME;
						} else if (tokens[0].equals("suspend")) {
							cmd = InterfaceThread.COMMAND_SUSPEND;
						} else if (tokens[0].equals("status")) {
							cmd = 0;
						} else {
							ps.println("-> Command " + tokens[0] + " unknown");
							continue;
						}
						// All are interface thread commands
						// Get the interface thread instance first
						if (tokens.length == 1) {
							ps.println("-> Interface not specified");
							continue;
						}
						InterfaceThread it =
							CIFManager.getInterfaceThread(tokens[1], false);
						if (it == null) {
							ps.println("-> Interface " + tokens[1] + " not instantiated");
							continue;
						}
						if (cmd != 0) {
							it.executeCommand(cmd);
							ps.println("-> Command executed");
						} else {
							String status = it.toString();
							ps.print(status);
						}
					}
				}
				closeSocket(client);
			} catch (Exception ex) {
				closeSocket(client);
			}
		}
	}

	private void closeSocket(Socket client) {
		try {
			client.close();
		} catch (Exception exp) {
			//
		}
	}

	private void retryOpenServerSocket() {
		try {
			serverSocket.close();
		} catch (Exception e) {
			// Do not bother
		}

		try {
			serverSocket = new ServerSocket(
								CIFManager.getInstance("CIFManager").getAdminPort());
		} catch (Exception e) {
			// Log
			doNotStop = false;
			try {
				CIFLogger.getInstance().logUrgent("Exception during server socket creation: "
									+ CIFManager.getInstance("*").getAdminPort()
									+ ".  Graceful shutdown in progress.");
				CIFManager.getInstance("CIFManager").shutdown();
			} catch (Exception ex) {
				// Nothing
			}
		}
	}
}
