/*
 * @copyright (c) 1999-2002 Retek Inc.
 */
package com.chelseasystems.cr.database;

import java.util.*;
import java.sql.*;
import com.chelseasystems.cr.database.connection.*;
import com.chelseasystems.cr.config.*;
import java.io.Serializable;

public class ParametricStatement implements Serializable {

  private static boolean dedug_mode = false;
  static {
    try {
      ConfigMgr jdbcConfig = new ConfigMgr("jdbc.cfg");
      String verboseOrNot = jdbcConfig.getString("JDBC_VERBOSE");
      dedug_mode = verboseOrNot.equals("true");
    } catch (Exception e) {
    }
  }

  private String sqlStatement = null;
  private List parameters = null;

  public ParametricStatement(String sqlStatement, List parameters) {
    this.sqlStatement = sqlStatement;
    this.parameters = parameters;
  }

  public String getSqlStatement() { return this.sqlStatement; }
  public List getParameters() { return this.parameters; }

  public void execute(ConnectionPool connectionPool) throws SQLException {
    if (dedug_mode) System.out.println("Executing: " + this);
    Connection connection = null;
    PreparedStatement pStatement = null;
    try {
      connection = connectionPool.getConnection();
      pStatement = connection.prepareStatement(this.getSqlStatement());
      this.setupPreparedStatement(pStatement);
      pStatement.execute();
      pStatement.close();
      connection.commit();
    } catch (SQLException exp) {
      try {
        if (connection != null) {
          connection.rollback();
        }
        else
          throw  exp;
      } catch (SQLException e) {
      }
      try {
        if (connection != null) {
          connection = connectionPool.renewConnection(connection);
          pStatement = connection.prepareStatement(this.getSqlStatement());
          this.setupPreparedStatement(pStatement);
          pStatement.execute();
          pStatement.close();
          connection.commit();
        }
        else
          throw  exp;
      } catch(SQLException se) {
        if (connection != null) {
          connection.rollback();
        }
        if (pStatement != null) {
          pStatement.close();
        }
        if (connection != null) {
          connectionPool.releaseConnection(connection);
        }
        throw se;
      }
    } finally {
      if (connectionPool != null)
        connectionPool.releaseConnection(connection);
    }
  }

  public PreparedStatement getQueryPreparedStatement(Connection connection) throws SQLException {
    PreparedStatement preparedStatement = connection.prepareStatement(this.sqlStatement);
    this.setupPreparedStatement(preparedStatement);
    return preparedStatement;
  }

  protected void setupPreparedStatement(PreparedStatement pStatement) throws SQLException {
    List param = this.getParameters();
    if (param == null || param.size() == 0) return;
    for (int i = 0; i < param.size(); i++) {
      Object obj = param.get(i);
      if (obj instanceof DatabaseNull) {
        pStatement.setNull(i + 1, ((DatabaseNull)obj).getType());
      } else {
        if (obj instanceof java.util.Date) obj = new Timestamp(((java.util.Date)obj).getTime());
        pStatement.setObject(i + 1, obj);
      }
    }
  }

  public String toString() {
    if (sqlStatement == null) return "[NULL SQL statement String]";
    StringBuffer sb = new StringBuffer(sqlStatement);
    if (parameters != null)
      for (Iterator it = parameters.iterator(); it.hasNext();) {
    sb.append("[");
    sb.append(it.next().toString());
    sb.append("]");
      }
      sb.append("\n=======================");
      return sb.toString();
  }
}
