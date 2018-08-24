/**
 * 
 */
package com.ga.util.monitor;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.chelseasystems.cr.config.ConfigMgr;

/**
 * @author Tim
 *
 */
public class ProcessMonitor{
	
	private final String ID = ".ID";
	private final String ERR_CD = ".ERR_CD";
	private final String IMPL = ".IMPL";
	private final String PARAMS = ".PARAMS";
	
	int[] sequence;
	long frequency = 100;
	int count = 1;
	
	public static final String errFile = "..//log//ArmMonitor.err";
	
	private static final ConfigMgr armStatusCfg = new ConfigMgr("checkArmStatus.cfg"); 
	
	List<MonitorOperation> baseOpList = new ArrayList<MonitorOperation>(10);
	List<MonitorOperation> opList = new ArrayList<MonitorOperation>(10);
	
	static Logger logger = Logger.getLogger("com.ga.util.monitor.ProcessMonitor");
	
	public ProcessMonitor(){
		createNewErrorFile();
		init();
	}
	
	private void init(){		
		initOperationList();	
		initOperationSequence();
		
		
		if(armStatusCfg.getString("FREQUENCY")!=null)
			frequency = Long.parseLong(armStatusCfg.getString("FREQUENCY"));
		
		if(armStatusCfg.getString("COUNT") != null){
			count = Integer.parseInt(armStatusCfg.getString("COUNT"));
		}
		
	}

	private void initOperationList() {
		String[] operations = armStatusCfg.getString("OPERATIONS").split(",");
		MonitorOperation mop = null;
		for(int i = 0 ; i<operations.length; i++){
			mop = createMethodOperation(operations[i], i);
			if(mop != null){
				baseOpList.add(mop);
			}
		}
	}

	private void initOperationSequence() {
		String[] seq = armStatusCfg.getString("OP_SEQ").split(",");
		
		sequence = new int[seq.length];
		for(int i=0; i<seq.length; i++){
			sequence[i] = Integer.parseInt(seq[i]);
		}
		
		MonitorOperation mop = null;
		for(int i=0; i<sequence.length; i++){
			mop = getMonitorOperation(sequence[i]);
			if(mop != null){
				opList.add(mop);
			}
		}
	}

	private void createNewErrorFile() {
		File f = new File(errFile);
		if(f.exists()){
			f.delete();
		}
		try {
			f.createNewFile();
		} catch (IOException e) {
			logger.fatal(" ********* Unable to create ERROR File *********");
			logger.debug(e.getMessage(), e);
		}
	}

	private MonitorOperation getMonitorOperation(int id) {
		for(MonitorOperation mop : baseOpList){
			if(mop.getId() == id){
				return mop;
			}
		}
		return null;
	}

	private MonitorOperation createMethodOperation(String operation, int i) {
		MonitorOperation mop = new MonitorOperation();
		try {
			mop.setId(Integer.parseInt(armStatusCfg.getString(operation+ID)));
			mop.setErrCode(Integer.parseInt(armStatusCfg.getString(operation+ERR_CD)));
			mop.setImplementor(armStatusCfg.getString(operation+IMPL));
		} catch (Exception e) {
			logger.warn("Unable to create operation : " + operation, e);
			return null;
		}
		if(armStatusCfg.getString(operation+PARAMS) != null && 
				armStatusCfg.getString(operation+PARAMS).length() != 0){
			System.out.println("PARAMS = " + armStatusCfg.getString(operation+PARAMS));
			mop.setParams(armStatusCfg.getString(operation+PARAMS).split(","));
		}
		
		return mop;
	}
	
	/**
	 * Starts the process monitor and runs the tests as specified in the sequence
	 *
	 */
	public void startMonitor(){
		logger.info("********** Starting tests at " + new Date() + "*****************");
		if(sequence == null || sequence.length == 0){
			return;
		}
		boolean isRunForever = (count == 0);
		for(int i = 0; isRunForever || i<count; i++){
			logger.info("*************   Running iteration : " + i + " ****************");
			runTests();
			try {
				Thread.sleep(frequency);
			} catch (InterruptedException e) {
				logger.debug(e.getMessage(), e);
			}
		}
		
		logger.info("======================= DONE WITH TESTS ======================");		
	}

	private void runTests() {
		int errCode = 0;
		for(MonitorOperation mop : opList){
			errCode = 0;
			try {
				System.out.println("Implementor : " + mop.getImplementor());
				IMonitor monitor = (IMonitor)Class.forName(mop.getImplementor()).newInstance();
				if(mop.hasTestParams()){
					errCode = monitor.runTest(mop.getErrCode(), mop.getParams());
				} else{
					errCode = monitor.runTest(mop.getErrCode());
				}
				
				System.out.println(" Error code = " + errCode);
			} catch (InstantiationException e) {
				logger.error("Unable to execute test : " + mop.getId(), e);
			} catch (IllegalAccessException e) {
				logger.error("Unable to execute test : " + mop.getId(), e);
			} catch (ClassNotFoundException e) {
				logger.error("Unable to execute test : " + mop.getId(), e);
			}
			
			if(errCode != 0){
				handleError(errCode);				
				System.exit(0);
			}
		}
	}

	private void handleError(int errCode) {
		logger.fatal(" ERROR RECEIVED =====> Code = " + errCode);
		BufferedWriter bw = null;
		try {
			
			 bw = new BufferedWriter(new FileWriter(errFile));
			 bw.write(errCode+"");
		} catch (IOException e) {
			logger.debug(e.getMessage(), e);
		} finally{
			try {
				if(bw != null)
					bw.close();
			} catch (IOException e) {
				logger.debug(e.getMessage(), e);
			}
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		PropertyConfigurator.configure("." + File.separator + "log4j.properties");
		
		ProcessMonitor procMon = new ProcessMonitor();
		procMon.startMonitor();
		
		System.exit(0);
	}
}
