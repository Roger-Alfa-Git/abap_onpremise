*&---------------------------------------------------------------------*
*& Report Z45_SUBQUERY_ALL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z45_subquery_all_alfa10.

TYPES: BEGIN OF gty_avion,
         producer TYPE s_prod,
         count    TYPE i,
       END OF gty_avion.


DATA: gt_tabla TYPE STANDARD TABLE OF gty_avion.

SELECT producer COUNT( * ) AS count
  FROM zsaplane_alfa10
  INTO TABLE gt_tabla
  GROUP BY producer
  HAVING COUNT( * ) >= ALL ( SELECT COUNT( * )
                             FROM zsaplane_alfa10
                             GROUP BY producer ).

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_tabla ).
ENDIF.

*////////Ejercicio del video////////////////////////////////////////////////////////////
*TYPES: BEGIN OF gty_spfli,
*         carrid TYPE s_carr_id,
*         count  TYPE i,
*       END OF gty_spfli.
*
*DATA: gt_spfli TYPE STANDARD TABLE OF gty_spfli.
*
**SELECT carrid COUNT( * ) AS count FROM zspfli_alfa10
**  INTO TABLE gt_spfli
**  GROUP BY carrid.
*
*SELECT carrid COUNT( * ) AS count
*  FROM zspfli_alfa10
*  INTO TABLE gt_spfli
*  GROUP BY carrid
*  HAVING COUNT( * ) >= ALL ( SELECT COUNT( * ) FROM zspfli_alfa10 GROUP BY carrid ).
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_spfli ).
*ENDIF.
