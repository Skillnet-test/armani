package com.ga.util.txn;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSetMetaData;
import java.sql.Types;
import java.util.ArrayList;

import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cs.dataaccess.CustomerDAO;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class TransactionUtilOracleDAO extends TransactionUtilBaseDAO {
  public TransactionUtilOracleDAO() {
    super();
  }

  /**
   * parseSQLConstraint
   *
   * @param ex SQLException
   * @return String
   * @todo Implement this com.ga.util.txn.TransactionUtilDAO method
   */
  public String parseSQLConstraint(SQLException ex) {
    System.out.println("~~~~~~~~~~~~~~~ ErrorCode=" + ((SQLException) ex).getErrorCode());
    System.out.println("~~~~~~~~~~~~~~~ SQLState=" + ((SQLException) ex).getSQLState());
    System.out.println("~~~~~~~~~~~~~~~ LocalizedMessage=" + ((SQLException) ex).getLocalizedMessage());
    System.out.println("~~~~~~~~~~~~~~~ Message1 =" + ((SQLException) ex).getMessage());
  /*  if (((SQLException) ex).getErrorCode() == 1) {*/
      int startIndex = ex.getMessage().indexOf("(");
      int endIndex = ex.getMessage().indexOf(")");
    /*  System.out.println("startindex " + startIndex);
      System.out.println("endindex " + endIndex);*/
      if (startIndex > -1 && endIndex > startIndex)
        return ex.getMessage().substring(startIndex + 1, endIndex);
    /*}*/
    return null;
  }

  /**
   * getIndexInfo
   *
   * @param constraint String
   * @return ResultSet
   * @todo Implement this com.ga.util.txn.TransactionUtilDAO method
   */
//  public ResultSet getIndexInfo(String constraint) {
//    return null;
//  }

 /* public String getConstraintTableName(String constraint) throws SQLException {
    //select table_name from all_indexes where index_name='<index-name>'
    Statement stmt = getConnection().createStatement();
//    String queryPrefix = "SELECT table_name FROM all_indexes WHERE index_name=";
    String queryPrefix = "SELECT table_name FROM all_constraints WHERE constraint_name =";
    
    String query = queryPrefix+"'"+constraint+"'";
    System.out.println("getConstraintTableName query=> "+query);
    ResultSet rs = stmt.executeQuery(query);
    if(rs.next())
      return rs.getString("table_name");

    //else
    if(constraint.indexOf(".")>-1)
      constraint = constraint.substring(constraint.indexOf(".")+1, constraint.length());
    query = queryPrefix+"'"+constraint+"'";
    System.out.println("getConstraintTableName query=> "+query);
    rs = stmt.executeQuery(query);
    if(rs.next())
      return rs.getString("table_name");

    //else
    return null;
  }*/
  
  public String getConstraintDescription1(String constraint) throws SQLException {
	//	System.out.println("trying to check for foreign key " + constraint);
		if(constraint.indexOf(".")>-1){
			constraint = constraint.substring(constraint.indexOf(".")+1);
		}
		String query = "select  * from vw_constraint_def where cons_name = '"+constraint+"'";
	//	System.out.println("query " + query);
		PreparedStatement stmt = getConnection().prepareStatement(query);
	    
		ArrayList list = new ArrayList();
	    ResultSet rs = stmt.executeQuery(query);
	
	    String consType = null;
	//    System.out.println("before resultset ");
	    while(rs.next()){
	  //  	System.out.println("insidereset set  ");
	    	VwConstraintDef obj = new VwConstraintDef();
	    	obj.setCol1(rs.getString("COL1"));
	    	obj.setConsName(rs.getString("CONS_NAME"));
	    	obj.setConsType(rs.getString("CONS_TYPE"));
	    	consType =rs.getString("CONS_TYPE");
	    	obj.setMainTable(rs.getString("MAIN_TABLE"));
	    	obj.setRefTable(rs.getString("REF_TABLE"));
	    	obj.setTable1(rs.getString("TABLE1"));
	    	list.add(obj);
	    }
	//    System.out.println("constype " + consType);
	    if(consType!=null ){
	    	if(consType.equals("R")){
	    		return getRefIntegrityDesc(list);
	    	}else if(consType.equals("P")){
	    		return getPrimaryKeyDesc(list);
	    	}
	    	
	    }
	    
		return null;
  }
  
  private String getPrimaryKeyDesc(ArrayList list){
	  StringBuffer errorDesc = new StringBuffer();
	  if(list==null || list.size()==0) return null;
	  String table = null;
	  StringBuffer columns = new StringBuffer();
	  for (int i=0;i<list.size();i++){
		  VwConstraintDef obj = (VwConstraintDef)list.get(i);
		  if(table==null){
			  table = obj.getMainTable();
		  }
		  if(i>0){
			  columns.append(",");
		  }
		  columns.append(getColumnDescription(table,obj.getCol1()));
	  }
	  errorDesc.append("A record with same value(s) for ("+columns.toString()+") found in "+getTableDescription(table));
	  return errorDesc.toString();
  }
  
  
  
  private String getRefIntegrityDesc(ArrayList list){
//	  System.out.println("inside getRefIntegrityDesc");
	  String mainTable = null;
	  String refTable = null;
	  String mainTableCol = "";
	  String refTableCol = "";
	  
	  for(int i=0;i<list.size();i++){
		  VwConstraintDef obj = (VwConstraintDef)list.get(i);
		  if(mainTable==null){
			  mainTable = obj.getMainTable();
		  }
		  if(refTable==null){
			  refTable = obj.getRefTable();
		  }
		  if(obj.getTable1().equals(mainTable)){
			  if(mainTableCol!=""){
				  mainTableCol+=",";
			  }
			  mainTableCol+= getColumnDescription(mainTable,obj.getCol1());
		  }
		  if(obj.getTable1().equals(refTable)){
			  if(refTableCol!=""){
				  refTableCol+=",";
			  }
			  refTableCol+= getColumnDescription(refTable,obj.getCol1());
		  }
	  }
/*	  System.out.println("main table " + mainTable);
	  System.out.println("ref table " + refTable);
	  System.out.println("mainTableCol  " + mainTableCol);
	  System.out.println("refTableCol " + refTableCol);
	  */
	  StringBuffer sb  = new StringBuffer();
//	  sb.append(getColumnDescription(refTable, refTableCol) + " not found to link to " + getColumnDescription(mainTable, mainTableCol));
	  sb.append(refTableCol + "  not found to link to " + mainTableCol); 
	  return sb.toString();
  }
  
  
  
  
  
  public String[] getConstraintTableName(String constraint) throws SQLException {
	    //select table_name from all_indexes where index_name='<index-name>'
	    
//	    String queryPrefix = "SELECT table_name FROM all_indexes WHERE index_name=";
	    String query = "select  table_name from all_constraints where constraint_name=" +"'"+constraint+"'"+ "  union select table_name from all_constraints where constraint_name in (select r_constraint_name from all_constraints where constraint_name=" +"'"+constraint+"'"+ ")";
	    
	//    String query = queryPrefix+"'"+constraint+"'";
	    PreparedStatement stmt = getConnection().prepareStatement(query);
	    System.out.println("getConstraintTableName query=> "+query);
	    ResultSet rs = stmt.executeQuery(query);
	    
	    ArrayList tableNames = new ArrayList();
	    while(rs.next()){
	    	tableNames.add(rs.getString("table_name"));
	    }
	    if(tableNames.size()>0){
	    	return (String[])tableNames.toArray(new String[0]);
	    }
	    //else
	    if(constraint.indexOf(".")>-1)
	      constraint = constraint.substring(constraint.indexOf(".")+1, constraint.length());
	    query = "select  table_name from all_constraints where constraint_name=" +"'"+constraint+"'"+ "  union select table_name from all_constraints where constraint_name in (select r_constraint_name from all_constraints where constraint_name=" +"'"+constraint+"'"+ ")";
	    System.out.println("getConstraintTableName query=> "+query);
	    rs = stmt.executeQuery(query);
	    while(rs.next()){
	    	tableNames.add(rs.getString("table_name"));
	    }
	    if(tableNames.size()>0){
	    	return (String[])tableNames.toArray(new String[0]);
	    }
	    //else
	    return null;
	  }
  
  
  
}
