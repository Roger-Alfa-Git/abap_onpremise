*&---------------------------------------------------------------------*
*& Report ZPOO_NARR_CAST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_narr_cast_alfa10.

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

START-OF-SELECTION.

  DATA: gr_vehiculo TYPE REF TO vehiculo,
        gr_camion   TYPE REF TO camion,
        gr_camion2  TYPE REF TO camion.

  CREATE OBJECT: gr_camion,gr_camion2.

*  gr_vehiculo = gr_camion.
  TRY.
      gr_camion2 ?= gr_vehiculo.
      MOVE gr_vehiculo ?TO gr_camion.

    CATCH cx_sy_move_cast_error.
      WRITE / 'CAST error'.
  ENDTRY.

  IF gr_camion2 IS BOUND.
    gr_camion2->set_carga( ).
  ELSE.
    WRITE / 'El objeto No se ha instanciado'.
  ENDIF.
