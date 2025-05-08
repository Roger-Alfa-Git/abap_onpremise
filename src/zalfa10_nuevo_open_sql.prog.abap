*&---------------------------------------------------------------------*
*& Report zalfa10_nuevo_open_sql
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalfa10_nuevo_open_sql.

CONSTANTS: gv_soc TYPE bukrs VALUE '1010',
           gv_eje TYPE gjahr VALUE '2022'.

**********************************************************************
* 2.1 Declaracion en linea

*SELECT mandt, bukrs, gjahr, dmbtr, wrbtr
* FROM bseg
* INTO TABLE @DATA(gt_acc_docs)
* UP TO 10 ROWS
* WHERE bukrs EQ @gv_soc
* AND gjahr EQ @gv_eje.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_acc_docs ).
*ENDIF.

**********************************************************************
* 2.3 Especificación de columnas

*SELECT header~bukrs,
*        header~gjahr,
*        header~belnr,
*        item~*
* FROM bkpf AS header
* INNER JOIN bseg AS item ON header~bukrs EQ item~bukrs
*                        AND header~belnr EQ item~belnr
*                        AND header~gjahr EQ item~gjahr
* WHERE header~bukrs EQ @gv_soc
* AND header~gjahr EQ @gv_eje
* ORDER BY header~belnr, item~buzei
* INTO TABLE @DATA(gt_acc_docs)
* UP TO 10 ROWS.

*SELECT FROM bkpf AS header
* INNER JOIN bseg AS item ON header~bukrs EQ item~bukrs
*                        AND header~belnr EQ item~belnr
*                        AND header~gjahr EQ item~gjahr
*FIELDS header~bukrs,
*        header~gjahr,
*        header~belnr,
*        item~*
* WHERE header~bukrs EQ @gv_soc
* AND header~gjahr EQ @gv_eje
* ORDER BY header~belnr, item~buzei
* INTO TABLE @DATA(gt_acc_docs)
* UP TO 10 ROWS.
*
*
*IF sy-subrc EQ 0.
*  READ TABLE gt_acc_docs INTO DATA(gs_acc_docs) INDEX 1.
*  IF sy-subrc EQ 0.
*    cl_demo_output=>display( gs_acc_docs-item ).
*  ENDIF.
*ENDIF.

**********************************************************************
* 2.7

DATA(gv_offset) = 100.

DATA gv_decimal TYPE p LENGTH 13 DECIMALS 4 VALUE '14.0589'.

SELECT FROM demo_expressions
FIELDS  id,
        num1,
        num2,
        CAST( num1 AS FLTP ) AS num1_fltp,
*        CAST( num1 AS FLTP ) / CAST( num2 AS FLTP ) AS ratio,
*        division( num1, num2, 2 ) AS division,
*        div( num1, num2 ) AS div,
*        mod( num1, num2 ) AS mod,
        @gv_offset + num1 + num2 AS sum,
        abs( num1 - num2 ) AS abs,
        ceil( @gv_decimal ) AS ceil,
        floor( @gv_decimal ) AS floor,
        round( @gv_decimal, 2 ) AS round
        ORDER BY sum DESCENDING
        INTO TABLE @DATA(gt_results).

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_results ).
ENDIF.
