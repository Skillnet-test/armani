DECLARE
	TYPE id_itm_type IS TABLE OF rk_item_vw.id_itm%TYPE;
	TYPE barcode_type IS TABLE OF rk_item_vw.barcode%TYPE;
	TYPE item_rec_type IS RECORD (
	      item id_itm_type
	    , barcode barcode_type
	);
	item_rec item_rec_type;
    	
	CURSOR item_cur
	IS
	SELECT a.id_itm item, b.upc barcode  
	FROM AS_ITM a, GA_ITM_XREF b WHERE a.id_itm = b.sku;	
BEGIN
	OPEN item_cur;
	LOOP
	    FETCH item_cur BULK COLLECT
	    INTO  item_rec.item, item_rec.barcode
	    LIMIT 1000;
		FORALL i IN 1..item_rec.item.COUNT
			UPDATE AS_ITM
			SET BARCODE=ITEM_REC.barcode(i)
			WHERE id_itm=item_rec.item(i);
		FORALL i IN 1..item_rec.item.COUNT
			DELETE ARM_ITM_HIST
			WHERE id_itm=ITEM_REC.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			UPDATE TR_LTM_RTL_TRN
			SET id_itm=item_rec.item(i)
			WHERE id_itm=item_rec.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			UPDATE RK_LOT
			SET item_id=item_rec.item(i)
			WHERE item_id=item_rec.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			DELETE ARM_ITM_SOH
			WHERE item_id=item_rec.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			DELETE AS_ITM_RTL_STR
			WHERE id_itm=item_rec.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			UPDATE RK_SALES_SUMMARY
			SET id_itm=item_rec.item(i)
			WHERE id_itm=item_rec.barcode(i);
		FORALL i IN 1..item_rec.item.COUNT
			DELETE AS_ITM WHERE id_itm=item_rec.barcode(i);
	    COMMIT;
	    EXIT WHEN item_cur%NOTFOUND;
	END LOOP;
	CLOSE item_cur;
	COMMIT;
END;
