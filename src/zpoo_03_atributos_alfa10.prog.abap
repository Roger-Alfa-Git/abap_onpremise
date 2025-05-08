*&---------------------------------------------------------------------*
*& Report ZPOO_03_ATRIBUTOS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_03_atributos_alfa10.
CLASS cliente DEFINITION.
  PUBLIC SECTION.

    DATA: nombre TYPE string.
ENDCLASS.
CLASS factura DEFINITION.

  PUBLIC SECTION.

    DATA: no_cuenta_cliente TYPE knkli,
          cliente_factura   TYPE REF TO cliente.

    CLASS-DATA fecha_envio TYPE sydatum.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_factura_a TYPE REF TO factura,
        gr_factura_b TYPE REF TO factura,
        gr_cliente   TYPE REF TO cliente.

  CREATE OBJECT: gr_factura_a,
                 gr_factura_b,
                 gr_cliente.

  factura=>fecha_envio = '20201001'.


  gr_factura_a->no_cuenta_cliente = 'Cuenta A'.
  gr_factura_a->cliente_factura = gr_cliente.

  gr_factura_a->cliente_factura->nombre = 'Cliente A'.


  gr_factura_b->no_cuenta_cliente = 'Cuenta B'.

  WRITE : / gr_factura_a->no_cuenta_cliente,
          / gr_factura_a->cliente_factura->nombre,
          / gr_factura_a->fecha_envio.

  SKIP 2.

  WRITE : / gr_factura_b->no_cuenta_cliente,
            gr_factura_b->fecha_envio.
