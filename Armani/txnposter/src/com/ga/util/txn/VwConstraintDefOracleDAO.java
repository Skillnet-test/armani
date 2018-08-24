//
// Copyright 2002, Retek Inc. All Rights Reserved.
//
package com.ga.util.txn;

/////put your import statemants here.
/////
import java.sql.SQLException;

import com.chelseasystems.cs.dataaccess.artsoracle.dao.BaseOracleDAO;
import com.chelseasystems.cs.dataaccess.artsoracle.databean.*;

public class VwConstraintDefOracleDAO extends BaseOracleDAO implements VwConstraintDefDAO {

  private static String selectSql = VwConstraintDefOracleBean.selectSql;

  public VwConstraintDef[] selectByConsType(String consType) throws SQLException {
    String whereSql = "where CONS_TYPE = ?";
    return fromBeansToObjects(query(new VwConstraintDefOracleBean(),selectSql + whereSql, consType));
  }

  public VwConstraintDef[] selectByConsName(String consName) throws SQLException {
    String whereSql = "where CONS_NAME = ?";
    return fromBeansToObjects(query(new VwConstraintDefOracleBean(),selectSql + whereSql, consName));
  }


  //
  //Non public methods begin here!
  //

  protected BaseOracleBean getDatabeanInstance() {
    return new VwConstraintDefOracleBean();
  }

  private VwConstraintDef[] fromBeansToObjects(BaseOracleBean[] beans) {
    VwConstraintDef[] array = new VwConstraintDef[beans.length];
    for (int i = 0; i < array.length; i++) array[i] = fromBeanToObject(beans[i]);
    return array;
  }

  /////this method needs to customized
  private VwConstraintDef fromBeanToObject(BaseOracleBean baseBean) {
    VwConstraintDefOracleBean bean = (VwConstraintDefOracleBean) baseBean;
    VwConstraintDef object = new VwConstraintDef();
    object.setConsType(bean.getConsType());
    object.setConsName(bean.getConsName());
    object.setMainTable(bean.getMainTable());
    object.setRefTable(bean.getRefTable());
    object.setTable1(bean.getTable1());
    object.setCol1(bean.getCol1());
    return object;
  }

  /////these method needs to customized
  private VwConstraintDefOracleBean fromObjectToBean(VwConstraintDef object) {
    VwConstraintDefOracleBean bean = new VwConstraintDefOracleBean();
    bean.setConsType(object.getConsType());
    bean.setConsName(object.getConsName());
    bean.setMainTable(object.getMainTable());
    bean.setRefTable(object.getRefTable());
    bean.setTable1(object.getTable1());
    bean.setCol1(object.getCol1());
    return bean;
  }

}
