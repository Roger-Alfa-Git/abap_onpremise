*&---------------------------------------------------------------------*
*& Report Z37_GROUP_BY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z37_group_by_alfa10.

TYPES: BEGIN OF gty_count,
         carrid TYPE s_carr_id,
         count  TYPE i,
       END OF gty_count.

DATA: gt_count TYPE TABLE OF gty_count.

SELECT carrid, COUNT( * ) AS id FROM zspfli_alfa10
  INTO TABLE @data(gt_count1)
  GROUP BY carrid .

IF sy-subrc EQ 0.
  CL_demo_output=>display( gt_count1 ).
ENDIF.


*//////Ejercicio del video //////////////////////////////////////////////////////////////////
*TYPES: BEGIN OF gty_count,
*         count TYPE i,
*       END OF gty_count.
*
*DATA:gt_count TYPE TABLE OF gty_count,
*     gv_count TYPE i.
*
*WRITE: / 'Empieza'.
*
*SELECT COUNT( * ) FROM zspfli_alfa10
*  INTO gv_count
*  GROUP BY carrid .
*
*  WRITE: / gv_count.
*
*ENDSELECT.
*
*SELECT COUNT( DISTINCT cityfrom ) FROM zspfli_alfa10
*  INTO TABLE gt_count
*  GROUP BY carrid.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_count ).
*ENDIF.
