*&---------------------------------------------------------------------*
*& Report Z34_AVG_SUM_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z34_avg_sum_alfa10.

DATA: gv_promedio TYPE s_price,
      gv_precio   TYPE s_price.

SELECT AVG( price ) SUM( price ) FROM zsflight_alfa10
  INTO ( gv_promedio, gv_precio )
  WHERE currency = 'EUR'.

IF sy-subrc EQ 0.
  WRITE: / gv_promedio,
         / gv_precio.
ENDIF.

*
*DATA: gt_tabla TYPE TABLE OF zsflight_alfa10.
*
*SELECT * FROM zsflight_alfa10
*  INTO TABLE gt_tabla
*  WHERE currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_tabla ).
*ENDIF.

*////////Ejercicio del video////////////////////////////////////////////////////////////
*DATA: gv_promedio TYPE s_seatsmax,
*      gv_sum      TYPE s_sum,
*      gv_sum_max  TYPE s_sum.
*
*SELECT AVG( seatsmax ) FROM zsflight_alfa10
*  INTO gv_promedio
*  WHERE carrid EQ 'LH'
*  AND currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  WRITE / gv_promedio.
*ENDIF.
*
*SELECT SUM( paymentsum ) FROM zsflight_alfa10
*  INTO gv_sum
*  WHERE carrid EQ 'LH'
*  AND currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  WRITE / gv_sum.
*ENDIF.
*
*SKIP 2.
*
*CLEAR: gv_promedio, gv_sum.
*
*SELECT AVG( seatsmax )
*       SUM( paymentsum )
*       MAX( paymentsum )
*   FROM zsflight_alfa10
*  INTO ( gv_promedio, gv_sum, gv_sum_max )
*  WHERE carrid EQ 'LH'
*  AND currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  WRITE: / gv_promedio,
*         / gv_sum,
*         / gv_sum_max.
*ENDIF.
*
*DATA: gt_tabla TYPE TABLE OF zsflight_alfa10.
*
*SELECT * FROM zsflight_alfa10
*  INTO TABLE gt_tabla
*  WHERE carrid EQ 'LH'
*  AND currency EQ 'EUR'.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_tabla ).
*ENDIF.
