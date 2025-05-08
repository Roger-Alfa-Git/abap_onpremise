FUNCTION z_get_material_list_wd.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(ET_MATERIAL_LIST) TYPE  ZTT_MATERIAL_DATA_FA10
*"----------------------------------------------------------------------
*
*  SELECT * FROM zwarehousedata10
*    INTO TABLE et_material_list
*    WHERE material_id NE space
*    ORDER BY material_id DESCENDING.


ENDFUNCTION.
