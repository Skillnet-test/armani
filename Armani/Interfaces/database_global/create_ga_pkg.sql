CREATE OR REPLACE PACKAGE Arm_Load_Data_ext_Pkg IS
------------------------------------------------------------------------------------------------
-- This package is extension to load data from the staging tables into the base tables.
-- Written By: Meghdeep Raval
-- 06/21/2005
------------------------------------------------------------------------------------------------

l_success VARCHAR2(10) := '0' ;
l_failure VARCHAR2(10) := '1' ;


  -- Following procedure loads DEPT.
  PROCEDURE load_dept
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );


  -- Following procedure loads class.
  PROCEDURE load_class
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure subclass.
  PROCEDURE load_subclass
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure sups.
  PROCEDURE load_sups
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure COLOR.
  PROCEDURE load_COLOR
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure SEASON.
  PROCEDURE load_SEASON
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

  -- Following procedure sups.
  PROCEDURE load_SIZE
  (
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

END Arm_Load_Data_ext_Pkg;
/

CREATE OR REPLACE PACKAGE BODY Arm_Load_Data_ext_Pkg IS
------------------------------------------------------------------------------------------------
-- Package body --
------------------------------------------------------------------------------------------------

bulk_errors EXCEPTION;
PRAGMA EXCEPTION_INIT ( bulk_errors, -24381 );

-------------------------------------------------------------------------------------
-- Load Dept
-------------------------------------------------------------------------------------
PROCEDURE load_dept
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_dept WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO id_dpt_ps DESTINATION
		USING (SELECT ID_DPT_POS, NM_DPT_POS , ID_DPT_POS_PRNT
		FROM ARM_STG_DEPT) SOURCE
		ON (DESTINATION.ID_DPT_POS=SOURCE.ID_DPT_POS)
		WHEN MATCHED THEN
			UPDATE SET NM_DPT_POS=SOURCE.NM_DPT_POS,
				   ID_DPT_POS_PRNT=SOURCE.ID_DPT_POS_PRNT
		WHEN NOT MATCHED THEN
			INSERT (ID_DPT_POS , NM_DPT_POS , ID_DPT_POS_PRNT)
			VALUES
			(SOURCE.ID_DPT_POS, SOURCE.NM_DPT_POS, SOURCE.ID_DPT_POS_PRNT);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_DEPT
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_DEPT;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_dept;


-------------------------------------------------------------------------------------
-- Load Class
-------------------------------------------------------------------------------------
PROCEDURE load_class
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_class WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_CLASS DESTINATION
		USING (SELECT ID_DPT, ID_CLSS , NM_CLSS
		FROM ARM_STG_CLASS) SOURCE
		ON (DESTINATION.ID_DPT=SOURCE.ID_DPT
	        AND DESTINATION.ID_CLSS=SOURCE.ID_CLSS)
		WHEN MATCHED THEN
			UPDATE SET NM_CLSS=SOURCE.NM_CLSS
		WHEN NOT MATCHED THEN
			INSERT (ID_DPT, ID_CLSS , NM_CLSS)
			VALUES
			(SOURCE.ID_DPT, SOURCE.ID_CLSS , SOURCE.NM_CLSS);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_CLASS
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_CLASS;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_class;


-------------------------------------------------------------------------------------
-- Load subClass
-------------------------------------------------------------------------------------
PROCEDURE load_subclass
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_subclass WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_SUBCLASS DESTINATION
		USING (SELECT ID_DPT, ID_CLSS , ID_SBCL, NM_SBCL
		FROM ARM_STG_SUBCLASS) SOURCE
		ON (DESTINATION.ID_DPT=SOURCE.ID_DPT
	        AND DESTINATION.ID_CLSS=SOURCE.ID_CLSS
		AND DESTINATION.ID_SBCL=SOURCE.ID_SBCL)
		WHEN MATCHED THEN
			UPDATE SET NM_SBCL=SOURCE.NM_SBCL
		WHEN NOT MATCHED THEN
			INSERT (ID_DPT, ID_CLSS , ID_SBCL, NM_SBCL)
			VALUES
			(SOURCE.ID_DPT, SOURCE.ID_CLSS , SOURCE.ID_SBCL,SOURCE.NM_SBCL);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_SUBCLASS
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_SUBCLASS;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_SUBclass;

-------------------------------------------------------------------------------------
-- Load sups
-------------------------------------------------------------------------------------
PROCEDURE load_sups
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_SPR WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_SPR DESTINATION
		USING (SELECT ID_SPR, NM_SPR
		FROM ARM_STG_SPR) SOURCE
		ON (DESTINATION.ID_SPR=SOURCE.ID_SPR)
		WHEN MATCHED THEN
			UPDATE SET NM_SPR=SOURCE.NM_SPR
		WHEN NOT MATCHED THEN
			INSERT (ID_SPR, NM_SPR)
			VALUES
			(SOURCE.ID_SPR, SOURCE.NM_SPR);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_SPR
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_SPR;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_sups;



-------------------------------------------------------------------------------------
-- Load color
-------------------------------------------------------------------------------------
PROCEDURE load_color
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_COLOR WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_COLOR DESTINATION
		USING (SELECT ID_COLOR, DE_COLOR
		FROM ARM_STG_COLOR) SOURCE
		ON (DESTINATION.ID_COLOR=SOURCE.ID_COLOR)
		WHEN MATCHED THEN
			UPDATE SET DE_COLOR=SOURCE.DE_COLOR
		WHEN NOT MATCHED THEN
			INSERT (ID_COLOR, DE_COLOR)
			VALUES
			(SOURCE.ID_COLOR, SOURCE.DE_COLOR);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_COLOR
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_SPR;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_color;


-------------------------------------------------------------------------------------
-- Load season
-------------------------------------------------------------------------------------
PROCEDURE load_season
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_SEASON WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_SEASON DESTINATION
		USING (SELECT ID_SEASON, DE_SEASON, ED_CO, ED_LA
		FROM ARM_STG_SEASON) SOURCE
		ON (DESTINATION.ID_SEASON=SOURCE.ID_SEASON)
		WHEN MATCHED THEN
			UPDATE SET DE_SEASON=SOURCE.DE_SEASON
		WHEN NOT MATCHED THEN
			INSERT (ID_SEASON, DE_SEASON,ED_CO,ED_LA)
			VALUES
			(SOURCE.ID_SEASON, SOURCE.DE_SEASON, SOURCE.ED_CO, SOURCE.ED_LA);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_SEASON
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_SEASON;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_season;



-------------------------------------------------------------------------------------
-- Load sups
-------------------------------------------------------------------------------------
PROCEDURE load_size
(
        in_interface_key  IN  VARCHAR2
      , in_start_time     IN  VARCHAR2
      , in_file_name      IN  VARCHAR2
      , return_status  OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
	l_return_message VARCHAR2(255) := NULL;
	l_return_status VARCHAR2(1) := '0';
	l_num_records_processed NUMBER := 0;
BEGIN
	l_return_status := '0';

	-- Count No# of records need to process
	BEGIN
		SELECT COUNT(*) INTO l_num_records_processed FROM ARM_STG_SIZE WHERE NVL(STG_STATUS,0) IN (0,2);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			l_num_records_processed := 0;
	END;

	--- Main Cursor Loop
	BEGIN
		MERGE INTO ARM_SIZE DESTINATION
		USING (SELECT ID_SIZE, DE_SIZE,SIZE_INDEX,EXT_SIZE_INDEX,ED_CO, ED_LA
		FROM ARM_STG_SIZE) SOURCE
		ON (DESTINATION.ID_SIZE=SOURCE.ID_SIZE
                AND DESTINATION.SIZE_INDEX=SOURCE.SIZE_INDEX
		AND DESTINATION.ED_CO = SOURCE.ED_CO
		AND DESTINATION.ED_LA = SOURCE.ED_LA)
		WHEN MATCHED THEN
			UPDATE SET DE_SIZE=SOURCE.DE_SIZE
		WHEN NOT MATCHED THEN
			INSERT (ID_SIZE, DE_SIZE, SIZE_INDEX,EXT_SIZE_INDEX, ED_CO, ED_LA)
			VALUES
			(SOURCE.ID_SIZE, SOURCE.DE_SIZE, SOURCE.SIZE_INDEX, SOURCE.EXT_SIZE_INDEX,
			 SOURCE.ED_CO,   SOURCE.ED_LA);
	EXCEPTION
		WHEN OTHERS THEN
			l_return_status := '1';
			l_return_message := return_message || ',' || substr(SQLERRM, 1, 200);
	END;

	---- Show error or remove table
	if l_return_status = 1 then
		UPDATE ARM_STG_SIZE
		SET   STG_STATUS = l_return_status,
		STG_ERROR_MESSAGE = l_return_message,
		STG_PROCESS_DATE = SYSDATE;
	else
	        DELETE from ARM_STG_SIZE;
	end if;

	    BEGIN
		INSERT INTO ARM_PROCESS_LOG
		(
		      interface_key
		    , start_time
		    , end_time
		    , status
		    , record_num
		    , file_name
		)
		VALUES
		(
		      in_interface_key
		    , TO_DATE(in_start_time, 'YYYYMMDDHH24:MI:SS')
		    , SYSDATE
		    , l_return_status
		    , l_num_records_processed
		    , in_file_name
		);
	    END;

	commit;
	return_status := l_return_status;
	return_message := l_return_message;
END load_size;

end Arm_Load_Data_ext_Pkg;
/

