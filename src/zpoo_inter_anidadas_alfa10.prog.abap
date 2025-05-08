*&---------------------------------------------------------------------*
*& Report ZPOO_INTER_ANIDADAS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_inter_anidadas_alfa10.

INTERFACE if_documento.
  DATA: doc_ventas TYPE vbeln_va.

  METHODS: set_doc_ventas IMPORTING doc_ventas TYPE vbeln_va.
ENDINTERFACE.

INTERFACE if_pedido.
  INTERFACES: if_documento.

  METHODS: generar_pedido.
ENDINTERFACE.

CLASS departamento_ventas DEFINITION.

  PUBLIC SECTION.
    INTERFACES if_pedido.

ENDCLASS.

CLASS departamento_ventas IMPLEMENTATION.

  METHOD if_pedido~generar_pedido.
    WRITE: / 'Generando pedido (interfaz if_pedido)'.
  ENDMETHOD.

  METHOD if_documento~set_doc_ventas.
    me->if_documento~doc_ventas = doc_ventas.

    WRITE: / 'Con el documento contable: ',me->if_documento~doc_ventas.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_departamento_ventas TYPE REF TO departamento_ventas.

  CREATE OBJECT: gr_departamento_ventas.

  gr_departamento_ventas->if_pedido~generar_pedido( ).

  gr_departamento_ventas->if_documento~set_doc_ventas( doc_ventas = '3200' ).
