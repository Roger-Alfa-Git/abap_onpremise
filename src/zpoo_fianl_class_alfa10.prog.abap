*&---------------------------------------------------------------------*
*& Report ZPOO_FIANL_CLASS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_fianl_class_alfa10.

CLASS factura DEFINITION final.
  PUBLIC SECTION.
    DATA: fecha_alta TYPE sydatum.

    METHODS: set_fecha_alta IMPORTING fecha TYPE sydatum.
ENDCLASS.

CLASS factura IMPLEMENTATION.
  METHOD set_fecha_alta .
    me->fecha_alta = fecha.
  ENDMETHOD.

ENDCLASS.

CLASS documento DEFINITION.

ENDCLASS.

START-OF-SELECTION.
