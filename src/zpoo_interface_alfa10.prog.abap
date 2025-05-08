*&---------------------------------------------------------------------*
*& Report ZPOO_INTERFACE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_interface_alfa10.

INTERFACE if_agencia.

  DATA: tipo TYPE string.

  CLASS-DATA: dirreccion TYPE string.

  METHODS: set_tipo IMPORTING tipo TYPE string,
    get_tipo RETURNING VALUE(tipo) TYPE string.

  CLASS-METHODS: set_dirreccion IMPORTING direccion TYPE string.

ENDINTERFACE.

CLASS agencia_viajes DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_agencia.
ENDCLASS.

CLASS agencia_viajes IMPLEMENTATION.

  METHOD if_agencia~set_tipo.
    me->if_agencia~tipo = tipo.
  ENDMETHOD.

  METHOD if_agencia~get_tipo.
    tipo = me->if_agencia~tipo.
  ENDMETHOD.

  METHOD if_agencia~set_dirreccion.
    agencia_viajes=>if_agencia~dirreccion = direccion.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_agencia_viajes TYPE REF TO agencia_viajes.

  CREATE OBJECT: gr_agencia_viajes.

  gr_agencia_viajes->if_agencia~set_tipo( tipo = 'Agencia Viajes Online' ).

  gr_agencia_viajes->if_agencia~set_dirreccion( direccion = 'Tenancingo, Tlaxcala' ).

  WRITE: / gr_agencia_viajes->if_agencia~get_tipo( ),
         / agencia_viajes=>if_agencia~dirreccion.
