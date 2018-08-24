CREATE OR REPLACE PACKAGE Arm_Load_Item_Pkg AS
	TYPE tran_type_type IS TABLE OF ARM_STG_ITEM.tran_type%TYPE;
	TYPE start_date_type IS TABLE OF ARM_STG_ITEM.start_date%TYPE;
	TYPE start_time_type IS TABLE OF ARM_STG_ITEM.start_time%TYPE;
	TYPE end_date_type IS TABLE OF ARM_STG_ITEM.end_date%TYPE;
	TYPE end_time_type IS TABLE OF ARM_STG_ITEM.end_time%TYPE;
	TYPE store_id_type IS TABLE OF ARM_STG_ITEM.store_id%TYPE;
	TYPE item_type IS TABLE OF ARM_STG_ITEM.item%TYPE;
	TYPE ref_item_type IS TABLE OF ARM_STG_ITEM.ref_item%TYPE;
	TYPE barcode_type IS TABLE OF ARM_STG_ITEM.barcode%TYPE;
	TYPE dept_type IS TABLE OF ARM_STG_ITEM.dept%TYPE;
	TYPE class_type IS TABLE OF ARM_STG_ITEM.CLASS%TYPE;
	TYPE sub_class_type IS TABLE OF ARM_STG_ITEM.sub_class%TYPE;
	TYPE new_price_type IS TABLE OF ARM_STG_ITEM.new_price%TYPE;
	TYPE old_price_type IS TABLE OF ARM_STG_ITEM.old_price%TYPE;
	TYPE currency_type IS TABLE OF ARM_STG_ITEM.currency%TYPE;
	TYPE taxable_ind_type IS TABLE OF ARM_STG_ITEM.taxable_ind%TYPE;
	--TYPE vat_rate_type IS TABLE OF ARM_STG_ITEM.vat_rate%TYPE;
	TYPE vat_rate_type IS TABLE OF NUMBER;
	TYPE vat_code_type IS TABLE OF ARM_STG_ITEM.vat_code%TYPE;
	TYPE year_type IS TABLE OF ARM_STG_ITEM.YEAR%TYPE;
	TYPE season_type IS TABLE OF ARM_STG_ITEM.season%TYPE;
	TYPE brand_type IS TABLE OF ARM_STG_ITEM.brand%TYPE;
	TYPE label_type IS TABLE OF ARM_STG_ITEM.label%TYPE;
	TYPE subline_type IS TABLE OF ARM_STG_ITEM.subline%TYPE;
	TYPE gender_type IS TABLE OF ARM_STG_ITEM.gender%TYPE;
	TYPE category_type IS TABLE OF ARM_STG_ITEM.category%TYPE;
	TYPE item_drop_type IS TABLE OF ARM_STG_ITEM.item_drop%TYPE;
	TYPE variant_type IS TABLE OF ARM_STG_ITEM.variant%TYPE;
	TYPE size_id_type IS TABLE OF ARM_STG_ITEM.size_id%TYPE;
	TYPE size_index_type IS TABLE OF ARM_STG_ITEM.size_index%TYPE;
	TYPE size_index_1_type IS TABLE OF ARM_STG_ITEM.size_index_1%TYPE;
	TYPE supplier_type IS TABLE OF ARM_STG_ITEM.supplier%TYPE;
	TYPE model_type IS TABLE OF ARM_STG_ITEM.model%TYPE;
	TYPE fabric_type IS TABLE OF ARM_STG_ITEM.fabric%TYPE;
	TYPE color_type IS TABLE OF ARM_STG_ITEM.color%TYPE;
	TYPE product_type IS TABLE OF ARM_STG_ITEM.product%TYPE;
	TYPE style_num_type IS TABLE OF ARM_STG_ITEM.style_num%TYPE;
	TYPE promotion_num_type IS TABLE OF ARM_STG_ITEM.promotion_num%TYPE;
	TYPE manual_price_entry_type IS TABLE OF ARM_STG_ITEM.manual_price_entry%TYPE;
	TYPE status_type IS TABLE OF ARM_STG_ITEM.status%TYPE;
	TYPE stg_event_id_type IS TABLE OF ARM_STG_CURRENCY_RT.stg_event_id%TYPE;
	TYPE description_type IS TABLE OF ARM_STG_ITEM.description%TYPE;
	TYPE country_cd_type IS TABLE OF PA_PRTY.ed_co%TYPE;
	TYPE language_cd_type IS TABLE OF PA_PRTY.ed_la%TYPE;
	TYPE item_rec_type IS RECORD (
	      tran_type tran_type_type
	    , start_date start_date_type
	    , start_time start_time_type
	    , end_date end_date_type
	    , end_time end_time_type
	    , store_id store_id_type
	    , item item_type
	    , ref_item ref_item_type
	    , barcode barcode_type
	    , dept dept_type
	    , CLASS class_type
	    , sub_class sub_class_type
	    , new_price new_price_type
	    , old_price old_price_type
	    , currency currency_type
	    , taxable_ind taxable_ind_type
	    , vat_rate vat_rate_type
	    , vat_code vat_code_type
	    , YEAR year_type
	    , season season_type
	    , brand brand_type
	    , label label_type
	    , subline subline_type
	    , gender gender_type
	    , category category_type
	    , item_drop item_drop_type
	    , variant variant_type
		, size_id size_id_type
	    , size_index size_index_type
	    , size_index_1 size_index_1_type
	    , supplier supplier_type
	    , model model_type
	    , fabric fabric_type
	    , color color_type
	    , product product_type
	    , style_num style_num_type
	    , promotion_num promotion_num_type
	    , manual_price_entry manual_price_entry_type
	    , status status_type
	    , stg_event_id stg_event_id_type
	    , description description_type
	);
	    errors NUMBER;
	    dml_errors EXCEPTION;

	    PRAGMA EXCEPTION_INIT(dml_errors, -24381);
	  -- Following procedure loads items.
FUNCTION LOAD_ITEM(in_interface_key IN VARCHAR2
                  , in_start_time 	 IN VARCHAR2
                  , in_file_name 	 IN  VARCHAR2)
RETURN INTEGER;


PROCEDURE process_tran(l_tran_type IN VARCHAR2, l_total_records_processed
OUT NUMBER, return_code OUT VARCHAR2);

PROCEDURE purge_processed_data;

FUNCTION process_tran_0
	(
		item_rec item_rec_type
	) RETURN INTEGER;
	FUNCTION process_tran_1
	(
		item_rec item_rec_type
	) RETURN INTEGER;

	FUNCTION process_tran_2
	(
		item_rec item_rec_type
	) RETURN INTEGER;
	FUNCTION process_tran_3_4_5
	(
		item_rec item_rec_type
	) RETURN INTEGER;

	FUNCTION process_tran_6_7_9
	(
		item_rec item_rec_type,
		tran_type VARCHAR2
	) RETURN INTEGER;
	FUNCTION process_tran_8
	(
		item_rec item_rec_type
	) RETURN INTEGER;
	FUNCTION process_tran_10
	(
		item_rec item_rec_type
	) RETURN INTEGER;
	FUNCTION process_tran_11
	(
		item_rec item_rec_type
	) RETURN INTEGER;
END Arm_Load_Item_Pkg;
/
CREATE OR REPLACE PACKAGE BODY Arm_Load_Item_Pkg AS

	FUNCTION LOAD_ITEM(in_interface_key IN VARCHAR2
	                  , in_start_time 	 IN VARCHAR2
	                  , in_file_name 	 IN  VARCHAR2)
	RETURN INTEGER
	IS
		return_code   			 PLS_INTEGER := 0;
		status					 VARCHAR2(1)	 := '0';
		l_processed_records		 NUMBER		 := 0;
		total_processed_records	 NUMBER		 := 0;
		TYPE T_Tran_Type_List IS VARRAY(12) OF NUMBER;
		tran_list T_Tran_Type_List := T_Tran_Type_List(0,1,2,3,4,5,6,7,8,9,10,11);
	BEGIN
			FOR i IN 1.. tran_list.COUNT LOOP
				process_tran(tran_list(i), l_processed_records, return_code);
				total_processed_records := total_processed_records + l_processed_records;
				l_processed_records := 0;
				IF (return_code = 1) THEN
				   status := '1';
				END IF;
				COMMIT;
			END LOOP;
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
		             , status
		             , NVL(total_processed_records,0)
		             , in_file_name
		         );
		 	END;
			RETURN status;
	END LOAD_ITEM;
	
	PROCEDURE purge_processed_data
	IS
	BEGIN
	  DELETE arm_stg_item
	  WHERE stg_status IN (1)
	  AND stg_process_date IS NOT NULL;
	EXCEPTION
			 WHEN dml_errors THEN
			 	  dbms_output.put_line('Error deleting table <ARM_STG_ITEM>');
	END purge_processed_data;
	
	
	PROCEDURE process_tran(l_tran_type IN VARCHAR2, l_total_records_processed
	OUT NUMBER, return_code OUT VARCHAR2)
	IS
	  CURSOR item_cur
		IS
		SELECT   asi.tran_type
		       , asi.start_date
		       , asi.start_time
		       , asi.end_date
		       , asi.end_time
		       , asi.store_id
		       , asi.item
		       , asi.ref_item
		       , asi.barcode
		       , asi.dept
		       , asi.CLASS
		       , asi.sub_class
		       , asi.new_price
		       , asi.old_price
		       , asi.currency
		       , asi.taxable_ind
		       , asi.vat_rate
		       , asi.vat_code
		       , asi.YEAR
		       , asi.season
		       , asi.brand
		       , asi.label
		       , asi.subline
		       , asi.gender
		       , asi.category
		       , asi.item_drop
		       , asi.variant
			   , asi.SIZE_ID
		       , asi.size_index
		       , asi.size_index_1
		       , asi.supplier
		       , asi.model
		       , asi.fabric
		       , asi.color
		       , asi.product
		       , asi.style_num
		       , asi.promotion_num
		       , asi.manual_price_entry
		       , asi.stg_event_id
		       , asi.description
		       , asi.status
		FROM     arm_stg_item asi
		WHERE  ((NVL(asi.stg_status, 0) = 0 AND stg_process_date IS NULL) OR
		(stg_status=2 AND stg_process_date IS NOT NULL))
		AND    asi.tran_type = l_tran_type;
		item_rec 			 item_rec_type;
		errors 				 PLS_INTEGER;
		dml_errors 			 EXCEPTION;
		l_cnt 				 PLS_INTEGER := 0;
	    ret_code 			 PLS_INTEGER := 0;
		l_return_status  VARCHAR2(10);
		l_return_message VARCHAR2(255);
	BEGIN
		l_total_records_processed := 0;
	    OPEN item_cur;
		LOOP
	            FETCH item_cur BULK COLLECT
	            INTO  item_rec.tran_type, item_rec.start_date,
			  item_rec.start_time, item_rec.end_date, item_rec.end_time,
	                  item_rec.store_id, item_rec.item, item_rec.ref_item,
			  item_rec.barcode, item_rec.dept, item_rec.CLASS,
	                  item_rec.sub_class, item_rec.new_price,
			  item_rec.old_price, item_rec.currency, item_rec.taxable_ind,
	                  item_rec.vat_rate, item_rec.vat_code, item_rec.YEAR,
		          item_rec.season, item_rec.brand, item_rec.label,
	                  item_rec.subline, item_rec.gender, item_rec.category,
			  item_rec.item_drop, item_rec.variant, item_rec.size_id, item_rec.size_index,
	                  item_rec.size_index_1, item_rec.supplier, item_rec.model,
		          item_rec.fabric, item_rec.color,item_rec.product,
	                  item_rec.style_num, item_rec.promotion_num,
			  item_rec.manual_price_entry, item_rec.stg_event_id, item_rec.description,
			  item_rec.status
	            LIMIT 500;
			l_total_records_processed := l_total_records_processed +
							NVL(item_rec.item.COUNT,0);
			IF (item_rec.item.COUNT > 0) THEN
			    CASE
				WHEN (l_tran_type IN (0)) THEN
					return_code :=	process_tran_0(item_rec);
				WHEN (l_tran_type IN (1)) THEN
					ret_code := process_tran_1(item_rec);
				WHEN (l_tran_type IN (2)) THEN
					ret_code := process_tran_2(item_rec);
				WHEN (l_tran_type IN (3, 4, 5)) THEN
					ret_code := process_tran_3_4_5(item_rec);
				WHEN (l_tran_type IN (6, 7, 9)) THEN
					ret_code := process_tran_6_7_9(item_rec, l_tran_type);
				WHEN (l_tran_type IN (8)) THEN
					ret_code := process_tran_8(item_rec);
				WHEN (l_tran_type IN (10)) THEN
					ret_code := process_tran_10(item_rec);
				WHEN (l_tran_type IN (11)) THEN
					ret_code := process_tran_11(item_rec);
				END CASE;
				IF (ret_code = 1) THEN
				   return_code := 1;
				END IF;
			END IF;
			    COMMIT;
			    EXIT WHEN item_cur%NOTFOUND;
		    END LOOP;
	   CLOSE item_cur;
	  COMMIT;
	END process_tran;
	
	FUNCTION process_tran_0(item_rec item_rec_type)
		RETURN INTEGER
	IS
		l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;
		BEGIN
		    BEGIN
				FORALL i IN 1 .. item_rec.item.COUNT SAVE EXCEPTIONS
				      MERGE INTO ARM_COLOR DESTINATION
				      USING (SELECT   item_rec.color(i) color
					     FROM   dual WHERE item_rec.color(i) IS NOT NULL) source
				      ON (destination.id_color = source.color)
				      WHEN MATCHED THEN
				      UPDATE SET   de_color = NVL(de_color, source.color)
				      WHEN NOT MATCHED THEN
				      INSERT (
					   id_color
					 , de_color
				      )
				      VALUES (
					   source.color
					 , source.color
				      );
		    EXCEPTION
			    WHEN dml_errors THEN
			    errors := SQL%BULK_EXCEPTIONS.COUNT;
			    l_cnt := l_cnt + errors;
				return_code := 1;
			    FOR i IN 1..errors LOOP
					error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
					error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
					IF (error_code <> 1) THEN
						UPDATE arm_stg_item
						SET      stg_status = 1
						, stg_error_message = ' Error MERGING ARM_COLOR - ' ||error_code
									 , stg_process_date = SYSDATE
						WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END IF;
			    END LOOP;
			END;
	
	
			BEGIN
			    FORALL i IN 1 .. item_rec.item.COUNT SAVE EXCEPTIONS
	 		      MERGE INTO AS_ITM DESTINATION
			      USING (SELECT   item_rec.item(i) item
									, item_rec.ref_item(i) parent_item
					    , item_rec.barcode(i) barcode
					    , item_rec.description(i) description
					    --, item_rec.long_desc(i) long_desc
					    , item_rec.dept(i)  dept
					    , item_rec.CLASS(i)  CLASS
					    , item_rec.sub_class(i) sub_class
					    , item_rec.YEAR(i) YEAR
					    , item_rec.season(i) season
					    , item_rec.brand(i) brand
					    , item_rec.label(i) label
					    , item_rec.subline(i) subline
					    , item_rec.gender(i) gender
					    , item_rec.category(i) category
					    , item_rec.item_drop(i) item_drop
					    , item_rec.variant(i) variant
						, item_rec.size_id(i) size_id
					    , item_rec.size_index(i) size_index
					    , item_rec.size_index_1(i) size_index_1
					    , item_rec.supplier(i) supplier
					    , item_rec.model(i) model
					    , item_rec.fabric(i) fabric
					    , item_rec.color(i) color
					    , item_rec.product(i) product
					    , item_rec.style_num(i) style_num
				     FROM   dual) source
			      ON (destination.id_itm = source.item)
			      WHEN MATCHED THEN
			      UPDATE SET   barcode = source.barcode
					 , nm_itm = source.description
					 , id_dpt_pos = source.dept
					 , id_clss = source.CLASS
					 , id_sbcl = source.sub_class
					 , fy = source.YEAR
					 , lu_sn = source.season
					 , id_brn = source.brand
					 , label = source.label
					 , subline = source.subline
					 , gender = source.gender
					 , category = source.category
					 , item_drop = source.item_drop
					 , variant = source.variant
					 , id_size = source.size_id
					 , size_index = source.size_index
					 , id_kids_size = source.size_index_1
					 , id_spr = source.supplier
					 , model = source.model
					 , fabric = source.fabric
					 , id_color = source.color
					 , product_num = source.product
					 , style_num = source.style_num
			      WHEN NOT MATCHED THEN
			      INSERT (
				   id_itm
				 , id_prt_itm
				 , barcode
				 , nm_itm
				 , id_dpt_pos
				 , id_clss
				 , id_sbcl
				 , fy
				 , lu_sn
				 , id_brn
				 , label
				 , subline
				 , gender
				 , category
				 , item_drop
				 , variant
				 , id_size
				 , size_index
				 , id_kids_size
				 , id_spr
				 , model
				 , fabric
				 , id_color
				 , product_num
				 , style_num
			      )
			      VALUES (
				   source.item
				 , source.parent_item
				 , source.barcode
				 , source.description
				 , source.dept
				 , source.CLASS
				 , source.sub_class
				 , source.YEAR
				 , source.season
				 , source.brand
				 , source.label
				 , source.subline
				 , source.gender
				 , source.category
				 , source.item_drop
				 , source.variant
				 , source.size_id
				 , source.size_index
				 , source.size_index_1
				 , source.supplier
				 , source.model
				 , source.fabric
				 , source.color
				 , source.product
				 , source.style_num
			      );
	         EXCEPTION
			    WHEN dml_errors THEN
			    errors := SQL%BULK_EXCEPTIONS.COUNT;
			    l_cnt := l_cnt + errors;
				return_code := 1;
			    FOR i IN 1..errors LOOP
					error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
					error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
					IF (error_code <> 1) THEN
						UPDATE arm_stg_item
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING
	AS_ITM - ' || error_code
									 , stg_process_date = SYSDATE
						WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END IF;
			    END LOOP;
			END;
	
			BEGIN
			  FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
				MERGE INTO AS_ITM_RTL_STR destination
				USING (SELECT   item_rec.item(i) item
					    , item_rec.start_date(i) start_date
					    , item_rec.vat_code(i) vat_code
					    , item_rec.taxable_ind(i) taxable_ind
					    , item_rec.currency(i) currency
					    , item_rec.currency(i)||item_rec.new_price(i) new_price
					    , item_rec.store_id(i) store_id
					    , item_rec.description(i) description
				     FROM   dual) source
				ON (destination.id_itm = source.item AND destination.id_str_rt =
	source.store_id)
				WHEN MATCHED THEN
				UPDATE SET   dc_prc_ef_prn_rt = TO_DATE(source.start_date,'YYYYMMDD')
					 , rp_pr_sls     = TO_CHAR(source.new_price)
					 , currency_code = source.currency
					 , lu_exm_tx     = source.taxable_ind
					 , cd_vat        = source.vat_code
					 , update_dt     = TO_DATE(source.start_date,'YYYYMMDD')
					 , nm_itm        = source.description
				WHEN NOT MATCHED THEN
				INSERT (
				    dc_prc_ef_prn_rt
				  , id_str_rt
				  , id_itm
				  , rp_pr_sls
				  , currency_code
				  , lu_exm_tx
				  , cd_vat
				  , update_dt
				  , nm_itm
				)
				VALUES (
				   TO_DATE(source.start_date,'YYYYMMDD')
				 , source.store_id
				 , source.item
				 , source.new_price
				 , source.currency
				 , source.taxable_ind
				 , source.vat_code
				 , TO_DATE(source.start_date,'YYYYMMDD')
				 , source.description
				);
	     EXCEPTION
			WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
	--- check
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					     ,stg_error_message = stg_error_message  || '|' || ' Error MERGING
	TABLE <AS_ITM_RTL_STR> - ' || error_code
	    				 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
	            END LOOP;
		 END;
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
			  	  UPDATE ARM_ITM_HIST
				  SET EXPIRATION_DT=TO_DATE(item_rec.start_date(i),'YYYYMMDD')
				  WHERE ID_ITM = item_rec.ITEM(i)
					     AND ID_STR_RT = item_rec.STORE_ID(i)
					     AND EXPIRATION_DT IS NULL;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					     , stg_error_message = stg_error_message  || '|' ||' Error while
	UPDATING TABLE <ARM_ITM_HIST> - ' || error_code
									 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				  END LOOP;
	     END;
	
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	          INSERT INTO ARM_ITM_HIST
	          (
	                    id_itm
	                  , id_str_rt
	                  , effective_dt
	                  , KEY
	                  , value
	          )
		      SELECT ITEM, STORE_ID, START_DATE, KEY, VALUE FROM
		      (
				SELECT  item_rec.item(i) ITEM, item_rec.store_id(i) storE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
				'RETAIL_PRICE' KEY, item_rec.currency(i) ||
	TO_CHAR(item_rec.new_price(i)) value FROM dual
				UNION ALL
				SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
				'TAXABLE' KEY, item_rec.taxable_ind(i) value FROM dual
				UNION ALL
				SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
				'VAT_RATE' KEY, TO_CHAR(item_rec.VAT_RATE(i)) value FROM dual
				UNION ALL
				SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
				'MANUAL_PRICE_ENTRY' KEY, item_rec.manual_price_entry(i) value FROM dual
				UNION ALL
				SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
				'STATUS' KEY, item_rec.status(i) value FROM dual
	
	           );
	     EXCEPTION
			 WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error INSERTING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				  END LOOP;
			 WHEN OTHERS THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
					  msg:=SUBSTR(SQLERRM(error_code),1,100);
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					        , stg_error_message = stg_error_message  || '|' || ' Unable to
	INSERT ROW IN TABLE ARM_ITM_HIST - ' ||msg
									 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
			END LOOP;
	
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
	
	  RETURN return_code;
	
	END process_tran_0;
	
	FUNCTION process_tran_1(item_rec item_rec_type)
		RETURN INTEGER
	IS
		l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;
		BEGIN
			BEGIN
			    FORALL i IN 1 .. item_rec.item.COUNT SAVE EXCEPTIONS
	 		      INSERT INTO AS_ITM (
					  id_itm, id_prt_itm, barcode, nm_itm, id_dpt_pos,
					  id_clss, id_sbcl, fy, lu_sn, id_brn, label, subline, gender, category,
					  item_drop, variant, id_size, size_index, id_kids_size, id_spr, model, fabric,
				  id_color, product_num, style_num
			      )
				  VALUES (
		  			   item_rec.item(i), item_rec.ref_item(i), item_rec.barcode(i),
					   item_rec.description(i),
					   item_rec.dept(i), item_rec.CLASS(i), item_rec.sub_class(i),
					   item_rec.YEAR(i), item_rec.season(i),
					   item_rec.brand(i), item_rec.label(i), item_rec.subline(i),
					   item_rec.gender(i), item_rec.category(i),
					   item_rec.item_drop(i), item_rec.variant(i), item_rec.size_id(i),
					   item_rec.size_index(i), item_rec.size_index_1(i),
					   item_rec.supplier(i), item_rec.model(i), item_rec.fabric(i),
					   item_rec.color(i), item_rec.product(i),
				   item_rec.style_num(i)
				  );
	         EXCEPTION
			    WHEN dml_errors THEN
			    errors := SQL%BULK_EXCEPTIONS.COUNT;
			    l_cnt := l_cnt + errors;
				return_code := 1;
			    FOR i IN 1..errors LOOP
					error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
					error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
					IF (error_code <> 1) THEN
						UPDATE arm_stg_item
						SET      stg_status = 1
						, stg_error_message = stg_error_message  || '|' || '  Error INSERTING
	AS_ITM - ' || error_code
									 , stg_process_date = SYSDATE
						WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END IF;
			    END LOOP;
			END;
			BEGIN
	          FORALL i IN 1 .. item_rec.item.COUNT SAVE EXCEPTIONS
	             INSERT INTO AS_ITM_RTL_STR
	              (
	                    dc_prc_ef_prn_rt
	                  , id_str_rt
	                  , id_itm
	                  , currency_code
	                  , lu_exm_tx
	                  , sc_itm_sls
	                  , update_dt
	                  , nm_itm
	              )
	              VALUES
	              (
	                   TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                 , item_rec.store_id(i)
	                 , item_rec.item(i)
	                 , item_rec.currency(i)
	                 , item_rec.taxable_ind(i)
	                 , item_rec.status(i)
	                 , TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                 , item_rec.description(i)
	              );
	     EXCEPTION
			WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					     ,stg_error_message = stg_error_message  || '|' || ' Error INSERTING
	TABLE <AS_ITM_RTL_STR> - ' || error_code
	    				 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
	            END LOOP;
		 END;
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
			  	 DELETE  ARM_ITM_HIST
				  WHERE ID_ITM = item_rec.ITEM(i)
					     AND ID_STR_RT = item_rec.STORE_ID(i)
					     AND EXPIRATION_DT IS NULL;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					     , stg_error_message = stg_error_message  || '|' ||' Error while
	UPDATING TABLE <ARM_ITM_HIST> - ' || error_code
									 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				  END LOOP;
	     END;
	
		     BEGIN
		          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
			          INSERT INTO ARM_ITM_HIST
			          (
			                    id_itm
			                  , id_str_rt
			                  , effective_dt
			                  , KEY
			                  , value
			          )
				      SELECT ITEM, STORE_ID, START_DATE, KEY, VALUE FROM
				      (
							SELECT  item_rec.item(i) ITEM, item_rec.store_id(i) storE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
							'RETAIL_PRICE' KEY, item_rec.currency(i) ||
	TO_CHAR(item_rec.new_price(i)) value FROM dual
							UNION ALL
							SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
							'TAXABLE' KEY, item_rec.taxable_ind(i) value FROM dual
							UNION ALL
							SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
							'VAT_RATE' KEY, TO_CHAR(item_rec.VAT_RATE(i)) value FROM dual
							UNION ALL
							SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
							'MANUAL_PRICE_ENTRY' KEY, item_rec.manual_price_entry(i) value FROM
	dual
							UNION ALL
							SELECT item_rec.item(i) ITEM, item_rec.store_id(i) STORE_ID,
	TO_DATE(item_rec.start_date(i),'YYYYMMDD') start_date,
							'STATUS' KEY, item_rec.status(i) value FROM dual
	
			           );
		     EXCEPTION
				 WHEN dml_errors THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
					      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
					      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
					      UPDATE arm_stg_item
					      SET      stg_status = 1
						    	 , stg_error_message = stg_error_message || '|' ||' Error
	INSERTING TABLE <ARM_ITM_HIST> - ' || error_code
								 , stg_process_date = SYSDATE
					      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END LOOP;
				 WHEN OTHERS THEN
					errors := SQL%BULK_EXCEPTIONS.COUNT;
					l_cnt := l_cnt + errors;
					return_code := 1;
					FOR i IN 1..errors LOOP
					      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
					      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
						  msg:=SUBSTR(SQLERRM(error_code),1,100);
					      UPDATE arm_stg_item
					      SET      stg_status = 1
						        , stg_error_message = stg_error_message  || '|' || ' Error
	INSERTING TABLE ARM_ITM_HIST - ' ||msg
										 , stg_process_date = SYSDATE
					      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	
		     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              INSERT INTO RK_PRM_ITM
	              (
	                    id_itm
	                  , id_str_rt
					  , currency_code
	                  , id_ru_prdv
					  , dc_prm_ep
	              )
	              SELECT
	                   item_rec.item(i)
	                 , item_rec.store_id(i)
	                 , item_rec.currency(i)
	                 , id_ru_prdv
					 , TO_DATE(item_rec.end_date(i)||item_rec.end_time(i),'YYYYMMDDHH24MISS')
	              FROM   RU_PRM_PRDV     rules_table
	                   , AS_ITM          items_table
	                   , AS_ITM_RTL_STR  stores_table
	              WHERE rules_table.id_str_rt = item_rec.store_id(i)
	              AND   rules_table.id_prm = item_rec.promotion_num(i)
				  AND 	items_table.ID_ITM=stores_table.ID_ITM
	              AND   stores_table.id_str_rt = rules_table.id_str_rt
				  AND	((stores_table.id_itm=item_rec.item(i) AND item_rec.item(i) IS NOT
	NULL)
				  		   OR (items_table.id_dpt_pos = NVL(TO_CHAR(item_rec.dept(i)),
	items_table.id_dpt_pos)
					              AND   items_table.id_clss =
	NVL(TO_CHAR(item_rec.CLASS(i)), items_table.id_clss)
					              AND   items_table.id_sbcl =
	NVL(TO_CHAR(item_rec.sub_class(i)), items_table.id_sbcl)
								  AND 	item_rec.item(i) IS NULL))
				  AND item_rec.promotion_num(i) IS NOT NULL;
	              -- Exception section
	       EXCEPTION
	            WHEN dml_errors THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || '
	Error INSERTING RK_PRM_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id =
	item_rec.stg_event_id(error_index);
			  END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
	
	  RETURN return_code;
	
	END process_tran_1;
	FUNCTION process_tran_2(item_rec item_rec_type)
		RETURN INTEGER
	IS
		l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;
	BEGIN
	     BEGIN
		      FORALL i IN 1..item_rec.tran_type.COUNT
		      SAVE EXCEPTIONS
		              UPDATE ARM_ITM_HIST
		              SET    expiration_dt =
	TO_DATE(item_rec.start_date(i),'YYYYMMDD')
		              WHERE id_itm = item_rec.item(i)
		 			  AND   id_str_rt = item_rec.store_id(i)
					  AND   KEY = 'RETAIL_PRICE'
					  AND   expiration_dt IS NULL;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              INSERT INTO ARM_ITM_HIST
	              (
				   		 Id_itm, id_str_rt, effective_dt, KEY, value
	              )
				  SELECT item_rec.item(i), item_rec.store_id(i),
	TO_DATE(item_rec.start_date(i),'YYYYMMDD'),
					   'RETAIL_PRICE', item_rec.currency(i) ||
	TO_CHAR(item_rec.new_price(i)) FROM ARM_ITM_HIST
					   WHERE ARM_ITM_HIST.ID_ITM = item_rec.item(i) AND
	ARM_ITM_HIST.ID_STR_RT = item_rec.store_id(i)
					   AND ARM_ITM_HIST.KEY = 'RETAIL_PRICE' AND ARM_ITM_HIST.EXPIRATION_DT
	IS NULL HAVING COUNT(*)=0;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error INSERTING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                  WHERE id_itm = item_rec.item(i)
					  AND id_str_rt = item_rec.store_id(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
	  RETURN return_code;
	
	END process_tran_2;
	FUNCTION process_tran_3_4_5(item_rec item_rec_type)
			 RETURN INTEGER
	IS
		l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;
	BEGIN
		 BEGIN
			 FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                UPDATE ARM_ITM_HIST
	                SET    expiration_dt =
	TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                WHERE id_itm = item_rec.item(i)
			   			  AND   id_str_rt = item_rec.store_id(i)
						  AND   KEY = 'MARKDOWN'
						  AND   expiration_dt IS NULL;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              INSERT INTO ARM_ITM_HIST
	              (id_itm, id_str_rt, effective_dt, KEY, value)
	              SELECT item_rec.item(i), item_rec.store_id(i),
	TO_DATE(item_rec.start_date(i),'YYYYMMDD'),
			  			  'MARKDOWN', item_rec.currency(i)||DECODE(item_rec.tran_type(i), 3,
	item_rec.old_price(i) - item_rec.new_price(i),
	  			          4, item_rec.old_price(i) - item_rec.new_price(i), 5, 0)  FROM
	ARM_ITM_HIST
			     WHERE ARM_ITM_HIST.ID_ITM = item_rec.item(i) AND
	ARM_ITM_HIST.ID_STR_RT = item_rec.store_id(i)
						 	   AND ARM_ITM_HIST.KEY = 'MARKDOWN' AND ARM_ITM_HIST.EXPIRATION_DT
	IS NULL HAVING COUNT(*)=0;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error INSERTING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                  WHERE id_itm = item_rec.item(i)
					  AND id_str_rt = item_rec.store_id(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
	  RETURN return_code;
	
	END process_tran_3_4_5;
	
	FUNCTION process_tran_6_7_9(item_rec item_rec_type, tran_type VARCHAR2)
			 RETURN INTEGER
	IS
		l_cnt  		  PLS_INTEGER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   PLS_INTEGER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   PLS_INTEGER := 0;
		l_item_key	  VARCHAR2(20) := NULL;
	BEGIN
		 SELECT DECODE(tran_type, 6, 'VAT_RATE', 7,'TAXABLE', 9,'STATUS') INTO
	l_item_key FROM dual;
		 BEGIN
			 FORALL i IN 1..item_rec.item.COUNT SAVE EXCEPTIONS
	                UPDATE ARM_ITM_HIST
	                SET    expiration_dt =
	TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                WHERE id_itm = item_rec.item(i)
			   			  AND   id_str_rt = item_rec.store_id(i)
						  AND   KEY = l_item_key
						  AND   expiration_dt IS NULL;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	     BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              INSERT INTO ARM_ITM_HIST
	              (id_itm, id_str_rt, effective_dt, KEY, value)
	              SELECT item_rec.item(i), item_rec.store_id(i),
	TO_DATE(item_rec.start_date(i),'YYYYMMDD'),
			  			  l_item_key, DECODE(tran_type, 6, TO_CHAR(item_rec.vat_rate(i)),
	7,TO_CHAR(item_rec.taxable_ind(i)),
	                      			  			 9,TO_CHAR(item_rec.status(i)))
				 FROM ARM_ITM_HIST
			     WHERE ARM_ITM_HIST.ID_ITM = item_rec.item(i) AND
	ARM_ITM_HIST.ID_STR_RT = item_rec.store_id(i)
					   AND ARM_ITM_HIST.KEY = l_item_key AND ARM_ITM_HIST.EXPIRATION_DT IS
	NULL HAVING COUNT(*)=0;
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error INSERTING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
		      WHEN OTHERS THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error INSERTING
	TABLE <ARM_ITM_HIST> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                  WHERE id_itm = item_rec.item(i)
					  AND id_str_rt = item_rec.store_id(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
	TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
	  RETURN return_code;
	END process_tran_6_7_9;
	FUNCTION process_tran_8(item_rec item_rec_type)
			 RETURN INTEGER
	IS
		l_cnt  		  NUMBER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   NUMBER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   NUMBER := 0;
		l_item_key	  VARCHAR2(20) := NULL;
	BEGIN
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              INSERT INTO RK_PRM_ITM
	              (
	                    id_itm
	                  , id_str_rt
					  , currency_code
	                  , id_ru_prdv
					  , dc_prm_ep
				  , effective_dt
	              )
	              SELECT
	                   item_rec.item(i)
	                 , item_rec.store_id(i)
	                 , item_rec.currency(i)
	                 , rules_table.id_ru_prdv
					 , TO_DATE(item_rec.end_date(i)||item_rec.end_time(i),'YYYYMMDDHH24MISS')
				 ,  TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	              FROM   RU_PRM_PRDV     rules_table
	                   , AS_ITM          items_table
	                   , AS_ITM_RTL_STR  stores_table
	              WHERE rules_table.id_str_rt = item_rec.store_id(i)
	              AND   rules_table.id_prm = item_rec.promotion_num(i)
				  AND 	items_table.ID_ITM=stores_table.ID_ITM
	              AND   stores_table.id_str_rt = rules_table.id_str_rt
				  AND	((stores_table.id_itm=item_rec.item(i) AND item_rec.item(i) IS NOT
	NULL)
/*			  		   OR (items_table.id_dpt_pos = NVL(TO_CHAR(item_rec.dept(i)),
	items_table.id_dpt_pos)
					              AND   items_table.id_clss =
	NVL(TO_CHAR(item_rec.CLASS(i)), items_table.id_clss)
					              AND   items_table.id_sbcl =
	NVL(TO_CHAR(item_rec.sub_class(i)), items_table.id_sbcl)
							  AND 	item_rec.item(i) IS NULL)
							  */)
				  AND item_rec.promotion_num(i) IS NOT NULL;
	              -- Exception section
	       EXCEPTION
	            WHEN dml_errors THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || '
					Error INSERTING RK_PRM_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id =
	item_rec.stg_event_id(error_index);
					END LOOP;
	            WHEN OTHERS THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || '
	Error INSERTING RK_PRM_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id =
	item_rec.stg_event_id(error_index);
					END LOOP;
	
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                  WHERE id_itm = item_rec.item(i)
					  AND id_str_rt = item_rec.store_id(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
						TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
		 RETURN return_code;
	END process_tran_8;
	FUNCTION process_tran_10(item_rec item_rec_type)
			 RETURN INTEGER
	IS
		l_cnt  		  NUMBER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   NUMBER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   NUMBER := 0;
		l_item_key	  VARCHAR2(20) := NULL;
	BEGIN
	    DELETE FROM RK_PRM_ITM
		WHERE DC_PRM_EP < SYSDATE;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
	          SAVE EXCEPTIONS
	              UPDATE RK_PRM_ITM
				  SET dc_prm_ep=TO_DATE(item_rec.end_date(i)||item_rec.end_time(i),'YYYYMMDDHH24MISS')
				  WHERE (id_itm,id_str_rt,CURRENCY_CODE,id_ru_prdv) IN (SELECT
	                   item_rec.item(i)
	                 , item_rec.store_id(i)
	                 , item_rec.currency(i)
	                 , rules_table.id_ru_prdv
	              FROM   RU_PRM_PRDV     rules_table
	                   , AS_ITM          items_table
	                   , AS_ITM_RTL_STR  stores_table
	              WHERE rules_table.id_str_rt = item_rec.store_id(i)
	              AND   rules_table.id_prm = item_rec.promotion_num(i)
				  AND 	items_table.ID_ITM=stores_table.ID_ITM
	              AND   stores_table.id_str_rt = rules_table.id_str_rt
				  AND	((stores_table.id_itm=item_rec.item(i) AND item_rec.item(i) IS NOT NULL)
				  		   OR (items_table.id_dpt_pos = NVL(TO_CHAR(item_rec.dept(i)),items_table.id_dpt_pos)
					              AND   items_table.id_clss = NVL(TO_CHAR(item_rec.CLASS(i)), items_table.id_clss)
					              AND   items_table.id_sbcl = NVL(TO_CHAR(item_rec.sub_class(i)), items_table.id_sbcl)
								  AND 	item_rec.item(i) IS NULL))
				  AND item_rec.promotion_num(i) IS NOT NULL);
	              -- Exception section
	       EXCEPTION
	            WHEN dml_errors THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || 'Error UPDATING RK_PRM_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END LOOP;
	            WHEN OTHERS THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || 'Error UPDATING RK_PRM_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = TO_DATE(item_rec.start_date(i),'YYYYMMDD')
	                  WHERE id_itm = item_rec.item(i)
					  AND id_str_rt = item_rec.store_id(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING
						TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
		 RETURN return_code;
	END process_tran_10;
	FUNCTION process_tran_11(item_rec item_rec_type)
			 RETURN INTEGER
	IS
		l_cnt  		  NUMBER := 0;
		error_msg 	  VARCHAR2(1000) := NULL;
		error_index   NUMBER := 0;
		error_code 	  VARCHAR2(10) := NULL;
		msg VARCHAR2(100);
		return_code   NUMBER := 0;
		l_item_key	  VARCHAR2(20) := NULL;
	BEGIN
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
			  		UPDATE AS_ITM
					SET BARCODE=item_rec.BARCODE(i)
					WHERE ID_ITM=item_rec.ITEM(i);
	              -- Exception section
	       EXCEPTION
	            WHEN dml_errors THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || 'Error UPDATING AS_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END LOOP;
	            WHEN OTHERS THEN
					return_code := 1;
	                FOR j IN 1..SQL%bulk_exceptions.COUNT
	                LOOP
	                    error_index := SQL%BULK_EXCEPTIONS(j).ERROR_INDEX;
	                    error_code := SQL%BULK_EXCEPTIONS(j).ERROR_CODE;
	                    UPDATE arm_stg_item
	                    SET     stg_status = 1
	                           , stg_error_message = stg_error_message || 'Error UPDATING AS_ITM - ' || error_code
						 	   , stg_process_date = SYSDATE
	                    WHERE  stg_event_id = item_rec.stg_event_id(error_index);
					END LOOP;
	     END;
	
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT SAVE EXCEPTIONS
	                  UPDATE AS_ITM_RTL_STR
	                  SET UPDATE_DT = SYSDATE
	                  WHERE id_itm = item_rec.item(i);
	     EXCEPTION
		      WHEN dml_errors THEN
				errors := SQL%BULK_EXCEPTIONS.COUNT;
				l_cnt := l_cnt + errors;
				return_code := 1;
				FOR i IN 1..errors LOOP
				      error_index := SQL%BULK_EXCEPTIONS(i).ERROR_INDEX;
				      error_code := SQL%BULK_EXCEPTIONS(i).ERROR_CODE;
				      UPDATE arm_stg_item
				      SET      stg_status = 1
					    	 , stg_error_message = stg_error_message || '|' ||' Error UPDATING TABLE <AS_ITM_RTL_STR> - ' || error_code
							 , stg_process_date = SYSDATE
				      WHERE  stg_event_id = item_rec.stg_event_id(error_index);
				END LOOP;
	     END;
		 BEGIN
	          FORALL i IN 1..item_rec.tran_type.COUNT
			  		 UPDATE ARM_STG_ITEM
					 SET STG_PROCESS_DATE=SYSDATE,
					 STG_STATUS=0
					 WHERE STG_EVENT_ID=item_rec.stg_event_id(i)
					 AND STG_STATUS NOT IN (1);
		 END;
	
		 RETURN return_code;
	END process_tran_11;
END Arm_Load_Item_Pkg;
/
