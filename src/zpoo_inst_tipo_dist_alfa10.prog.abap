*&---------------------------------------------------------------------*
*& Report ZPOO_INST_TIPO_DIST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_inst_tipo_dist_alfa10.

INTERFACE if_contrato.
  DATA tipo_contrato TYPE char2.
  METHODS set_tipo_contrato IMPORTING tipo_contrato TYPE char2.
ENDINTERFACE.

CLASS cl_contrato_obra DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_contrato.
ENDCLASS.

CLASS cl_contrato_obra IMPLEMENTATION.
  METHOD if_contrato~set_tipo_contrato.
    me->if_contrato~tipo_contrato = tipo_contrato.
  ENDMETHOD.
ENDCLASS.

CLASS cl_expediente DEFINITION INHERITING FROM cl_contrato_obra.

ENDCLASS.

START-OF-SELECTION.

  DATA: gr_contrato TYPE REF TO if_contrato.

  CREATE OBJECT gr_contrato TYPE cl_contrato_obra.

  "DATA gr_contrato_obra TYPE REF TO cl_contrato_obra.

  " CREATE OBJECT gr_contrato_obra.

*  gr_contrato = gr_contrato_obra.

  CREATE OBJECT gr_contrato TYPE cl_expediente.
