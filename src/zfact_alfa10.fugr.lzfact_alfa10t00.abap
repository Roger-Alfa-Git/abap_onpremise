*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZFACT_ALFA10....................................*
DATA:  BEGIN OF STATUS_ZFACT_ALFA10                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZFACT_ALFA10                  .
CONTROLS: TCTRL_ZFACT_ALFA10
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZFACT_ALFA10                  .
TABLES: ZFACT_ALFA10                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
