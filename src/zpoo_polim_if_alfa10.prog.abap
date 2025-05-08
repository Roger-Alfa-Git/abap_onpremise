*&---------------------------------------------------------------------*
*& Report ZPOO_POLIM_IF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_polim_if_alfa10.

INTERFACE if_sociedad_co.
  METHODS definir_sociedad.
ENDINTERFACE.

CLASS sociedad_europa DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_sociedad_co.
ENDCLASS.

CLASS sociedad_europa IMPLEMENTATION.
  METHOD if_sociedad_co~definir_sociedad.
    WRITE: / 'Sociedad de Europa'.
  ENDMETHOD.
ENDCLASS.

CLASS sociedad_eeuu DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_sociedad_co.
ENDCLASS.

CLASS sociedad_eeuu IMPLEMENTATION.
  METHOD if_sociedad_co~definir_sociedad.
    WRITE: / 'Sociedad de Estados Unidos'.
  ENDMETHOD.
ENDCLASS.

CLASS centro DEFINITION.
  PUBLIC SECTION.
    METHODS asignar_sociedad IMPORTING sociedad_co TYPE REF TO if_sociedad_co.
ENDCLASS.

CLASS centro IMPLEMENTATION.
  METHOD asignar_sociedad.
    WRITE: / 'Centro asignado a la '.

    sociedad_co->definir_sociedad( ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gt_sociedad_co     TYPE STANDARD TABLE OF REF TO if_sociedad_co,
        gr_sociedad_co     TYPE REF TO if_sociedad_co,
        gr_sociedad_europa TYPE REF TO sociedad_europa,
        gr_sociedad_eeuu   TYPE REF TO sociedad_eeuu,
        gr_centro          TYPE REF TO centro.

  CREATE OBJECT: gr_sociedad_eeuu,gr_sociedad_europa,gr_centro.

  APPEND gr_sociedad_europa TO gt_sociedad_co.

  APPEND gr_sociedad_eeuu TO gt_sociedad_co.

  LOOP AT gt_sociedad_co INTO gr_sociedad_co.
    gr_sociedad_co->definir_sociedad( ).
    gr_centro->asignar_sociedad( sociedad_co = gr_sociedad_co ).
    SKIP 2.
  ENDLOOP.
