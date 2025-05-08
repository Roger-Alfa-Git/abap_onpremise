*&---------------------------------------------------------------------*
*& Report ZPOO_EVENT_DESACTIV_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_event_desactiv_alfa10.

INTERFACE if_banco.
  EVENTS nueva_transferencia.

ENDINTERFACE.

CLASS cl_banco_bbva DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_banco.

    METHODS: crear_aviso.
ENDCLASS.

CLASS cl_banco_bbva IMPLEMENTATION.
  METHOD crear_aviso.
    WRITE: / 'Evento levantado......'.
    RAISE EVENT if_banco~nueva_transferencia.
  ENDMETHOD.

ENDCLASS.

CLASS cl_cliente_banco DEFINITION.
  PUBLIC SECTION.
    METHODS: on_nueva_transferencia FOR EVENT nueva_transferencia OF if_banco.
ENDCLASS.

CLASS cl_cliente_banco IMPLEMENTATION.
  METHOD on_nueva_transferencia.
    WRITE: 'Transferencia Realizada'.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  DATA: gr_banco_bbva TYPE REF TO cl_banco_bbva,
        gr_cliente    TYPE REF TO cl_cliente_banco.

  CREATE OBJECT: gr_banco_bbva,gr_cliente.

  SET HANDLER gr_cliente->on_nueva_transferencia FOR gr_banco_bbva ACTIVATION abap_true.

  DO 5 TIMES.
    gr_banco_bbva->crear_aviso( ).
    IF sy-index EQ 3.
      SET HANDLER gr_cliente->on_nueva_transferencia FOR gr_banco_bbva ACTIVATION abap_false.
    ENDIF.
  ENDDO.
