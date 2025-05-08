*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_2_1_ALFA10_TOP
*&---------------------------------------------------------------------*
DATA: go_custom_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid         TYPE REF TO cl_gui_alv_grid,
      go_gui_cont_header  TYPE REF TO cl_gui_container,
      go_gui_cont_body    TYPE REF TO cl_gui_container.
TABLES: sflight,spfli,scarr,t005,t005t,sairport.

DATA: code TYPE syucomm.
DATA gt_fieldcat TYPE lvc_t_fcat.
DATA: gt_tabla    TYPE STANDARD TABLE OF zdataflightalfa10.
DATA: gt_tabla2 TYPE TABLE OF zdataflighttablealfa10,
      gs_tabla  TYPE zdataflightalfa10,
      gs_tabla2 TYPE zdataflighttablealfa10.
DATA: gs_layout TYPE lvc_s_layo.

CLASS lcl_event_alv_grid DEFINITION DEFERRED.
DATA: go_event_alv_grid TYPE REF TO lcl_event_alv_grid.

DATA: gs_variante TYPE disvariant.
DATA: gt_toolbar_excluding TYPE ui_functions.

DATA: gv_carri       TYPE string,
      gv_conni       TYPE string,
      gv_confr       TYPE string,
      gv_conto       TYPE string,
      gv_first_time  TYPE abap_bool,
      gv_table_start TYPE abap_bool.
