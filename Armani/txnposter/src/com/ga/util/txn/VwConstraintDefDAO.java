//
// Copyright 2002, Retek Inc. All Rights Reserved.
//
package com.ga.util.txn;


import java.sql.SQLException;

import com.chelseasystems.cs.dataaccess.BaseDAO;

public interface VwConstraintDefDAO extends BaseDAO {
	public VwConstraintDef[] selectByConsName(String consName) throws SQLException;
}
