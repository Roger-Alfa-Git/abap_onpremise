*&---------------------------------------------------------------------*
*& Report Z32_AND_OR_NOT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z32_and_or_not_alfa10.

DATA: gt_flights TYPE STANDARD TABLE OF zspfli_alfa10.

SELECT * FROM zspfli_alfa10
  INTO TABLE gt_flights
  WHERE carrid EQ 'JL' OR carrid EQ 'LH'
  AND  connid BETWEEN '0200' AND '0500'
  AND ( cityfrom EQ 'TOKYO' OR cityfrom EQ 'FRANKFURT' OR cityfrom EQ 'NEW YORK' )
  AND deptime BETWEEN '100000' AND '190000'.

IF sy-subrc EQ 0.
  cl_demo_output=>display( gt_flights ).
ENDIF.

*DATA: gt_flights TYPE STANDARD TABLE OF zspfli_alfa10.
*
*SELECT * FROM zspfli_alfa10
*  INTO TABLE gt_flights
*  WHERE cityfrom EQ 'FRANKFURT'
*  AND ( cityto EQ 'TOKYO' OR cityto EQ 'NEW YORK' )
*  AND deptime GE '130000'.
*
*IF sy-subrc EQ 0.
*  cl_demo_output=>display( gt_flights ).
*ENDIF.
