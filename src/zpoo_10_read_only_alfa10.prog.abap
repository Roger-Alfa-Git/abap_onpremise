*&---------------------------------------------------------------------*
*& Report ZPOO_10_READ_ONLY_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_10_read_only_alfa10.

CLASS portatil DEFINITION.

  PUBLIC SECTION.

    DATA: no_serie TYPE string READ-ONLY.

    METHODS constructor IMPORTING i_num_serie TYPE string.

ENDCLASS.

CLASS portatil IMPLEMENTATION.

  METHOD constructor.

    no_serie = i_num_serie.

  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA: gr_portatil TYPE REF TO portatil.

  CREATE OBJECT gr_portatil
    EXPORTING
      i_num_serie = 'DELL/9200'.

  WRITE: / gr_portatil->no_serie.


  WRITE: / gr_portatil->no_serie.
