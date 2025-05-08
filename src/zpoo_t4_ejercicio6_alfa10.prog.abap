*&---------------------------------------------------------------------*
*& Report ZPOO_T4_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t4_ejercicio6_alfa10.

CLASS fabrica DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: linea_produccion,
      entrada_productos,
      salida_mercancia ABSTRACT.

ENDCLASS.
CLASS fabrica IMPLEMENTATION.
  METHOD linea_produccion.

  ENDMETHOD.

  METHOD entrada_productos.

  ENDMETHOD.
ENDCLASS.

CLASS logistica DEFINITION INHERITING FROM fabrica.
  PUBLIC SECTION.
    METHODS: entrada_productos REDEFINITION,
      linea_produccion  REDEFINITION,
      salida_mercancia  REDEFINITION.
ENDCLASS.

CLASS logistica IMPLEMENTATION.
  METHOD entrada_productos.

  ENDMETHOD.
  METHOD linea_produccion.

  ENDMETHOD.
  METHOD salida_mercancia.

  ENDMETHOD.
ENDCLASS.
