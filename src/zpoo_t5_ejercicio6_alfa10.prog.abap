*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio6_alfa10.

CLASS cl_precio_producto DEFINITION.
  PUBLIC SECTION.
    DATA: precio TYPE i.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_precio1 TYPE REF TO cl_precio_producto,
        gr_precio2 TYPE REF TO cl_precio_producto.

  CREATE OBJECT: gr_precio1.

  gr_precio1->precio = 500.

  gr_precio2 = gr_precio1.

  WRITE: / gr_precio1->precio,
         / gr_precio2->precio.
