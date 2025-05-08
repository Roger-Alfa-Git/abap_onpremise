*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio6_alfa10.

CLASS producto DEFINITION.

  PUBLIC SECTION.
    METHODS: constructor IMPORTING i_texto TYPE string.
    CLASS-METHODS class_constructor.

  PRIVATE SECTION.
    DATA: im_texto TYPE string.

ENDCLASS.

CLASS producto IMPLEMENTATION.

  METHOD constructor.
    WRITE / i_texto.
  ENDMETHOD.

  METHOD class_constructor.
    WRITE / 'Ejercicios 2.6 esttico'.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA: gv_producto  TYPE REF TO producto,
        gv_producto2 TYPE REF TO producto.

  CREATE OBJECT gv_producto
    EXPORTING
      i_texto = 'Instancia '.


  CREATE OBJECT gv_producto2
    EXPORTING
      i_texto = 'Instancia 2'.
