*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZVA_ALFA10......................................*
TABLES: ZVA_ALFA10, *ZVA_ALFA10. "view work areas
CONTROLS: TCTRL_ZVA_ALFA10
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVA_ALFA10. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVA_ALFA10.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVA_ALFA10_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVA_ALFA10.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA_ALFA10_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVA_ALFA10_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVA_ALFA10.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVA_ALFA10_TOTAL.

*.........table declarations:.................................*
TABLES: KNA1                           .
TABLES: MSEG                           .
