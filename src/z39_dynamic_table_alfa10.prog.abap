*&---------------------------------------------------------------------*
*& Report Z39_DYNAMIC_TABLE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z39_dynamic_table_alfa10.

PARAMETERS: pa_table  TYPE c LENGTH 16,
            pa_tabla TYPE c LENGTH 16.

TYPES: BEGIN OF gty_context,
         planetype TYPE s_planetye,
         seatsmax  TYPE s_seatsmax,
       END OF gty_context.

DATA: gt_content TYPE STANDARD TABLE OF gty_context.

TRY.
    SELECT * FROM (pa_table)
      INTO CORRESPONDING FIELDS OF TABLE gt_content.
  CATCH cx_sy_dynamic_osql_semantics.
    WRITE: / 'El nombre de la tabla no existe'.
ENDTRY.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_content ).
ENDIF.

TRY.
    SELECT * FROM (pa_tabla)
      INTO CORRESPONDING FIELDS OF TABLE gt_content.
  CATCH cx_sy_dynamic_osql_semantics.
    WRITE: / 'El nombre de la tabla no existe'.
ENDTRY.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_content ).
ENDIF.

*////////Ejercicio del video///////////////////////////////////////////////////////////////////
*TYPES: BEGIN OF gty_context,
*         carrid TYPE s_carr_id,
*         connid TYPE s_conn_id,
*       END OF gty_context.
*
*DATA: gt_content TYPE STANDARD TABLE OF gty_context.
*
*TRY.
*    SELECT * FROM (pa_table)
*      INTO CORRESPONDING FIELDS OF TABLE gt_content.
*  CATCH cx_sy_dynamic_osql_semantics.
*    WRITE: / 'El nombre de la tabla no existe'.
*ENDTRY.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_content ).
*ENDIF.
