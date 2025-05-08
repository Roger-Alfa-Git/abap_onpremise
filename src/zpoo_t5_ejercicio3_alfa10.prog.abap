*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO3_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio3_alfa10.

INTERFACE if_personal.
  METHODS: numero_empleados.
ENDINTERFACE.

CLASS personal_interno DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_personal.
ENDCLASS.

CLASS personal_interno IMPLEMENTATION.
  METHOD if_personal~numero_empleados.
    WRITE: / 'Personal Interno'.
  ENDMETHOD.
ENDCLASS.

CLASS personal_expatriado DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_personal.
ENDCLASS.

CLASS personal_expatriado IMPLEMENTATION.
  METHOD if_personal~numero_empleados.
    WRITE: / 'Personal Expatriado'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gt_personal            TYPE STANDARD TABLE OF REF TO if_personal,
        gr_personal            TYPE REF TO if_personal,
        gr_personal_interno    TYPE REF TO personal_interno,
        gr_personal_expatriado TYPE REF TO personal_expatriado.

  CREATE OBJECT: gr_personal_interno, gr_personal_expatriado.

  APPEND gr_personal_interno TO gt_personal.

  APPEND gr_personal_expatriado TO gt_personal.

  LOOP AT gt_personal INTO gr_personal.
    gr_personal->numero_empleados( ).
  ENDLOOP.
