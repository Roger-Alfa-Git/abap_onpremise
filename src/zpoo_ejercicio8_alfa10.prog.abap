*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO8_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio8_alfa10.

CLASS cl_elementos DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF types_elem_objectos,
             clase      TYPE string,
             instancia  TYPE string,
             referencia TYPE string,
           END OF types_elem_objectos.

    DATA: mi_objeto TYPE types_elem_objectos.

    METHODS set_mi_objeto IMPORTING iv_objeto TYPE types_elem_objectos.
ENDCLASS.

CLASS cl_elementos IMPLEMENTATION.

  METHOD set_mi_objeto.
    mi_objeto = iv_objeto.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_elementos TYPE REF TO cl_elementos,
        gv_elementos TYPE cl_elementos=>types_elem_objectos.

  gv_elementos-clase = 'Ejercicio'.
  gv_elementos-instancia = '2.8'.
  gv_elementos-referencia = 'Objetos'.

  CREATE OBJECT gr_elementos.

  gr_elementos->set_mi_objeto( iv_objeto = gv_elementos ).

  WRITE: / gr_elementos->mi_objeto-clase,
         / gr_elementos->mi_objeto-instancia,
         / gr_elementos->mi_objeto-referencia.
