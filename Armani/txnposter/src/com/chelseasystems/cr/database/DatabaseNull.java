//
// Copyright 1999-2001, Chelsea Market Systems
//
package com.chelseasystems.cr.database;

import java.sql.Types;
import java.io.Serializable;

public class DatabaseNull implements Serializable {
  private int type;
  public DatabaseNull(int sqlType) { this.type = sqlType; }
  public int getType() { return type; }
  public String toString() { return "Null(" + getTypeCode(type) + ")"; }

  private static String getTypeCode(int type) {
    if (type == Types.ARRAY) return "ARRAY";
    if (type == Types.BIGINT) return "BIGINT";
    if (type == Types.BINARY) return "BINARY";
    if (type == Types.BIT) return "BIT";
    if (type == Types.BLOB) return "BLOB";
    if (type == Types.CHAR) return "CHAR";
    if (type == Types.CLOB) return "CLOB";
    if (type == Types.DATE) return "DATE";
    if (type == Types.DECIMAL) return "DECIMAL";
    if (type == Types.DISTINCT) return "DISTINCT";
    if (type == Types.DOUBLE) return "DOUBLE";
    if (type == Types.FLOAT) return "FLOAT";
    if (type == Types.INTEGER) return "INTEGER";
    if (type == Types.JAVA_OBJECT) return "JAVA_OBJECT";
    if (type == Types.LONGVARBINARY) return "LONGVARBINARY";
    if (type == Types.LONGVARCHAR) return "LONGVARCHAR";
    if (type == Types.NULL) return "NULL";
    if (type == Types.NUMERIC) return "NUMERIC";
    if (type == Types.OTHER) return "OTHER";
    if (type == Types.REAL) return "REAL";
    if (type == Types.REF) return "REF";
    if (type == Types.SMALLINT) return "SMALLINT";
    if (type == Types.STRUCT) return "STRUCT";
    if (type == Types.TIME) return "TIME";
    if (type == Types.TIMESTAMP) return "TIMESTAMP";
    if (type == Types.TINYINT) return "TINYINT";
    if (type == Types.VARBINARY) return "VARBINARY";
    if (type == Types.VARCHAR) return "VARCHAR";
    return "UNKNOW";
  }

}
