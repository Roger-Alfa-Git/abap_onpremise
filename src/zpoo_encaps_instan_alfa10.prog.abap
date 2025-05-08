*&---------------------------------------------------------------------*
*& Report ZPOO_ENCAPS_INSTAN_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_encaps_instan_alfa10.

CLASS conexion DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS: crear_instancia EXPORTING er_conexion TYPE REF TO conexion.

ENDCLASS.

CLASS conexion IMPLEMENTATION.
  METHOD crear_instancia.
    CREATE OBJECT er_conexion.
  ENDMETHOD.

ENDCLASS.

CLASS internet DEFINITION INHERITING FROM conexion.
  PUBLIC SECTION.
    METHODS: tipo_internet.

ENDCLASS.
CLASS internet IMPLEMENTATION.
  METHOD tipo_internet.
    DATA: lr_conexion TYPE REF TO conexion.
*      create OBJECT lr_conexion.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_conexion TYPE REF TO conexion.

  "CREATE OBJECT gr_conexion.

  conexion=>crear_instancia(
    IMPORTING
      er_conexion = gr_conexion
  ).
