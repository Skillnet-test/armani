package com.ga.util.txn;


import java.sql.*;

import com.chelseasystems.cr.config.ConfigMgr;
import com.chelseasystems.cr.database.connection.ConnectionPool;
import com.chelseasystems.cs.dataaccess.DAOConnectionPool;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import com.chelseasystems.cr.util.ResourceManager;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.Hashtable;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.PrintStream;

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
public abstract class TransactionUtilBaseDAO implements TransactionUtilDAO {

  private ConnectionPool connectionPool;
  private DatabaseMetaData metaData;
  protected static ResourceManager rm = new ResourceManager();
  public static ResourceBundle res = null;


  static {
    rm.setResourceBundle("com.chelseasystems.cs.util.DBMetaBundle");
    res = rm.getResourceBundle();
  }

  /**
   * init
   *
   * @todo Implement this com.ga.util.txn.TransactionUtilDAO method
   */
  public void init() throws SQLException {
    connectionPool = DAOConnectionPool.getPool();
    metaData = getConnection().getMetaData();
  }

  /**
   * getConnection
   *
   * @return Connection
   * @todo Implement this com.ga.util.txn.TransactionUtilDAO method
   */
  public Connection getConnection() throws SQLException {
    return connectionPool.getConnection();
  }


  public ResultSet getIndexInfo(String constraint) throws SQLException {
    String[] tableName = this.getConstraintTableName(constraint);
 //   System.out.println("TABLE_NAME=" + tableName);
    if(tableName!=null){
    	for(int i=0;i<tableName.length;i++){
   // 		System.out.println("Table Name " + tableName[i]);
    	}
    	return metaData.getIndexInfo(null, null, tableName[1], true, false);
    }
    return null;
    //return null;
  }

  public String[] getConstraintColumns(String constraint) throws SQLException {
    ResultSet rs = getIndexInfo(constraint);
    ArrayList columnList = new ArrayList();
    while (rs.next()) {
      String columnName = rs.getString("COLUMN_NAME");
      if (columnName != null && columnName.trim().length() > 0)
        columnList.add(columnName);
  //    System.out.println("COLUMN_NAME="+columnName);
    }
    return (String[]) columnList.toArray(new String[columnList.size()]);
  }

  public String getTableDescription(String table) {
    String tableDesc = res.getString(table);
    if(tableDesc==null || tableDesc.trim().length()==0)
      tableDesc = table;
    else if(!tableDesc.equals(table))
      tableDesc = res.getString(table)+" ("+table+")";
    return tableDesc;
  }

  public String getColumnDescription(String table, String column) {
//	  System.out.println("gettting column description " + table + " " + column);
	  
    String columnDesc = res.getString(table+"."+column);
 //   System.out.println("column desc " + columnDesc);
    if(columnDesc==null || columnDesc.trim().length()==0)
      columnDesc = table+"."+column;
    else if(!columnDesc.equals(table+"."+column))
      columnDesc = res.getString(table+"."+column)+" ("+table+"."+column+")";
    return columnDesc;
  }

  
  
  
  public String getConstraintDescription(String constraint) throws SQLException {
    short type = -1;
    	String msg =  this.getConstraintDescription1(constraint);
   if(msg!=null){
	   return msg;
   }
    String[] tableNames = this.getConstraintTableName(constraint);
    ResultSet rs = getIndexInfo(constraint);
    ArrayList columnList = new ArrayList();
    ArrayList tableList = new ArrayList();
    HashSet uniqueTables = new HashSet();
    while (rs.next()) {
      if(type < 0)
        type = rs.getShort("TYPE");
      String columnName = rs.getString("COLUMN_NAME");
      if (columnName != null && columnName.trim().length() > 0) {
        columnList.add(columnName.trim());
        String tableName = rs.getString("TABLE_NAME");
        if(tableName != null) {
          tableList.add(tableName.trim());
          if(tableName.trim().length() > 0)
            uniqueTables.add(tableName.trim());
        } else {
          tableList.add("");
        }
      /*  System.out.println("TYPE="+type);
        System.out.println("TABLE_NAME="+tableName);
        System.out.println("COLUMN_NAME="+columnName);*/
      }
    }
    String constraintDesc = "";
    String indexTypeDesc = "";
 //   System.out.println("TYPE AGAIN="+type);
    switch (type) {
      case DatabaseMetaData.tableIndexStatistic:
        //indexTypeDesc = "Statistical ";
        constraintDesc = "A record with same value(s) for ";
        for(int i=0; i<columnList.size(); i++) {
          if(i > 0)
            if (i == columnList.size() - 1)
              constraintDesc = constraintDesc + " and ";
            else
              constraintDesc = constraintDesc + ", ";
          constraintDesc = constraintDesc + getColumnDescription((String)tableList.get(i), (String)columnList.get(i));
        }
        constraintDesc = constraintDesc + " already exists in ";
        Iterator iterator = uniqueTables.iterator();
        for(int i=0; iterator.hasNext(); i++) {
          if(i > 0)
            if (i == uniqueTables.size() - 1)
              constraintDesc = constraintDesc + " and ";
            else
              constraintDesc = constraintDesc + ", ";
          constraintDesc = constraintDesc + getTableDescription((String)iterator.next());
        }
        break;
      case DatabaseMetaData.tableIndexClustered:
        indexTypeDesc = "clustered ";
      case DatabaseMetaData.tableIndexHashed:
        indexTypeDesc = "hashed ";
      case DatabaseMetaData.tableIndexOther:
        indexTypeDesc = "";
      default:
        constraintDesc = "The server encountered an error with " + indexTypeDesc + "index " + constraint + "which references ";
        for(int i=0; i<columnList.size(); i++) {
          if(i > 0)
            if (i == columnList.size() - 1)
              constraintDesc = constraintDesc + " and ";
            else
              constraintDesc = constraintDesc + ", ";
          constraintDesc = constraintDesc + getColumnDescription((String)tableList.get(i), (String)columnList.get(i));
        }
        constraintDesc = constraintDesc + " in table ";
        iterator = uniqueTables.iterator();
        for(int i=0; iterator.hasNext(); i++) {
          if(i > 0)
            if (i == uniqueTables.size() - 1)
              constraintDesc = constraintDesc + " and ";
            else
              constraintDesc = constraintDesc + ", ";
          constraintDesc = constraintDesc + getTableDescription((String)iterator.next());
        }
        break;
    }
    return constraintDesc;
  }

  public abstract String getConstraintDescription1(String constraint) throws SQLException;

public void printKeys() {
    Hashtable tableHash = new Hashtable();
    System.out.print("~~~~~~~~~~ in printKeys");
    PrintStream out = null;
    try {
//      ResultSet rs = metaData.getSchemas();
//      while (rs.next()) {
//        System.out.println("~~~~~~~~~~ "+rs.getString("TABLE_SCHEM"));
//      }
//      ResultSet rs = metaData.getTables(null, "ARMANI%", "%", null);
//      while (rs.next()) {
//        System.out.println(rs.getString("TABLE_TYPE")+" "+rs.getString("TABLE_NAME")+" ("+rs.getString("REMARKS")+")");
//      }
      ResultSet rs = metaData.getColumns(null, "ARMANI%", "%", "%");
      out = new PrintStream(new FileOutputStream("keys.txt"));
      while (rs.next()) {
        String tableName = rs.getString("TABLE_NAME");
        String columnName = rs.getString("COLUMN_NAME");
        System.out.println(tableName+"."+columnName);
        if(!tableHash.containsKey(tableName)) {
          tableHash.put(tableName, new ArrayList());
          out.println(tableName);
        }
        ArrayList columnList = (ArrayList)tableHash.get(tableName);
        if(!columnList.contains(columnName)) {
          columnList.add(columnName);
          out.println(tableName+"."+columnName);
        }
      }
    } catch (SQLException ex) {
      ex.printStackTrace();
    } catch (FileNotFoundException ex) {
      ex.printStackTrace();
      /** @todo Handle this exception */
    } finally {
      if(out != null) {
        out.flush();
        out.close();
      }
    }

  }

}
