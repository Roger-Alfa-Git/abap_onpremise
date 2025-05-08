*&---------------------------------------------------------------------*
*& Include          ZBI_VIRT_ALFA10_TOP
*&---------------------------------------------------------------------*

DATA: go_custom_container TYPE REF TO cl_gui_custom_container,
      go_alv_grid         TYPE REF TO cl_gui_alv_grid,
      go_gui_cont_header  TYPE REF TO cl_gui_container,
      go_gui_cont_body    TYPE REF TO cl_gui_container.
TABLES: zbi_cln_alfa10,
        zbi_cat_alfa10.
TYPES: BEGIN OF gty_libros_papel,
         bbdd        TYPE abap_bool,
         field_style TYPE lvc_t_styl.
         INCLUDE STRUCTURE zbi_lib_alfa10.
TYPES END OF gty_libros_papel.
DATA: code TYPE syucomm.
DATA gt_fieldcat TYPE lvc_t_fcat.
DATA: gt_libros_papel TYPE TABLE OF gty_libros_papel.
DATA: gs_layout TYPE lvc_s_layo.

CLASS lcl_event_alv_grid DEFINITION DEFERRED.
DATA: go_event_alv_grid TYPE REF TO lcl_event_alv_grid.

DATA: gs_variante TYPE disvariant.
DATA: gt_toolbar_excluding TYPE ui_functions.

*/////////Listados SALV////////////////////////////////////////////////////////////////////////

DATA: go_salv_table TYPE REF TO cl_salv_table.
TYPES: BEGIN OF gty_libros_ele.
         INCLUDE TYPE zbi_lib_alfa10.
TYPES t_color TYPE lvc_t_scol.
TYPES: END OF gty_libros_ele.
CLASS lcl_event_salv_list DEFINITION DEFERRED.
DATA: gt_libros_ele TYPE TABLE OF gty_libros_ele,
      gv_first_time TYPE abap_bool,
      go_salv_event TYPE REF TO lcl_event_salv_list.

*//////ALV Jerárquico///////////////////////////////////////////////////////////
DATA: gt_hier_cat          TYPE TABLE OF zbi_cat_alfa10,
      gt_hier_lib          TYPE TABLE OF zbi_lib_alfa10,
      go_salv_hier_cat_lib TYPE REF TO cl_salv_hierseq_table.
CLASS lcl_event_salv_hierseq DEFINITION DEFERRED.
DATA: go_salv_event_hierseq TYPE REF TO lcl_event_salv_hierseq.

*//////////ALV ARBOL///////////////////////////////////////////////////////////////////////////
DATA: go_salv_tree_cat_lib_cli TYPE REF TO cl_salv_tree,
      gt_cat_lib_cli           TYPE TABLE OF zbi_cat_lib_cli_logali,
      gt_temp_cat_lib_cli      TYPE TABLE OF zbi_cat_lib_cli_logali.

*//////////ALV GUI Tree////////////////////////////////////////////////////////////////////////
DATA: go_gui_tree_acc_cat_lib TYPE REF TO cl_gui_alv_tree,
      gs_gui_tree_header      TYPE treev_hhdr,
      gt_gui_tree_fieldcat    TYPE lvc_t_fcat,
      gt_acc_cat_lib          TYPE TABLE OF zbi_acc_cat_lib_logali,
      gt_temp_acc_cat_lib     TYPE TABLE OF zbi_acc_cat_lib_logali,
      lt_values               TYPE TABLE OF dd07v,
      ls_values               TYPE dd07v,
      gv_fav_key              TYPE lvc_nkey.
DATA: gv_fav_folder_id  TYPE i,
      gv_fav_line_id    TYPE i,
      go_line_behaviour TYPE REF TO cl_dragdrop,
      go_fav_behaviour  TYPE REF TO cl_dragdrop.
CLASS lcl_gui_tree_events DEFINITION DEFERRED.
DATA go_gui_tree_events TYPE REF TO lcl_gui_tree_events.
