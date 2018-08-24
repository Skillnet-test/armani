DECLARE
	TYPE id_type IS TABLE OF rk_sales_summary.id%TYPE;
	TYPE dept_type IS TABLE OF rk_sales_summary.ITEM_DEPT_ID%TYPE;
	TYPE class_type IS TABLE OF rk_sales_summary.ITEM_CLSS_ID%TYPE;
	TYPE summ_rec_type IS RECORD (
	      id id_type
	    , dept dept_type
	    , CLASS class_type
	);
	summ_rec summ_rec_type;
    	
	CURSOR summ_cur
	IS
	SELECT summ.id ID,ITEM.ID_DPT_POS dept_id, ITEM.ID_CLSS class_id FROM  RK_SALES_SUMMARY SUMM, AS_ITM ITEM WHERE SUMM.ID_ITM = ITEM.ID_ITM AND misc_item_id IS NULL;
BEGIN
	OPEN summ_cur;
	LOOP
	    FETCH summ_cur BULK COLLECT
	    INTO  summ_rec.id, summ_rec.dept, summ_rec.CLASS
	    LIMIT 1000;
		FORALL i IN 1..summ_rec.id.COUNT
			UPDATE RK_SALES_SUMMARY
			SET ITEM_DEPT_ID=summ_rec.dept(i),
			ITEM_CLSS_ID = summ_rec.CLASS(i)
			WHERE id = summ_rec.id(i);
	    COMMIT;
	    EXIT WHEN summ_cur%NOTFOUND;
	END LOOP;
	CLOSE summ_cur;
	COMMIT;
END;
/ 