*&---------------------------------------------------------------------*
*& Report ZPOO_INST_OBJECT_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_inst_object_alfa10.

CLASS cl_abap_objectdescr DEFINITION LOAD.

CLASS cl_almacen DEFINITION.
  PUBLIC SECTION.
    DATA: productos TYPE TABLE OF string.

    METHODS: add_producto IMPORTING producto TYPE string,
      total_productos.
ENDCLASS.

CLASS cl_almacen IMPLEMENTATION.
  METHOD add_producto.
    APPEND producto TO me->productos.
  ENDMETHOD.

  METHOD total_productos.
    DATA: lv_total TYPE i.

    DESCRIBE TABLE me->productos LINES lv_total.

    WRITE: / 'Total productos ',lv_total.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: gr_object      TYPE REF TO object,
        gv_method_name TYPE string,
        gr_producto    TYPE string,
        gt_param       TYPE abap_parmbind_tab,
        gs_param       TYPE abap_parmbind.

  CREATE OBJECT gr_object TYPE cl_almacen.

  gr_producto = 'Procesador'.

  gv_method_name = 'TOTAL_PRODUCTOS'.

  CALL METHOD gr_object->(gv_method_name).

  gv_method_name = 'ADD_PRODUCTO'.

  CALL METHOD gr_object->(gv_method_name) EXPORTING producto = gr_producto.

  gv_method_name = 'TOTAL_PRODUCTOS'.

  CALL METHOD gr_object->(gv_method_name).

  gs_param-name = 'PRODUCTO'.
  gs_param-kind = cl_abap_objectdescr=>exporting.
  GET REFERENCE OF gr_producto INTO gs_param-value.

  INSERT gs_param INTO TABLE gt_param.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  gv_method_name = 'ADD_PRODUCTO'.

  CALL METHOD gr_object->(gv_method_name) PARAMETER-TABLE gt_param.

  gv_method_name = 'TOTAL_PRODUCTOS'.

  CALL METHOD gr_object->(gv_method_name).
