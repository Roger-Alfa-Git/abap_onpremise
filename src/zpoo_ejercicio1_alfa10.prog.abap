*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO1_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio1_alfa10.

CLASS material DEFINITION.
  PUBLIC SECTION.
    DATA: matnr          TYPE matnr,
          fecha_creacion TYPE ersda.

    METHODS: set_matnr IMPORTING i_matnr TYPE matnr,
      set_fecha_creacion IMPORTING i_fecha_creacion TYPE ersda.
ENDCLASS.

CLASS material IMPLEMENTATION.

  METHOD set_matnr.
    matnr = i_matnr.
  ENDMETHOD.

  METHOD set_fecha_creacion.
    fecha_creacion = i_fecha_creacion.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_material TYPE REF TO material.

  CREATE OBJECT gr_material.
