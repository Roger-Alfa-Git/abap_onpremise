*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio5_alfa10.

CLASS proveedor DEFINITION.
  PUBLIC SECTION.
    METHODS bool IMPORTING cuenta         TYPE lifnr
                 RETURNING VALUE(boolean) TYPE string.

ENDCLASS.

CLASS proveedor IMPLEMENTATION.

  METHOD bool.

    DATA: repaso TYPE  lfa1.

    SELECT SINGLE * FROM lfa1
      INTO repaso
      WHERE lifnr EQ cuenta.

    IF sy-subrc EQ 0.
      boolean = 'X'.
    ELSE.
      boolean = 'SPACE'.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_proveedor TYPE REF TO proveedor,
        gr_cuenta    TYPE lifnr,
        lv_boolean   TYPE string.

  gr_cuenta = '0010300002'.
  "gr_cuenta = '001030000'.

  CREATE OBJECT gr_proveedor.

  lv_boolean = gr_proveedor->bool( cuenta = gr_cuenta ).

  WRITE / lv_boolean.
