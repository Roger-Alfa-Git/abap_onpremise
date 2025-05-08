*&---------------------------------------------------------------------*
*& Report ZPOO_HANDLE_ALL_INST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_handle_all_inst_alfa10.

CLASS cl_edificio DEFINITION.
  PUBLIC SECTION.
    EVENTS entrada_bloqueada.

    METHODS: cerrar_puerta IMPORTING zona TYPE string.
ENDCLASS.

CLASS cl_edificio IMPLEMENTATION.
  METHOD cerrar_puerta.
    WRITE: / 'Se cierra la puertade la zona...', zona.
    RAISE EVENT entrada_bloqueada.
  ENDMETHOD.
ENDCLASS.

CLASS cl_entrada DEFINITION.
  PUBLIC SECTION.
    METHODS: entrada_bloqueada FOR EVENT entrada_bloqueada OF cl_edificio,
      constructor.
ENDCLASS.


CLASS cl_entrada IMPLEMENTATION.
  METHOD constructor.
    SET HANDLER me->entrada_bloqueada FOR ALL INSTANCES.
  ENDMETHOD.
  METHOD entrada_bloqueada.
    WRITE: 'Entrada Cerrada'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_edificio_norte TYPE REF TO cl_edificio,
        gr_edificio_sur   TYPE REF TO cl_edificio,
        gr_edificio_este  TYPE REF TO cl_edificio,
        gr_edificio_oeste TYPE REF TO cl_edificio,
        gr_entrada        TYPE REF TO cl_entrada.

  CREATE OBJECT: gr_edificio_norte,
                 gr_edificio_sur  ,
                 gr_edificio_este ,
                 gr_edificio_oeste,
                 gr_entrada       .

  " SET HANDLER gr_entrada->entrada_bloqueada FOR ALL INSTANCES.

  " SET HANDLER gr_entrada->entrada_bloqueada FOR gr_edificio_norte.

  gr_edificio_norte->cerrar_puerta( zona = 'Norte' ).

  "SET HANDLER gr_entrada->entrada_bloqueada FOR gr_edificio_sur.

  gr_edificio_sur->cerrar_puerta( zona = 'Sur' ).

  gr_edificio_este->cerrar_puerta( zona = 'Este' ).

  gr_edificio_oeste->cerrar_puerta( zona = 'Oeste' ).
