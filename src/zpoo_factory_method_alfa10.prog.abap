*&---------------------------------------------------------------------*
*& Report ZPOO_FACTORY_METHOD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_factory_method_alfa10.

INTERFACE if_forma.
  METHODS: dibujar_forma.
ENDINTERFACE.

CLASS lcl_circulo DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_forma.
    ALIASES dibujar_forma FOR if_forma~dibujar_forma.
ENDCLASS.

CLASS lcl_circulo IMPLEMENTATION.
  METHOD dibujar_forma.
    WRITE: / 'Circulo'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_cuadrado DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_forma.
    ALIASES dibujar_forma FOR if_forma~dibujar_forma.
ENDCLASS.

CLASS lcl_cuadrado IMPLEMENTATION.
  METHOD dibujar_forma.
    WRITE: / 'Cuadrado'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_triangulo DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_forma.
    ALIASES dibujar_forma FOR if_forma~dibujar_forma.
ENDCLASS.

CLASS lcl_triangulo IMPLEMENTATION.
  METHOD dibujar_forma.
    WRITE: / 'Triangulo'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_factoria DEFINITION.
  PUBLIC SECTION.
    METHODS: obtener_forma IMPORTING tipo_forma TYPE string RETURNING VALUE(objeto_forma) TYPE REF TO if_forma.
ENDCLASS.

CLASS lcl_factoria IMPLEMENTATION.
  METHOD obtener_forma.
    CASE tipo_forma.
      WHEN 'Circulo'.
        CREATE OBJECT objeto_forma TYPE lcl_circulo.
      WHEN 'Cuadrado'.
        CREATE OBJECT objeto_forma TYPE lcl_cuadrado.
      WHEN 'Triangulo'.
        CREATE OBJECT objeto_forma TYPE lcl_triangulo.
      WHEN OTHERS.
        WRITE: / 'No existe esa figura'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: gr_forma    TYPE REF TO if_forma,
        gr_factoria TYPE REF TO lcl_factoria.

  CREATE OBJECT gr_factoria.

  gr_forma = gr_factoria->obtener_forma( tipo_forma = 'Circulo' ).

  gr_forma->dibujar_forma( ).
