*&---------------------------------------------------------------------*
*& Report ZPOO_WID_CAST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_wid_cast_alfa10.

CLASS vehiculo DEFINITION.
  PUBLIC SECTION.
    METHODS: set_tipo.

ENDCLASS.

CLASS vehiculo IMPLEMENTATION.

  METHOD set_tipo.
    WRITE / 'Vehiculo'.
  ENDMETHOD.

ENDCLASS.


CLASS camion DEFINITION INHERITING FROM vehiculo.
  PUBLIC SECTION.
    METHODS: set_tipo REDEFINITION,
      set_carga.

ENDCLASS.

CLASS camion IMPLEMENTATION.
  METHOD set_tipo.
    WRITE / 'Camion'.
  ENDMETHOD.
  METHOD set_carga.
    WRITE / 'Camion 16T'.
  ENDMETHOD.
ENDCLASS.

CLASS coche DEFINITION INHERITING FROM vehiculo.


ENDCLASS.

START-OF-SELECTION.

  DATA: gr_vehiculo TYPE REF TO vehiculo,
        gr_camion   TYPE REF TO camion,
        gr_coche    TYPE REF TO coche.

  CREATE OBJECT: gr_camion,
  gr_coche.

  gr_vehiculo = gr_camion.

  gr_vehiculo = gr_coche.

  IF gr_vehiculo IS BOUND.
    gr_vehiculo->set_tipo( ).
  ENDIF.
