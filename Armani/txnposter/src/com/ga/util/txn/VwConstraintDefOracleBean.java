//
// Copyright 2002, Retek Inc. All Rights Reserved.
//
package com.ga.util.txn;

import java.util.Date;
import java.util.Calendar;
import java.util.List;
import java.util.ArrayList;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Types;
import com.chelseasystems.cr.currency.ArmCurrency;
import com.chelseasystems.cs.dataaccess.artsoracle.databean.BaseOracleBean;

/**
 *
 * This class is an object representation of the Arts database table VW_CONSTRAINT_DEF<BR>
 * Followings are the column of the table: <BR>
 *     CONS_TYPE -- VARCHAR2(1)<BR>
 *     CONS_NAME -- VARCHAR2(30)<BR>
 *     MAIN_TABLE -- VARCHAR2(30)<BR>
 *     REF_TABLE -- VARCHAR2(30)<BR>
 *     TABLE1 -- VARCHAR2(30)<BR>
 *     COL1 -- VARCHAR2(4000)<BR>
 *
 */
public class VwConstraintDefOracleBean extends BaseOracleBean {

  public VwConstraintDefOracleBean() {}

  public static String selectSql = "select CONS_TYPE, CONS_NAME, MAIN_TABLE, REF_TABLE, TABLE1, COL1 from VW_CONSTRAINT_DEF ";
  public static String insertSql = "insert into VW_CONSTRAINT_DEF (CONS_TYPE, CONS_NAME, MAIN_TABLE, REF_TABLE, TABLE1, COL1) values (?, ?, ?, ?, ?, ?)";
  public static String updateSql = "update VW_CONSTRAINT_DEF set CONS_TYPE = ?, CONS_NAME = ?, MAIN_TABLE = ?, REF_TABLE = ?, TABLE1 = ?, COL1 = ? ";
  public static String deleteSql = "delete from VW_CONSTRAINT_DEF ";

  public static String TABLE_NAME = "VW_CONSTRAINT_DEF";
  public static String COL_CONS_TYPE = "VW_CONSTRAINT_DEF.CONS_TYPE";
  public static String COL_CONS_NAME = "VW_CONSTRAINT_DEF.CONS_NAME";
  public static String COL_MAIN_TABLE = "VW_CONSTRAINT_DEF.MAIN_TABLE";
  public static String COL_REF_TABLE = "VW_CONSTRAINT_DEF.REF_TABLE";
  public static String COL_TABLE1 = "VW_CONSTRAINT_DEF.TABLE1";
  public static String COL_COL1 = "VW_CONSTRAINT_DEF.COL1";

  public String getSelectSql() { return selectSql; }
  public String getInsertSql() { return insertSql; }
  public String getUpdateSql() { return updateSql; }
  public String getDeleteSql() { return deleteSql; }

  private String consType;
  private String consName;
  private String mainTable;
  private String refTable;
  private String table1;
  private String col1;

  public String getConsType() { return this.consType; }
  public void setConsType(String consType) { this.consType = consType; }

  public String getConsName() { return this.consName; }
  public void setConsName(String consName) { this.consName = consName; }

  public String getMainTable() { return this.mainTable; }
  public void setMainTable(String mainTable) { this.mainTable = mainTable; }

  public String getRefTable() { return this.refTable; }
  public void setRefTable(String refTable) { this.refTable = refTable; }

  public String getTable1() { return this.table1; }
  public void setTable1(String table1) { this.table1 = table1; }

  public String getCol1() { return this.col1; }
  public void setCol1(String col1) { this.col1 = col1; }

  public BaseOracleBean[] getDatabeans(ResultSet rs) throws SQLException {
    ArrayList list = new ArrayList();
    while(rs.next()) {
      VwConstraintDefOracleBean bean = new VwConstraintDefOracleBean();
      bean.consType = getStringFromResultSet(rs, "CONS_TYPE");
      bean.consName = getStringFromResultSet(rs, "CONS_NAME");
      bean.mainTable = getStringFromResultSet(rs, "MAIN_TABLE");
      bean.refTable = getStringFromResultSet(rs, "REF_TABLE");
      bean.table1 = getStringFromResultSet(rs, "TABLE1");
      bean.col1 = getStringFromResultSet(rs, "COL1");
      list.add(bean);
    }
    return (VwConstraintDefOracleBean[]) list.toArray(new VwConstraintDefOracleBean[0]);
  }

  public List toList() {
    List list = new ArrayList();
    addToList(list, this.getConsType(), Types.VARCHAR);
    addToList(list, this.getConsName(), Types.VARCHAR);
    addToList(list, this.getMainTable(), Types.VARCHAR);
    addToList(list, this.getRefTable(), Types.VARCHAR);
    addToList(list, this.getTable1(), Types.VARCHAR);
    addToList(list, this.getCol1(), Types.VARCHAR);
    return list;
  }

}
