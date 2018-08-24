package com.ga.util.txn;


import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;

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
public interface TransactionUtilDAO {

  public void init() throws SQLException;

  public Connection getConnection() throws SQLException;

  public String parseSQLConstraint(SQLException ex);

  public ResultSet getIndexInfo(String constraint) throws SQLException;

  public String[] getConstraintTableName(String constraint) throws SQLException;

  public String[] getConstraintColumns(String constraint) throws SQLException;

  public String getConstraintDescription(String constraint) throws SQLException;
}
