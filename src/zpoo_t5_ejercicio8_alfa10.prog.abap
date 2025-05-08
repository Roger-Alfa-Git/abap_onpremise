*&---------------------------------------------------------------------*
*& Report ZPOO_T5_EJERCICIO8_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t5_ejercicio8_alfa10.

CLASS cl_abap_objectdescr DEFINITION LOAD.

CLASS cl_organizacion DEFINITION.
  PUBLIC SECTION.
    DATA:  sede TYPE TABLE OF string.
    METHODS: set_sede IMPORTING sede TYPE string,
      ver_sede.
ENDCLASS.
CLASS cl_organizacion IMPLEMENTATION.
  METHOD set_sede.
    APPEND sede TO me->sede.
  ENDMETHOD.

  METHOD ver_sede.
    DATA lv_sede TYPE string.
    LOOP AT sede INTO lv_sede.
      WRITE: / 'Sede: ',lv_sede.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_objeto TYPE REF TO object,
        gr_sede   TYPE string,
        gr_metodo TYPE string,
        gt_param  TYPE abap_parmbind_tab,
        gs_param  TYPE abap_parmbind.

  CREATE OBJECT: gr_objeto TYPE cl_organizacion.

  gr_sede = 'Tenancingo'.

  gr_metodo = 'SET_SEDE'.

  CALL METHOD gr_objeto->(gr_metodo) EXPORTING sede = gr_sede.

  gr_metodo = 'VER_SEDE'.

  CALL METHOD gr_objeto->(gr_metodo).

  gs_param-name = 'SEDE'.
  gs_param-kind = cl_abap_objectdescr=>exporting.
  GET REFERENCE OF gr_sede INTO gs_param-value.

  INSERT gs_param INTO TABLE gt_param.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  CALL METHOD gr_objeto->('SET_SEDE') PARAMETER-TABLE gt_param.

  CALL METHOD gr_objeto->('VER_SEDE').
