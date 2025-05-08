*&---------------------------------------------------------------------*
*& Include          Z_ALV_MF_ALFA10_SEL
*&---------------------------------------------------------------------*
TABLES spfli.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_carr FOR spfli-carrid.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
  PARAMETERS: p_list RADIOBUTTON GROUP alv,
              p_grid RADIOBUTTON GROUP alv,
              p_hier RADIOBUTTON GROUP alv.

SELECTION-SCREEN END OF BLOCK b2.
