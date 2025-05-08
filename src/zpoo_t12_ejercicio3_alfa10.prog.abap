*&---------------------------------------------------------------------*
*& Report ZPOO_T12_EJERCICIO3_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t12_ejercicio3_alfa10.

CLASS lcl_viaje DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS: realizar_viaje FINAL.
  PROTECTED SECTION.
    METHODS: transporte_ida    ABSTRACT,
      dia_uno           ABSTRACT,
      dia_dos           ABSTRACT,
      dia_tres          ABSTRACT,
      transporte_vuelta ABSTRACT.
ENDCLASS.

CLASS lcl_viaje IMPLEMENTATION.
  METHOD realizar_viaje.
    transporte_ida( ).
    dia_uno( ).
    dia_dos( ).
    dia_tres( ).
    transporte_vuelta( ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_paquete_a DEFINITION INHERITING FROM lcl_viaje.
  PROTECTED SECTION.
    METHODS: transporte_ida REDEFINITION,
      dia_uno REDEFINITION,
      dia_dos REDEFINITION,
      dia_tres REDEFINITION,
      transporte_vuelta REDEFINITION.
ENDCLASS.

CLASS lcl_paquete_a IMPLEMENTATION.
  METHOD transporte_ida.
    WRITE: / 'Paquete A'.
    WRITE: / '$100 de viaje'.
  ENDMETHOD.
  METHOD dia_uno.
    WRITE: / '$200 primer dia'.
  ENDMETHOD.
  METHOD dia_dos.
    WRITE: / '$200 segundo dia'.
  ENDMETHOD.
  METHOD dia_tres.
    WRITE: / '$100 tercer dia'.
  ENDMETHOD.
  METHOD transporte_vuelta.
    WRITE: / '$150 devuelta'.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_paquete_b DEFINITION INHERITING FROM lcl_viaje.
  PROTECTED SECTION.
    METHODS: transporte_ida REDEFINITION,
      dia_uno REDEFINITION,
      dia_dos REDEFINITION,
      dia_tres REDEFINITION,
      transporte_vuelta REDEFINITION.
ENDCLASS.

CLASS lcl_paquete_b IMPLEMENTATION.
  METHOD transporte_ida.
    WRITE: / 'Paquete B'.
    WRITE: / '$150 de viaje'.
  ENDMETHOD.
  METHOD dia_uno.
    WRITE: / '$100 primer dia'.
  ENDMETHOD.
  METHOD dia_dos.
    WRITE: / '$100 segundo dia'.
  ENDMETHOD.
  METHOD dia_tres.
    WRITE: / '$250 tercer dia'.
  ENDMETHOD.
  METHOD transporte_vuelta.
    WRITE: / '$150 viaje devuelta'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: lo_paquete_a TYPE REF TO lcl_paquete_a,
        lo_paquete_b TYPE REF TO lcl_paquete_b.

  CREATE OBJECT: lo_paquete_a,lo_paquete_b.

  lo_paquete_a->realizar_viaje( ).
  SKIP 2.
  lo_paquete_b->realizar_viaje( ).
