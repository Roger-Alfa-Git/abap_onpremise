*&---------------------------------------------------------------------*
*& Report ZPOO_HERENCIA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_herencia_alfa10.

CLASS sociedad DEFINITION.

  PUBLIC SECTION.
    DATA: bukrs TYPE bukrs,
          waers TYPE waers.
    METHODS: set_bukrs IMPORTING bukrs TYPE bukrs,
      set_waers IMPORTING waers TYPE waers,

      get_bukrs EXPORTING bukrs TYPE bukrs,
      get_waers EXPORTING waers TYPE waers.

ENDCLASS.

CLASS sociedad IMPLEMENTATION.

  METHOD set_bukrs.
    me->bukrs = bukrs.
    WRITE : / 'Estamos en la clase sociedad en el metodo set bukrs'.
  ENDMETHOD.

  METHOD get_bukrs.
    bukrs = me->bukrs.
  ENDMETHOD.

  METHOD set_waers.
    me->waers = waers.
    WRITE : / 'Estamos en la clase sociedad en el metodo set waers'.
  ENDMETHOD.

  METHOD get_waers.
    waers = me->waers.
  ENDMETHOD.
ENDCLASS.

CLASS centro DEFINITION INHERITING FROM sociedad.

ENDCLASS.

CLASS almacen DEFINITION INHERITING FROM centro.

ENDCLASS.

START-OF-SELECTION.

  DATA: gcl_centro TYPE REF TO centro,
        gcl_almacen TYPE REF TO almacen.

  CREATE OBJECT: gcl_centro, gcl_almacen.

  gcl_centro->set_bukrs( bukrs = '2000' ).

  gcl_centro->set_waers( waers = 'MEX' ).

  WRITE: / gcl_centro->bukrs,
           gcl_centro->waers.

  gcl_almacen->set_bukrs( bukrs = '1000' ).

  gcl_almacen->set_waers( waers = 'US' ).

  WRITE: / gcl_almacen->bukrs,
           gcl_almacen->waers.
