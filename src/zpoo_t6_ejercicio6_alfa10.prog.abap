*&---------------------------------------------------------------------*
*& Report ZPOO_T6_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t6_ejercicio6_alfa10.

INTERFACE if_navegador.
  EVENTS cerrar_ventana.
ENDINTERFACE.

CLASS cl_sistema_operativo DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_navegador.
    METHODS: movimiento_raton.
ENDCLASS.

CLASS cl_sistema_operativo IMPLEMENTATION.
  METHOD movimiento_raton.
    RAISE EVENT if_navegador~cerrar_ventana.
  ENDMETHOD.
ENDCLASS.

CLASS cl_chorme DEFINITION.
  PUBLIC SECTION.
    METHODS: on_cerrar_ventana FOR EVENT cerrar_ventana OF if_navegador.
ENDCLASS.

CLASS cl_chorme IMPLEMENTATION.
  METHOD on_cerrar_ventana.
    WRITE: / 'Fuera de Chorme'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_sistema_operativo TYPE REF TO cl_sistema_operativo,
        gr_chorme            TYPE REF TO cl_chorme.

  CREATE OBJECT: gr_sistema_operativo, gr_chorme.

  SET HANDLER gr_chorme->on_cerrar_ventana FOR gr_sistema_operativo.
* t6_ejercicio7_alfa10.
  gr_sistema_operativo->movimiento_raton( ).

  SET HANDLER gr_chorme->on_cerrar_ventana FOR gr_sistema_operativo ACTIVATION abap_false.

  WRITE: / 'Salto'.

  gr_sistema_operativo->movimiento_raton( ).
