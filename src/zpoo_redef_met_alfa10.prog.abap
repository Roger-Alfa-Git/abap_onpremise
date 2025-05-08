*&---------------------------------------------------------------------*
*& Report ZPOO_REDEF_MET_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_redef_met_alfa10.

CLASS pedido DEFINITION.

  PUBLIC SECTION.
    DATA: posiciones TYPE TABLE OF vbap.
    METHODS add_posicion IMPORTING posicion TYPE vbap.

ENDCLASS.

CLASS pedido IMPLEMENTATION.

  METHOD add_posicion.
    APPEND posicion TO me->posiciones.
  ENDMETHOD.

ENDCLASS.


CLASS pedido_discount DEFINITION INHERITING FROM pedido.

  PUBLIC SECTION.
    METHODS add_posicion REDEFINITION.

ENDCLASS.

CLASS pedido_discount IMPLEMENTATION.

  METHOD add_posicion.

    DATA: ls_vbap TYPE vbap.
    ls_vbap = posicion.
    ls_vbap-netwr = ls_vbap-netwr * 9 / 10.
    APPEND ls_vbap TO posiciones.

  ENDMETHOD.

ENDCLASS.

CLASS pedido_super_discount DEFINITION INHERITING FROM pedido_discount.

  PUBLIC SECTION.
    METHODS: add_posicion REDEFINITION.

ENDCLASS.

CLASS pedido_super_discount IMPLEMENTATION.

  METHOD add_posicion.

    DATA: ls_vbap TYPE vbap.
    ls_vbap = posicion.
    ls_vbap-netwr = ls_vbap-netwr * 2 / 10.
    APPEND ls_vbap TO posiciones.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_pedido_discount TYPE REF TO pedido_discount,
        gr_posicion        TYPE vbap,
        gr_perdido_super_descuento TYPE REF TO pedido_super_discount.

  CREATE OBJECT: gr_pedido_discount,gr_perdido_super_descuento.

  gr_pedido_discount->add_posicion( posicion = gr_posicion ).

  WRITE / gr_posicion-netwr.

  gr_perdido_super_descuento->add_posicion( posicion = gr_posicion ).

  WRITE / gr_posicion-netwr.
