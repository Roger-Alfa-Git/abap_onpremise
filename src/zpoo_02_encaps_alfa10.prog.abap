*&---------------------------------------------------------------------*
*& Report ZPOO_02_ENCAPS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_02_encaps_alfa10.

CLASS factura DEFINITION.

  PUBLIC SECTION.

    DATA: sociedad TYPE bukrs.

    METHODS emitir_factura.

  PROTECTED SECTION.

    DATA: fecha TYPE sydatum.

  PRIVATE SECTION.

    METHODS aceptar_pago IMPORTING cuenta TYPE hkont.

ENDCLASS.

CLASS factura IMPLEMENTATION.
  METHOD emitir_factura.

  ENDMETHOD.

  METHOD aceptar_pago.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_factura TYPE REF TO factura.
