*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO12_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio12_alfa10.

CLASS cuenta DEFINITION.
  PUBLIC SECTION.
    METHODS: set_numero IMPORTING i_numero TYPE string,
      get_numero EXPORTING e_numero TYPE string.

  PRIVATE SECTION.
    DATA: numero TYPE string.

ENDCLASS.

CLASS cuenta IMPLEMENTATION.

  METHOD set_numero.

    numero = i_numero.

  ENDMETHOD.

  METHOD get_numero.

    e_numero = numero.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_cuenta TYPE REF TO cuenta,
        gv_numero TYPE string.

  CREATE OBJECT gr_cuenta.

  gr_cuenta->set_numero( i_numero = '1234567890' ).

  gr_cuenta->get_numero(
    IMPORTING
      e_numero = gv_numero
  ).

  WRITE / gv_numero.
