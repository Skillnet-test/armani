CREATE OR REPLACE package arm_download_data_pkg is
-- Item Table TYPE Declarations --
TYPE id_itm_type IS TABLE OF rk_item_vw.id_itm%TYPE;
TYPE barcode_type IS TABLE OF rk_item_vw.barcode%TYPE;
TYPE fy_type IS TABLE OF rk_item_vw.fy%TYPE;

TYPE label_type IS TABLE OF arm_label.id_label%TYPE;
TYPE nm_label_type IS TABLE OF arm_label.nm_label%TYPE;

TYPE subline_type IS TABLE OF arm_subline.id_subline%TYPE;
TYPE de_subline_type IS TABLE OF arm_subline.de_subline%TYPE;

TYPE gender_type IS TABLE OF arm_gender.id_gender%TYPE;
TYPE de_gender_type IS TABLE OF arm_gender.de_gender%TYPE;

TYPE category_type IS TABLE OF arm_category.id_category%TYPE;
TYPE nm_category_type IS TABLE OF arm_category.nm_category%TYPE;

TYPE item_drop_type IS TABLE OF arm_drop.id_drop%TYPE;
TYPE de_item_drop_type IS TABLE OF arm_drop.de_drop%TYPE;

TYPE variant_type IS TABLE OF rk_item_vw.variant%TYPE;

TYPE model_type IS TABLE OF rk_item_vw.model%TYPE;
TYPE fabric_type IS TABLE OF rk_item_vw.fabric%TYPE;
TYPE style_num_type IS TABLE OF rk_item_vw.style_num%TYPE;
TYPE id_product_type IS TABLE OF arm_product.id_product%TYPE;
TYPE de_product_type IS TABLE OF arm_product.de_product%TYPE;

TYPE value_type_retail IS TABLE OF arm_itm_hist.value%TYPE;
TYPE value_type_markdown IS TABLE OF arm_itm_hist.value%TYPE;
TYPE value_type_taxable IS TABLE OF arm_itm_hist.value%TYPE;

TYPE currency_code_type IS TABLE OF rk_item_vw.currency_code%TYPE;
TYPE vat_rate_type IS TABLE OF rk_item_vw.vat_rate%TYPE;
TYPE id_str_rt_type IS TABLE OF rk_item_vw.id_str_rt%TYPE;

TYPE nm_itm_type IS TABLE OF rk_item_vw.nm_itm%TYPE;

TYPE sc_itm_sls_type IS TABLE OF rk_item_vw.sc_itm_sls%TYPE;

TYPE id_brn_type IS TABLE OF arm_brn.id_brn%TYPE;
TYPE nm_brn_type IS TABLE OF arm_brn.nm_brn%TYPE;

TYPE id_class_type IS TABLE OF arm_class.id_clss%TYPE;
TYPE nm_class_type IS TABLE OF arm_class.id_clss%TYPE;

TYPE id_color_type IS TABLE OF arm_color.id_color%TYPE;
TYPE de_color_type IS TABLE OF arm_color.de_color%TYPE;

TYPE id_season_type IS TABLE OF arm_season.id_season%TYPE;
TYPE de_season_type IS TABLE OF arm_season.de_season%TYPE;

TYPE id_size_type IS TABLE OF arm_size.id_size%TYPE;
TYPE de_size_type IS TABLE OF arm_size.de_size%TYPE;
TYPE size_index_type IS TABLE OF arm_size.size_index%TYPE;
TYPE ext_size_index_type IS TABLE OF arm_size.ext_size_index%TYPE;

TYPE id_size_kids_type IS TABLE OF arm_kids_size.id_size%TYPE;
TYPE de_size_kids_type IS TABLE OF arm_kids_size.de_size%TYPE;

TYPE id_spr_type IS TABLE OF arm_spr.id_spr%TYPE;
TYPE nm_spr_type IS TABLE OF arm_spr.nm_spr%TYPE;

TYPE id_sbcl_type IS TABLE OF arm_subclass.id_sbcl%TYPE;
TYPE nm_sbcl_type IS TABLE OF arm_subclass.nm_sbcl%TYPE;

TYPE id_dpt_pos_type IS TABLE OF id_dpt_ps.id_dpt_pos%TYPE;
TYPE nm_dpt_pos_type IS TABLE OF id_dpt_ps.nm_dpt_pos%TYPE;

TYPE id_ru_prdv_type IS TABLE OF rk_prm_itm.id_ru_prdv%TYPE;
TYPE manual_price_type IS TABLE OF rk_item_vw.fl_en_prc_rq%TYPE;

TYPE update_dt_type IS TABLE OF rk_item_vw.update_dt%TYPE;

TYPE item_rec_type IS RECORD (
      id_itm id_itm_type
    , barcode barcode_type
    , id_str_rt id_str_rt_type
    , value_retail value_type_retail
    , value_markdown value_type_markdown
    , value_taxable value_type_taxable
    , currency_code currency_code_type
    , vat_rate vat_rate_type
    , fy fy_type
    , id_season id_season_type
    , de_season de_season_type
    , id_brn id_brn_type
    , nm_brn nm_brn_type
    , label label_type
    , nm_label nm_label_type
    , subline subline_type
    , de_subline de_subline_type
    , gender gender_type
    , de_gender de_gender_type
    , category category_type
    , nm_category nm_category_type
    , item_drop item_drop_type
    , de_item_drop de_item_drop_type
    , variant variant_type
    , id_size id_size_type
    , de_size de_size_type
    , size_index size_index_type
    , ext_size_index ext_size_index_type
    , id_size_kids id_size_kids_type
    , de_size_kids de_size_kids_type
    , id_spr id_spr_type
    , nm_spr nm_spr_type
    , model model_type
    , fabric fabric_type
    , id_color id_color_type
    , de_color de_color_type
    , id_product id_product_type
    , de_product de_product_type
    , nm_itm nm_itm_type
    , id_dpt_pos id_dpt_pos_type
    , nm_dpt_pos nm_dpt_pos_type
    , id_class id_class_type
    , nm_class nm_class_type
    , id_sbcl id_sbcl_type
    , nm_sbcl nm_sbcl_type
    , style_num style_num_type
    , sc_itm_sls sc_itm_sls_type
    , manual_price manual_price_type
    , id_ru_prdv id_ru_prdv_type
    , update_dt update_dt_type
);

item_rec item_rec_type;

  -- Following procedure downloads ITEM data,
  PROCEDURE download_item
  (
        in_file_name IN VARCHAR2
      , in_store_id IN VARCHAR2
      , in_from_date IN DATE
      , return_status OUT VARCHAR2
      , return_message OUT VARCHAR2
  );

END arm_download_data_pkg;
/

CREATE OR REPLACE PACKAGE BODY Arm_Download_Data_Pkg IS
----------------------------------------------------------------------------
--------------------
-- Package body --
----------------------------------------------------------------------------
--------------------


bulk_errors EXCEPTION;
PRAGMA EXCEPTION_INIT ( bulk_errors, -24381 );


CURSOR item_cur (p_store_id IN VARCHAR2, p_from_date IN DATE)
IS
SELECT ID_ITM, BARCODE, ID_STR_RT, RETAIL_VALUE, MARKDOWN_VALUE,
 TAXABLE_VALUE, CURRENCY_CODE, VAT_RATE, FY, SEASON, DE_SEASON,
 ID_BRN, NM_BRN, LABEL, NM_LABEL, SUBLINE,
 DE_SUBLINE, GENDER, DE_GENDER, CATEGORY, NM_CATEGORY,
 ITEM_DROP, DE_DROP, VARIANT, ID_SIZE, DE_SIZE,
 SIZE_INDEX, EXT_SIZE_INDEX, ID_SIZE_KIDS, DE_SIZE_KIDS, ID_SPR,
 NM_SPR, MODEL, FABRIC, ID_COLOR, DE_COLOR,
 PRODUCT_NUM, DE_PRODUCT, NM_ITM, ID_DPT_POS, NM_DPT_POS,
 ID_CLASS, NM_CLASS, ID_SBCL, NM_SBCL, STYLE_NUM,
 SC_ITM_SLS,  FL_EN_PRC_RQ, UPDATE_DT, ID_RU_PRDV
FROM   RK_ITEM_VW
WHERE  ID_STR_RT = p_store_id
AND  ((UPDATE_DT >= p_from_date AND p_from_date IS NOT NULL) OR p_from_date IS NULL)
ORDER BY ID_ITM, ID_STR_RT;


----------------------------------------------------------------------------
--------------------
PROCEDURE download_item
----------------------------------------------------------------------------
--------------------
(
        in_file_name IN VARCHAR2
      , in_store_id IN VARCHAR2
      , in_from_date IN DATE
      , return_status OUT VARCHAR2
      , return_message OUT VARCHAR2
)
IS
----------------------------------------------------------------------------
--------------------
-- Download Item by transaction declarations --
----------------------------------------------------------------------------
--------------------

l_folder_name  VARCHAR2(100) := 'C:\temp';
l_file_name    VARCHAR2(100) := 'item_download.csv';

output_file_handle  utl_file.file_type;
last_item_id VARCHAR2(128) := ' ';
current_item_id VARCHAR2(128) := ' ';
item_string VARCHAR2(500) := ' ';

i  PLS_INTEGER;
j  PLS_INTEGER;
l_error_index PLS_INTEGER;
l_error_code VARCHAR2(255);
l_error_stg_event_id PLS_INTEGER;
l_record_count PLS_INTEGER;

----------------------------------------------------------------------------
--------------------
-- execution --
----------------------------------------------------------------------------
--------------------
BEGIN

    BEGIN
        SELECT LOOKUP_CODE
        INTO   l_folder_name
        FROM   ARM_MISC_LOOKUP
        WHERE  LOOKUP_TYPE = 'ITEM_DOWNLOAD_SUB_DIRECTORY'
        AND    ENABLED_FLAG = 'Y';
        --
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            return_status := 'FAILURE';
            return_message := 'ITEM_DOWNLOAD_SUB_DIRECTORY is not found';
            RETURN;
        WHEN OTHERS THEN
            return_status := 'FAILURE';
            return_message := 'Error fetching from ARM_MISC_LOOKUP - ' ||
SQLERRM;
            RETURN;
    END;

    IF ( in_file_name IS NOT NULL )
    THEN
        l_file_name := in_file_name;
    END IF;

    OPEN  item_cur (in_store_id, in_from_date);
    FETCH item_cur BULK COLLECT
    INTO    item_rec.id_itm
          , item_rec.barcode
          , item_rec.id_str_rt
          , item_rec.value_retail
          , item_rec.value_markdown
          , item_rec.value_taxable
          , item_rec.currency_code
          , item_rec.vat_rate
          , item_rec.fy
          , item_rec.id_season
          , item_rec.de_season
          , item_rec.id_brn
          , item_rec.nm_brn
          , item_rec.label
          , item_rec.nm_label
          , item_rec.subline
          , item_rec.de_subline
          , item_rec.gender
          , item_rec.de_gender
          , item_rec.category
          , item_rec.nm_category
      , item_rec.item_drop
      , item_rec.de_item_drop
          , item_rec.variant
          , item_rec.id_size
          , item_rec.de_size
          , item_rec.size_index
          , item_rec.ext_size_index
          , item_rec.id_size_kids
          , item_rec.de_size_kids
          , item_rec.id_spr
          , item_rec.nm_spr
          , item_rec.model
          , item_rec.fabric
          , item_rec.id_color
          , item_rec.de_color
          , item_rec.id_product
          , item_rec.de_product
          , item_rec.nm_itm
          , item_rec.id_dpt_pos
          , item_rec.nm_dpt_pos
          , item_rec.id_class
          , item_rec.nm_class
          , item_rec.id_sbcl
          , item_rec.nm_sbcl
          , item_rec.style_num
          , item_rec.sc_itm_sls
          , item_rec.manual_price
          , item_rec.update_dt
          , item_rec.id_ru_prdv
    ;
    CLOSE item_cur;

    output_file_handle := utl_file.fopen(l_folder_name, l_file_name,'W');

    FOR i IN 1..item_rec.id_itm.COUNT()
    LOOP
    current_item_id := item_rec.id_itm(i);
dbms_output.put_line('current_item_id ==='||current_item_id);
dbms_output.put_line('item_rec.id_itm ==='||item_rec.id_itm(i));
dbms_output.put_line('last_item_id==='||last_item_id);
IF (last_item_id<>current_item_id) THEN
dbms_output.put_line('true');
ELSE
dbms_output.put_line('false');
END IF; 
    IF (last_item_id != current_item_id) THEN
        IF (trim(last_item_id) IS NOT NULL) THEN
            utl_file.put_line(
                  output_file_handle
                , item_string
            );
           END IF;
           last_item_id := current_item_id;
           item_string := NULL;
           item_string := item_rec.id_itm(i)
           || '|' ||
           item_rec.barcode(i)
           || '|' ||
           item_rec.id_str_rt(i)
           || '|' ||
           item_rec.value_retail(i)
           || '|' ||
           item_rec.value_markdown(i)
           || '|' ||
           item_rec.value_taxable(i)
           || '|' ||
           item_rec.currency_code(i)
           || '|' ||
           item_rec.vat_rate(i)
           || '|' ||
           item_rec.fy(i)
           || '|' ||
           item_rec.id_season(i)
           || '|' ||
           item_rec.de_season(i)
           || '|' ||
           item_rec.id_brn(i)
           || '|' ||
           item_rec.nm_brn(i)
           || '|' ||
           item_rec.label(i)
           || '|' ||
           item_rec.nm_label(i)
           || '|' ||
           item_rec.subline(i)
           || '|' ||
           item_rec.de_subline(i)
           || '|' ||
           item_rec.gender(i)
           || '|' ||
           item_rec.de_gender(i)
           || '|' ||
           item_rec.category(i)
           || '|' ||
           item_rec.nm_category(i)
           || '|' ||
           item_rec.item_drop(i)
           || '|' ||
           item_rec.de_item_drop(i)
           || '|' ||
           item_rec.variant(i)
           || '|' ||
           item_rec.id_size(i)
           || '|' ||
           item_rec.de_size(i)
           || '|' ||
           item_rec.size_index(i)
           || '|' ||
           item_rec.ext_size_index(i)
           || '|' ||
           item_rec.id_size_kids(i)
           || '|' ||
           item_rec.de_size_kids(i)
           || '|' ||
           item_rec.id_spr(i)
           || '|' ||
           item_rec.nm_spr(i)
           || '|' ||
           item_rec.model(i)
           || '|' ||
           item_rec.fabric(i)
           || '|' ||
           item_rec.id_color(i)
           || '|' ||
           item_rec.de_color(i)
           || '|' ||
           item_rec.id_product(i)
           || '|' ||
           item_rec.de_product(i)
           || '|' ||
           item_rec.nm_itm(i)
           || '|' ||
           item_rec.id_dpt_pos(i)
           || '|' ||
           item_rec.nm_dpt_pos(i)
           || '|' ||
           item_rec.id_class(i)
           || '|' ||
           item_rec.nm_class(i)
           || '|' ||
           item_rec.id_sbcl(i)
           || '|' ||
           item_rec.nm_sbcl(i)
           || '|' ||
           item_rec.style_num(i)
           || '|' ||
           item_rec.sc_itm_sls(i)
           || '|' ||
           item_rec.manual_price(i)
           || '|' ||
           TO_CHAR(item_rec.update_dt(i),'DD-MON-YYYY')
           || '|' ||
               item_rec.id_ru_prdv(i);
        ELSE
           item_string := item_string
                  || '|' ||
                  item_rec.id_ru_prdv(i);
    END IF;
    END LOOP;
    utl_file.fclose(output_file_handle);

    return_status := 'SUCCESS';
    return_message := '';
    --
    EXCEPTION
    WHEN utl_file.invalid_mode THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.invalid_mode: ' || SQLERRM;
    WHEN utl_file.invalid_path THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.invalid_path: ' || SQLERRM;
    WHEN utl_file.invalid_filehandle THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.invalid_filehandle: ' || SQLERRM;
    WHEN utl_file.invalid_operation THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.invalid_operation: ' || SQLERRM;
    WHEN utl_file.read_error THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.read_error: ' || SQLERRM;
    WHEN utl_file.write_error THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.write_error: ' || SQLERRM;
    WHEN utl_file.internal_error THEN
        return_status := 'FAILURE';
        return_message := 'utl_file.internal_error: ' || SQLERRM;
    WHEN OTHERS THEN
       return_status := 'FAILURE';
       return_message := SQLERRM;
       COMMIT;
END download_item;
END Arm_Download_Data_Pkg;
/
