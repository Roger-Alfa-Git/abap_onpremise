*&---------------------------------------------------------------------*
*& Report ZPOO_FINAL_METHOD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_final_method_alfa10.

CLASS factura DEFINITION.

  PUBLIC SECTION.
    DATA: fecha_alta TYPE sydatum.

    METHODS: set_fecha_alta IMPORTING fecha TYPE sydatum.

ENDCLASS.

CLASS factura IMPLEMENTATION.
  METHOD set_fecha_alta.

    me->fecha_alta = fecha.

  ENDMETHOD.

ENDCLASS.

CLASS documento DEFINITION INHERITING FROM factura.

  PUBLIC SECTION.
    METHODS set_fecha_alta FINAL REDEFINITION.

ENDCLASS.

CLASS documento IMPLEMENTATION.

  METHOD set_fecha_alta.

  ENDMETHOD.
ENDCLASS.

CLASS pedido DEFINITION INHERITING FROM documento.
  PUBLIC SECTION.
*    METHODS: set_fecha_alta REDEFINITION.

ENDCLASS.

CLASS pedido IMPLEMENTATION.
*  METHOD set_fecha_alta.
*
*  ENDMETHOD.

ENDCLASS.

CLASS recepcion DEFINITION INHERITING FROM factura.
PUBLIC SECTION.
  METHODS : set_fecha_alta REDEFINITION.

ENDCLASS.

CLASS recepcion IMPLEMENTATION.
  METHOD set_fecha_alta.

  ENDMETHOD.
ENDCLASS.
