*&---------------------------------------------------------------------*
*& Report ZPOO_T12_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t12_ejercicio2_alfa10.

INTERFACE lif_expediente.
  METHODS: tipo_expediente.
ENDINTERFACE.

CLASS lcl_expediente_obra DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_expediente.
    ALIASES tipo_expediente FOR lif_expediente~tipo_expediente.
ENDCLASS.

CLASS lcl_expediente_suministro DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_expediente.
    ALIASES tipo_expediente FOR lif_expediente~tipo_expediente.
ENDCLASS.

CLASS lcl_expediente_obra IMPLEMENTATION.
  METHOD tipo_expediente.
    WRITE : / 'Expediente obra'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_expediente_suministro IMPLEMENTATION.
  METHOD tipo_expediente.
    WRITE : / 'Expediente suministro'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_factoria DEFINITION.
  PUBLIC SECTION.
    METHODS: crear_expediente IMPORTING expediente TYPE string RETURNING VALUE(objeto_expediente) TYPE REF TO lif_expediente.
ENDCLASS.

CLASS lcl_factoria IMPLEMENTATION.
  METHOD: crear_expediente.
    CASE expediente.
      WHEN 'Expediente obra'.
        CREATE OBJECT objeto_expediente TYPE lcl_expediente_obra.
      WHEN 'Expediente suministro'.
        CREATE OBJECT objeto_expediente TYPE lcl_expediente_suministro.
      WHEN OTHERS.
        WRITE: / 'No existe ese tipo de expediente'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_expediente TYPE REF TO lif_expediente,
        gr_factorial  TYPE REF TO lcl_factoria.

  CREATE OBJECT gr_factorial.

  gr_expediente = gr_factorial->crear_expediente( expediente = 'Expediente suministro' ).

  gr_expediente->tipo_expediente( ).

  SKIP 2.

  gr_expediente = gr_factorial->crear_expediente( expediente = 'Expediente obra' ).

  gr_expediente->tipo_expediente( ).
