*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZEMPLE_ALFA10...................................*
DATA:  BEGIN OF STATUS_ZEMPLE_ALFA10                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEMPLE_ALFA10                 .
CONTROLS: TCTRL_ZEMPLE_ALFA10
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZEMPLE_ALFA10                 .
TABLES: ZEMPLE_ALFA10                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
