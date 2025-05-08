*&---------------------------------------------------------------------*
*& Report zalfa10_al_ida
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zalfa10_al_ida.

DATA gs_flight TYPE sflight.

START-OF-SELECTION.

  SELECT-OPTIONS: so_carid FOR gs_flight-carrid,
                  so_conid FOR gs_flight-connid,
                  so_date  FOR gs_flight-fldate.

  CALL SCREEN 2000.

  INCLUDE: zalfa10_al_ida_top,
           zalfa10_al_ida_pbo,
           zalfa10_al_ida_pai,
           zalfa10_al_ida_f01.
