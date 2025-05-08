*&---------------------------------------------------------------------*
*& Report ZPOO_CONSTR_HEREN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_constr_heren_alfa10.

CLASS presupuesto DEFINITION .
  PUBLIC SECTION.
    DATA: ejercicio TYPE gjahr.

    METHODS constructor IMPORTING ejercicio TYPE gjahr.

ENDCLASS.

CLASS presupuesto IMPLEMENTATION.

  METHOD constructor.
    me->ejercicio = ejercicio.
  ENDMETHOD.
ENDCLASS.


CLASS pedido DEFINITION INHERITING FROM presupuesto.

  PUBLIC SECTION.
    METHODS constructor IMPORTING ejercicio  TYPE gjahr
                                  doc_ventas TYPE vbeln_va.

  PRIVATE SECTION.
    DATA: doc_ventas TYPE vbeln_va.

ENDCLASS.

CLASS pedido IMPLEMENTATION.

  METHOD constructor.

    super->constructor( ejercicio = ejercicio ).
    me->doc_ventas  = doc_ventas.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: gr_pedido TYPE REF TO pedido.

  CREATE OBJECT gr_pedido
    EXPORTING
      ejercicio  = '2020'
      doc_ventas = '5489'.

  WRITE: / gr_pedido->ejercicio.
