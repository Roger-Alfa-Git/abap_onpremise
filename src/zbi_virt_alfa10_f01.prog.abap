*&---------------------------------------------------------------------*
*& Include          ZBI_VIRT_ALFA10_F01
*&---------------------------------------------------------------------*
FORM init_2000.
  CHECK code IS NOT INITIAL.
  CASE code.
    WHEN 'LIB_P'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ELSEIF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ELSE.
      ENDIF.
      PERFORM libros_de_papel.
    WHEN 'LIB_E'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ELSEIF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.
      PERFORM libros_electronicos.
    WHEN 'CAT_L'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ENDIF.
      PERFORM categorias_libros.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.
    WHEN 'CAT_LC'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ENDIF.
      PERFORM categorias_libros_clientes.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.
    WHEN 'ACC_C_L'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ENDIF.
      PERFORM acceso_categorias_libros.
      IF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ENDIF.
    WHEN 'UNDO'.
      PERFORM free_container.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.

FORM libros_de_papel .
  IF go_custom_container IS NOT BOUND.
    PERFORM instance_cust_cont USING 'P'.
    PERFORM get_data.
    PERFORM build_layout.
    PERFORM build_field_cat.
    PERFORM instance_alv_lib_papel.
    PERFORM create_alv_grid_header.
    PERFORM set_alv_grid_handlers.
    PERFORM register_events.
    PERFORM create_alv_grid_variants.
    PERFORM exclude_alv_grid_toolbar.
    PERFORM display_alv_lib_papel.
  ELSE.
    PERFORM refresh_alv_lib_papel.
  ENDIF.
ENDFORM.

FORM instance_cust_cont USING pv_tipo_op.
  DATA: lo_gui_splitter_cont TYPE REF TO cl_gui_splitter_container.
  CREATE OBJECT go_custom_container
    EXPORTING
*     parent                      = " Parent container
      container_name              = 'ALV_CONT' " Name of the Screen CustCtrl Name to Link Container To
*     style                       = " Windows Style Attributes Applied to this Container
*     lifetime                    = LIFETIME_DEFAULT " Lifetime
*     repid                       = " Screen to Which this Container is Linked
*     dynnr                       = " Report To Which this Container is Linked
*     no_autodef_progid_dynnr     = " Don't Autodefined Progid and Dynnr?
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
  IF pv_tipo_op EQ 'P'.
    CREATE OBJECT lo_gui_splitter_cont
      EXPORTING
*       link_dynnr        =
*       link_repid        =
*       shellstyle        =
*       left              =
*       top               =
*       width             =
*       height            =
*       metric            = cntl_metric_dynpro
*       align             = 15
        parent            = go_custom_container
        rows              = 2
        columns           = 1
*       no_autodef_progid_dynnr =
*       name              =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    lo_gui_splitter_cont->get_container(
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui_cont_header
    ).
    lo_gui_splitter_cont->set_row_height(
      EXPORTING
        id                = 1
        height            = 30
*    IMPORTING
*      result            =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    lo_gui_splitter_cont->get_container(
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui_cont_body
    ).
  ENDIF.

ENDFORM.

FORM build_field_cat .
  FIELD-SYMBOLS: <ls_fieldcat> TYPE lvc_s_fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZBI_LIB_ALFA10'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE 'Fieldcat error' TYPE 'E'.
  ELSE.
    LOOP AT gt_fieldcat ASSIGNING <ls_fieldcat>.
      CASE <ls_fieldcat>-fieldname.
        WHEN 'BI_CATEG'.
          <ls_fieldcat>-f4availabl = abap_true.
        WHEN 'ID_LIBRO'.
          <ls_fieldcat>-hotspot = abap_true.
        WHEN 'PRECIO'.
          <ls_fieldcat>-do_sum = abap_true.
      ENDCASE.
    ENDLOOP.
  ENDIF.
ENDFORM.

FORM get_data .
  CASE code.
    WHEN 'LIB_P'.
      SELECT * FROM zbi_lib_alfa10
        INTO CORRESPONDING FIELDS OF TABLE gt_libros_papel
        WHERE formato EQ 'P'.
    WHEN 'LIB_E'.
      SELECT * FROM zbi_lib_alfa10
        INTO CORRESPONDING FIELDS OF TABLE gt_libros_ele
        WHERE formato EQ 'E'.
    WHEN 'CAT_L'.
      PERFORM get_data_cat_lib.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.

FORM instance_alv_lib_papel .
  CREATE OBJECT go_alv_grid
    EXPORTING
*     i_shellstyle      = 0
*     i_lifetime        =
      i_parent          = go_gui_cont_body
*     i_appl_events     = space
*     i_parentdbg       =
*     i_applogparent    =
*     i_graphicsparent  =
*     i_name            =
*     i_fcat_complete   = space
*     o_previous_sral_handler =
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM display_alv_lib_papel .
  DATA: lt_sort TYPE lvc_t_sort,
        ls_sort TYPE lvc_s_sort.
  DATA: lt_filter TYPE lvc_t_filt,
        ls_filter TYPE lvc_s_filt,
        lv_filtro TYPE string VALUE 'S'.

  ls_sort-fieldname = 'AUTOR'.
  ls_sort-up = abap_true.
  APPEND ls_sort TO lt_sort.

  ls_filter-fieldname = 'IDIOMA'.
  ls_filter-sign = 'I'.
  ls_filter-option = 'EQ'.
  ls_filter-low = lv_filtro.
  APPEND ls_filter TO lt_filter.

  go_alv_grid->set_table_for_first_display(
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
      is_variant                    = gs_variante
      i_save                        = 'U'
*      i_default                     = 'X'
      is_layout                     = gs_layout
*      is_print                      =
*      it_special_groups             =
      it_toolbar_excluding          = gt_toolbar_excluding
*      it_hyperlink                  =
*      it_alv_graphics               =
*      it_except_qinfo               =
*      ir_salv_adapter               =
    CHANGING
      it_outtab                     = gt_libros_papel
      it_fieldcatalog               = gt_fieldcat
      it_sort                       = lt_sort
      it_filter                     = lt_filter
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM refresh_alv_lib_papel .
  go_alv_grid->refresh_table_display(
*    EXPORTING
*      is_stable      =
*      i_soft_refresh =
    EXCEPTIONS
      finished       = 1
      OTHERS         = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM free_container .
  IF go_custom_container IS BOUND.
    go_custom_container->free(
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    CLEAR go_custom_container.
  ENDIF.
  IF go_alv_grid IS BOUND.
    CLEAR go_alv_grid.
  ENDIF.
  IF go_event_alv_grid IS BOUND.
    CLEAR go_event_alv_grid.
  ENDIF.
  IF go_salv_table IS BOUND.
    CLEAR go_salv_table.
  ENDIF.
  IF go_salv_event IS BOUND.
    CLEAR go_salv_event.
  ENDIF.
  IF go_salv_hier_cat_lib IS BOUND.
    CLEAR go_salv_hier_cat_lib.
  ENDIF.
  IF go_salv_tree_cat_lib_cli IS BOUND.
    CLEAR: go_salv_tree_cat_lib_cli,
           gt_cat_lib_cli,
           gt_temp_cat_lib_cli.
  ENDIF.
  IF go_gui_tree_acc_cat_lib IS BOUND.
    CLEAR: go_gui_tree_acc_cat_lib,
           gt_acc_cat_lib,
           gt_temp_acc_cat_lib.
  ENDIF.
ENDFORM.

FORM build_layout .
  FIELD-SYMBOLS <ls_libros_papel> TYPE gty_libros_papel.
  DATA: ls_style TYPE lvc_s_styl.
  gs_layout-zebra = abap_true.
  gs_layout-edit = abap_true.
  gs_layout-stylefname = 'FIELD_STYLE'.
  gs_layout-cwidth_opt = abap_true.

  LOOP AT gt_libros_papel ASSIGNING <ls_libros_papel>.
    ls_style-fieldname = 'MANDT'.
    ls_style-style = cl_gui_alv_grid=>mc_style_disabled.
    INSERT ls_style INTO TABLE <ls_libros_papel>-field_style.

    ls_style-fieldname = 'ID_LIBRO'.
    ls_style-style = cl_gui_alv_grid=>mc_style_disabled.
    INSERT ls_style INTO TABLE <ls_libros_papel>-field_style.

    ls_style-fieldname = 'BI_CATEG'.
    ls_style-style = cl_gui_alv_grid=>mc_style_disabled.
    INSERT ls_style INTO TABLE <ls_libros_papel>-field_style.
  ENDLOOP.
ENDFORM.

FORM set_alv_grid_handlers .
  IF go_event_alv_grid IS NOT BOUND.
    CREATE OBJECT go_event_alv_grid.

    SET HANDLER: go_event_alv_grid->handle_data_changed FOR go_alv_grid,
                 go_event_alv_grid->handle_double_click FOR go_alv_grid,
                 go_event_alv_grid->handle_user_command FOR go_alv_grid,
                 go_event_alv_grid->handle_toolbar FOR go_alv_grid,
                 go_event_alv_grid->handle_cnf4 FOR go_alv_grid,
                 go_event_alv_grid->handle_data_changed_finished FOR go_alv_grid,
                 go_event_alv_grid->handle_hotspot_click FOR go_alv_grid.
  ENDIF.
ENDFORM.

FORM register_events.
  DATA: lt_f4 TYPE lvc_t_f4,
        ls_f4 TYPE lvc_s_f4.
  ls_f4-fieldname = 'BI_CATEG'.
  ls_f4-register = abap_true.
  APPEND ls_f4 TO lt_f4.

  go_alv_grid->register_f4_for_fields( it_f4 = lt_f4 ).

  CALL METHOD go_alv_grid->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_enter
    EXCEPTIONS
      error      = 1
      OTHERS     = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM create_alv_grid_variants .
  gs_variante-report = sy-repid.
ENDFORM.

FORM exclude_alv_grid_toolbar .
  DATA:ls_exclude TYPE ui_func.
  ls_exclude = cl_gui_alv_grid=>mc_fc_info.
  APPEND ls_exclude TO gt_toolbar_excluding.
ENDFORM.

FORM create_alv_grid_header .
  DATA: lo_doc_cabec   TYPE REF TO cl_dd_document,
        lv_text        TYPE sdydo_text_element VALUE 'Bienvenido ALFA10',
        lv_no_libros   TYPE i,
        lv_no_lib_char TYPE string.

  CREATE OBJECT lo_doc_cabec.

  lo_doc_cabec->add_text_as_heading(
    EXPORTING
      text          = lv_text
*      sap_color     =
*      sap_fontstyle =
      heading_level = 1
*      a11y_tooltip  =
*    CHANGING
*      document      =
  ).
  DESCRIBE TABLE gt_libros_papel LINES lv_no_libros.
  lv_no_lib_char = lv_no_libros.
  CONCATENATE 'Nº de libros de papel disponibles' lv_no_lib_char INTO lv_text SEPARATED BY space.
  lo_doc_cabec->add_text( EXPORTING text = lv_text ).
  lo_doc_cabec->new_line(  ).
  WRITE sy-datum DD/MM/YYYY TO lv_text.
  lo_doc_cabec->add_text( EXPORTING text = lv_text ).
  lo_doc_cabec->display_document(
    EXPORTING
*      reuse_control      =
*      reuse_registration =
*      container          =
      parent             = go_gui_cont_header
    EXCEPTIONS
      html_display_error = 1
      OTHERS             = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&----Listado ALV------------------------------------------------------*
*&---------------------------------------------------------------------*

FORM libros_electronicos .
  IF go_salv_table IS NOT BOUND.
    PERFORM get_data.
    PERFORM instance_cust_cont USING 'E'.
    PERFORM instance_salv.
    PERFORM enable_salv_functions.
    PERFORM enable_salv_events.
    PERFORM change_salv_layout.
    PERFORM change_salv_columns.
    PERFORM add_salv_aggregations.
    PERFORM add_salv_sorts.
    PERFORM add_salv_filters.
    PERFORM add_salv_colors.
  ENDIF.
  PERFORM display_salv.
ENDFORM.

FORM instance_salv.
  DATA: lx_salv_msg TYPE REF TO cx_salv_msg.
  TRY.
      Cl_SALV_TABLE=>factory(
      EXPORTING
*        list_display   = if_salv_c_bool_sap=>false
        r_container    = go_custom_container
*        container_name =
        IMPORTING
          r_salv_table   = go_salv_table
        CHANGING
          t_table        = gt_libros_ele
      ).
    CATCH cx_salv_msg INTO lx_salv_msg.
      WRITE: lx_salv_msg->get_text( ).
  ENDTRY.
ENDFORM.

FORM display_salv .
  go_salv_table->display( ).
ENDFORM.

FORM enable_salv_functions .
  DATA: lo_functions TYPE REF TO cl_salv_functions_list,
        lv_name      TYPE salv_de_function,
        lv_icon      TYPE string,
        lv_tooltip   TYPE string.
  lo_functions = go_salv_table->get_functions( ).
  lo_functions->set_all(  ).
  lv_name = 'TOTAL'.
  lv_icon = icon_apple_numbers.
  lv_tooltip = 'Nº total de libros electrónicos'.
  TRY.
      lo_functions->add_function(
        EXPORTING
          name     = lv_name
          icon     = lv_icon
*      text     =
          tooltip  = lv_tooltip
          position = if_salv_c_function_position=>right_of_salv_functions
      ).
    CATCH cx_salv_existing.
    CATCH cx_salv_wrong_call.
  ENDTRY.
ENDFORM.

FORM enable_salv_events .
  DATA: lo_events TYPE REF TO cl_salv_events_table.
  IF go_salv_event IS NOT BOUND.
    CREATE OBJECT go_salv_event.
    lo_events = go_salv_table->get_event(  ).
    SET HANDLER go_salv_event->handle_added_function FOR lo_events.
  ENDIF.
ENDFORM.

FORM change_salv_layout .
  DATA: lo_salv_layout TYPE REF TO cl_salv_layout,
        ls_key         TYPE salv_s_layout_key,
        lv_variant     TYPE slis_vari.
  lo_salv_layout = go_salv_table->get_layout(  ).
  ls_key-report = sy-repid.
  ls_key-logical_group = 'LIE'.
  lo_salv_layout->set_key( ls_key ).
  lo_salv_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).
  lv_variant = 'DEFAULT'.
  lo_salv_layout->set_initial_layout( lv_variant ).
ENDFORM.

FORM change_salv_columns .
  DATA: lo_colums     TYPE REF TO cl_salv_columns_table,
        lo_sng_column TYPE REF TO cl_salv_column.
  lo_colums = go_salv_table->get_columns(  ).
  lo_colums->set_optimize( abap_true ).
  TRY.
      lo_sng_column = lo_colums->get_column( columnname = 'MANDT' ).
      lo_sng_column->set_visible( if_salv_c_bool_sap=>false ).
    CATCH cx_salv_not_found.
  ENDTRY.
ENDFORM.

FORM add_salv_aggregations .
  DATA: lo_aggregations TYPE REF TO cl_salv_aggregations,
        lo_aggregation  TYPE REF TO cl_salv_aggregation.
  lo_aggregations = go_salv_table->get_aggregations( ).
  TRY.
      lo_aggregations->add_aggregation(
        EXPORTING
          columnname  = 'PRECIO'
          aggregation = if_salv_c_aggregation=>total
      RECEIVING
        value       = lo_aggregation
      ).
    CATCH cx_salv_data_error.
    CATCH cx_salv_not_found.
    CATCH cx_salv_existing.
  ENDTRY.
ENDFORM.

FORM add_salv_sorts .
  DATA: lo_sorts TYPE REF TO cl_salv_sorts,
        lo_sort  TYPE REF TO cl_salv_sort.
  lo_sorts = go_salv_table->get_sorts( ).
  TRY.
      lo_sorts->add_sort(
        EXPORTING
          columnname = 'AUTOR'
*        position   =
        sequence   = if_salv_c_sort=>sort_up
        subtotal   = if_salv_c_bool_sap=>true
*        group      = if_salv_c_sort=>group_none
*        obligatory = if_salv_c_bool_sap=>false
      RECEIVING
        value      = lo_sort
      ).
    CATCH cx_salv_not_found.
    CATCH cx_salv_existing.
    CATCH cx_salv_data_error.

  ENDTRY.
ENDFORM.

FORM add_salv_filters .
  DATA: lo_filters TYPE REF TO cl_salv_filters,
        lo_filter  TYPE REF TO cl_salv_filter.
  lo_filters = go_salv_table->get_filters( ).
  TRY.
      lo_filters->add_filter(
        EXPORTING
          columnname = 'IDIOMA'
          sign       = 'I'
          option     = 'EQ'
          low        = 'S'
*        high       =
        RECEIVING
          value      = lo_filter
      ).
    CATCH cx_salv_not_found.
    CATCH cx_salv_data_error.
    CATCH cx_salv_existing.
  ENDTRY.
ENDFORM.

FORM add_salv_colors .
  DATA: lo_colums    TYPE REF TO cl_salv_columns_table,
        lo_colum     TYPE REF TO cl_salv_column_table,
        ls_color     TYPE lvc_s_colo,
        ls_color_all TYPE lvc_s_scol.
  FIELD-SYMBOLS <ls_lib_ele> TYPE gty_libros_ele.
  lo_colums = go_salv_table->get_columns( ).
  TRY.
      lo_colum ?= lo_colums->get_column( columnname = 'MONEDA' ).
      ls_color-col = 7.
      ls_color-int = 0.
      ls_color-inv = 0.
      lo_colum->set_color( ls_color ).
    CATCH cx_salv_not_found.
  ENDTRY.
  LOOP AT gt_libros_ele ASSIGNING <ls_lib_ele>.
    IF <ls_lib_ele>-moneda EQ 'EUR'.
      ls_color_all-fname = 'MONEDA'.
      ls_color_all-color-col = 7.
      ls_color_all-color-int = 0.
      ls_color_all-color-inv = 0.
      APPEND ls_color_all TO <ls_lib_ele>-t_color.
    ENDIF.
    IF <ls_lib_ele>-moneda EQ 'USD'.
      ls_color_all-fname = 'MONEDA'.
      ls_color_all-color-col = 7.
      ls_color_all-color-int = 0.
      ls_color_all-color-inv = 1.
      APPEND ls_color_all TO <ls_lib_ele>-t_color.
    ENDIF.
  ENDLOOP.
  TRY.
      lo_colums->set_color_column( value = 'T_COLOR' ).
    CATCH cx_salv_data_error.
  ENDTRY.
ENDFORM.

FORM get_data_cat_lib .
  DATA: lt_cond_tab     TYPE TABLE OF hrcond,
        ls_cond_tab     TYPE  hrcond,
        lt_where_clause TYPE TABLE OF string.
  IF NOT zbi_cat_alfa10-bi_categ IS INITIAL.
    ls_cond_tab-field = 'BI_CATEG'.
    ls_cond_tab-opera = 'EQ'.
    CONCATENATE '%' zbi_cat_alfa10-bi_categ '%' INTO ls_cond_tab-low.
    APPEND ls_cond_tab TO lt_cond_tab.
  ENDIF.
  IF NOT zbi_cat_alfa10-descripcion IS INITIAL.
    ls_cond_tab-field = 'DESCRIPCION'.
    ls_cond_tab-opera = 'EQ'.
    ls_cond_tab-low = zbi_cat_alfa10-descripcion.
    APPEND ls_cond_tab TO lt_cond_tab.
  ENDIF.
  IF NOT zbi_cat_alfa10-bi_categ IS INITIAL.
    ls_cond_tab-field = 'BI_CATEG'.
    ls_cond_tab-opera = 'EQ'.
    CONCATENATE '%' zbi_cat_alfa10-bi_categ '%' INTO ls_cond_tab-low.
    APPEND ls_cond_tab TO lt_cond_tab.
  ENDIF.
  IF NOT lt_cond_tab IS INITIAL.
    CALL FUNCTION 'RH_DYNAMIC_WHERE_BUILD'
      EXPORTING
        dbtable         = 'ZBI_CAT_ALFA10'
      TABLES
        condtab         = lt_cond_tab
        where_clause    = lt_where_clause
      EXCEPTIONS
        empty_condtab   = 1
        no_db_field     = 2
        unknown_db      = 3
        wrong_condition = 4
        OTHERS          = 5.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ENDIF.
  ENDIF.
  IF NOT lt_where_clause IS INITIAL.
    SELECT * FROM zbi_cat_alfa10
      INTO TABLE gt_hier_cat
      WHERE (lt_where_clause).
  ELSE.
    SELECT * FROM zbi_cat_alfa10
      INTO TABLE gt_hier_cat.
  ENDIF.
  IF sy-subrc EQ 0.
    SELECT * FROM zbi_lib_alfa10
      INTO TABLE gt_hier_lib
      FOR ALL ENTRIES IN gt_hier_cat
      WHERE bi_categ EQ gt_hier_cat-bi_categ.
  ENDIF.
ENDFORM.

*//////ALV Jerárquico///////////////////////////////////////////////////////////

FORM categorias_libros .
  IF NOT go_salv_hier_cat_lib IS BOUND.
    PERFORM get_data.
    PERFORM build_salv_hier.
    PERFORM enable_salv_hier_func.
    PERFORM config_salv_hier_col.
    PERFORM enable_salv_hierseq_events.
    PERFORM create_salv_hier_top_end.
  ENDIF.
  PERFORM display_salv_hier.
ENDFORM.

FORM build_salv_hier .
  DATA: lt_binding TYPE salv_t_hierseq_binding,
        ls_binding TYPE salv_s_hierseq_binding.
  ls_binding-master = 'MANDT'.
  ls_binding-slave = 'MANDT'.
  APPEND ls_binding TO lt_binding.
  ls_binding-master = 'BI_CATEG'.
  ls_binding-slave = 'BI_CATEG'.
  APPEND ls_binding TO lt_binding.
  TRY.
      cl_salv_hierseq_table=>factory(
        EXPORTING
          t_binding_level1_level2 = lt_binding
        IMPORTING
          r_hierseq               = go_salv_hier_cat_lib
        CHANGING
          t_table_level1          = gt_hier_cat
          t_table_level2          = gt_hier_lib
      ).
    CATCH cx_salv_data_error.
    CATCH cx_salv_not_found.

  ENDTRY.
ENDFORM.

FORM display_salv_hier .
  go_salv_hier_cat_lib->display( ).
ENDFORM.

FORM enable_salv_hier_func .
*  DATA: lo_func_hier TYPE REF TO cl_salv_functions_list.
*  lo_func_hier = go_salv_hier_cat_lib->get_functions( ).
*  lo_func_hier->set_all( ).
  go_salv_hier_cat_lib->get_functions( )->set_all( ).
ENDFORM.

FORM config_salv_hier_col .
  DATA: lo_hier_columns TYPE REF TO cl_salv_columns_hierseq,
        lo_hier_column  TYPE REF TO cl_salv_column_hierseq,
        lo_hier_level   TYPE REF TO cl_salv_hierseq_level.
* Header Table
  TRY.
      lo_hier_columns = go_salv_hier_cat_lib->get_columns( 1 ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'MANDT' ).
      lo_hier_column->set_technical( ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_hier_columns->set_expand_column( value = 'DESCRIPCION' ).
    CATCH cx_salv_data_error.
  ENDTRY.
  TRY.
      lo_hier_level = go_salv_hier_cat_lib->get_level( 2 ).
    CATCH cx_salv_not_found.
  ENDTRY.
  lo_hier_level->set_items_expanded( ).
*/////////Item///////////////////////////////////////////////////////////////////
  TRY.
      lo_hier_columns = go_salv_hier_cat_lib->get_columns( 2 ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'MANDT' ).
      lo_hier_column->set_technical( ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'ID_LIBRO' ).
      lo_hier_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_hier_column ?= lo_hier_columns->get_column( columnname = 'TITULO' ).
      lo_hier_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
    CATCH cx_salv_not_found.
  ENDTRY.
ENDFORM.

FORM enable_salv_hierseq_events .
  DATA: lo_hier_events TYPE REF TO cl_salv_events_hierseq.
  CREATE OBJECT go_salv_event_hierseq.
  lo_hier_events = go_salv_hier_cat_lib->get_event( ).
  SET HANDLER go_salv_event_hierseq->handle_link_click FOR lo_hier_events.
ENDFORM.

FORM create_salv_hier_top_end .
  DATA: lo_header TYPE REF TO cl_salv_form_layout_grid,
        lo_label  TYPE REF TO cl_salv_form_label,
        lo_flow   TYPE REF TO cl_salv_form_layout_flow,
        lv_text   TYPE string,
        lv_number TYPE i.

  CREATE OBJECT lo_header.

  lo_label = lo_header->create_label(
               row         = 1
               column      = 1
*               rowspan     =
*               colspan     =
*               text        =
*               tooltip     =
*               r_label_for =
             ).
  lv_text = 'Bienvenido ALFA10'.
  lo_label->set_text( value = lv_text ).

  lo_flow = lo_header->create_flow(
               row     = 2
               column  = 1
*              rowspan =
*              colspan =
             ).
  DESCRIBE TABLE gt_hier_lib LINES lv_number.
  lv_text = lv_number.
  CONCATENATE 'Nº de libros disponible ' lv_text INTO lv_text SEPARATED BY space.
  lo_flow->create_text(
*    EXPORTING
*      position =
      text     = lv_text
*      tooltip  =
*    RECEIVING
*      r_value  =
  ).
  go_salv_hier_cat_lib->set_top_of_list( value = lo_header ).

* Flow
  lo_flow = lo_header->create_flow(
               row     = 3
               column  = 1
*              rowspan =
*              colspan =
             ).
  DESCRIBE TABLE gt_hier_cat LINES lv_number.
  lv_text = lv_number.
  CONCATENATE 'Nº de categorías disponible ' lv_text INTO lv_text SEPARATED BY space.
  lo_flow->create_text(
*    EXPORTING
*      position =
      text     = lv_text
*      tooltip  =
*    RECEIVING
*      r_value  =
  ).
  go_salv_hier_cat_lib->set_end_of_list( value = lo_header ).
ENDFORM.

*//////ALV Arbol///////////////////////////////////////////////////////////

FORM categorias_libros_clientes .
  IF NOT go_salv_tree_cat_lib_cli IS BOUND.
    PERFORM instance_cust_cont USING 'C'.
    PERFORM build_salv_tree.
    PERFORM build_salv_tree_header.
    PERFORM get_salv_tree_data.
    PERFORM set_salv_tree_nodes.
    PERFORM config_salv_tree_col.
    PERFORM display_salv_tree.
  ENDIF.
ENDFORM.

FORM build_salv_tree .
  TRY.
      cl_salv_tree=>factory(
        EXPORTING
          r_container = go_custom_container
*      hide_header =
        IMPORTING
          r_salv_tree = go_salv_tree_cat_lib_cli
        CHANGING
          t_table     = gt_temp_cat_lib_cli
      ).
    CATCH cx_salv_error.
  ENDTRY.
ENDFORM.

FORM display_salv_tree .
  go_salv_tree_cat_lib_cli->display( ).
ENDFORM.

FORM build_salv_tree_header .
  DATA: lo_settings TYPE REF TO cl_salv_tree_settings.
  lo_settings = go_salv_tree_cat_lib_cli->get_tree_settings( ).
  lo_settings->set_hierarchy_header( value = 'Registros' ).
  lo_settings->set_hierarchy_tooltip( value = 'Despliegue los nodos' ).
  lo_settings->set_hierarchy_size( value = 60 ).
ENDFORM.

FORM get_salv_tree_data .
  SELECT
      cat~bi_categ
      cat~descripcion
      lib~id_libro
      lib~titulo
      lib~autor
      lib~editoral
      cln~id_cliente
      cln~nombre
      cln~apellidos
      cln~email
      FROM zbi_cat_alfa10 AS cat
      INNER JOIN zbi_lib_alfa10 AS lib ON cat~bi_categ EQ lib~bi_categ
      INNER JOIN zbi_c_l_alfa10 AS con ON con~id_libro EQ lib~id_libro
      INNER JOIN zbi_cln_alfa10 AS cln ON cln~id_cliente EQ con~id_cliente
      INTO TABLE gt_cat_lib_cli
      ORDER BY lib~bi_categ lib~id_libro.

ENDFORM.

FORM set_salv_tree_nodes .
  DATA: lo_nodes TYPE REF TO cl_salv_nodes,
        lo_node  TYPE REF TO cl_salv_node.

  DATA: lv_text      TYPE lvc_value,
        lv_key_marca TYPE salv_de_node_key,
        lv_key_desc  TYPE salv_de_node_key.

  FIELD-SYMBOLS <ls_clc_tree> TYPE zbi_cat_lib_cli_logali.

  lo_nodes = go_salv_tree_cat_lib_cli->get_nodes( ).

  LOOP AT gt_cat_lib_cli ASSIGNING <ls_clc_tree>.
    ON CHANGE OF <ls_clc_tree>-bi_categ.
      lv_text = <ls_clc_tree>-bi_categ.
      TRY.
          lo_node = lo_nodes->add_node(
                      related_node   = space
                      relationship   = if_salv_c_node_relation=>parent
*                  data_row       =
*                  collapsed_icon =
*                  expanded_icon  =
*                  row_style      =
                  text           = lv_text
*                  visible        = abap_true
                  expander       = abap_true
*                  enabled        = abap_true
                  folder         = abap_true
                    ).
        CATCH cx_salv_msg.
      ENDTRY.
      lv_key_marca = lo_node->get_key( ).
    ENDON.

    ON CHANGE OF <ls_clc_tree>-descripcion.
      lv_text = <ls_clc_tree>-descripcion.
      TRY.
          lo_node = lo_nodes->add_node(
                      related_node   = lv_key_marca
                      relationship   = if_salv_c_node_relation=>last_child
*                  data_row       =
*                  collapsed_icon =
*                  expanded_icon  =
*                  row_style      =
                  text           = lv_text
*                  visible        = abap_true
                  expander       = abap_true
*                  enabled        = abap_true
                  folder         = abap_true
                    ).
        CATCH cx_salv_msg.
      ENDTRY.
      lv_key_desc = lo_node->get_key( ).
    ENDON.
    lv_text = <ls_clc_tree>-id_cliente.
    TRY.
        lo_node = lo_nodes->add_node(
                    related_node   = lv_key_desc
                    relationship   = if_salv_c_node_relation=>last_child
*                  data_row       =
*                  collapsed_icon =
*                  expanded_icon  =
*                  row_style      =
                    text           = lv_text
*                  visible        = abap_true
*                    expander       = abap_true
*                  enabled        = abap_true
*                    folder         = abap_true
                  ).
        lo_node->set_data_row( value = <ls_clc_tree> ).
      CATCH cx_salv_msg.
    ENDTRY.
  ENDLOOP.
ENDFORM.

FORM config_salv_tree_col .
  DATA: lo_columns TYPE REF TO cl_salv_columns_tree,
        lo_column  TYPE REF TO cl_salv_column.

  lo_columns = go_salv_tree_cat_lib_cli->get_columns( ).
  lo_columns->set_optimize( abap_true ).

  TRY.
      lo_column = lo_columns->get_column( columnname = 'DESCRPCION' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_column = lo_columns->get_column( columnname = 'BI_CATEG' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_column = lo_columns->get_column( columnname = 'TITULO' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.
  ENDTRY.
  TRY.
      lo_column = lo_columns->get_column( columnname = 'ID_CLIENTE' ).
      lo_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.
  ENDTRY.
ENDFORM.

*//////ALV GUI Arbol///////////////////////////////////////////////////////////

FORM acceso_categorias_libros .
  IF NOT go_gui_tree_acc_cat_lib IS BOUND.
    PERFORM instance_cust_cont USING 'A'.
    PERFORM build_gui_tree.
    PERFORM build_gui_tree_header.
    PERFORM build_gui_tree_fieldcat.
    PERFORM set_gui_tree_first_display.
    PERFORM get_gui_tree_data.
    PERFORM set_gui_tree_drag_drop.
    PERFORM gui_tree_add_favourit.
    PERFORM set_gui_tree_nodes.
    PERFORM gui_tree_frontend_update.
    PERFORM set_gui_tree_events.
  ENDIF.
ENDFORM.

FORM build_gui_tree.
  CREATE OBJECT go_gui_tree_acc_cat_lib
    EXPORTING
*     lifetime                    =
      parent                      = go_custom_container
*     shellstyle                  =
      node_selection_mode         = cl_gui_column_tree=>node_sel_mode_single
*     hide_selection              =
      item_selection              = abap_true
*     no_toolbar                  =
      no_html_header              = abap_true
*     i_print                     =
*     i_fcat_complete             =
*     i_model_mode                =
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      illegal_node_selection_mode = 5
      failed                      = 6
      illegal_column_name         = 7
      OTHERS                      = 8.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM build_gui_tree_header .
  gs_gui_tree_header-heading = 'Registros'.
  gs_gui_tree_header-tooltip = 'Despliegue los nodos'.
  gs_gui_tree_header-width = 65.
ENDFORM.

FORM build_gui_tree_fieldcat.
  FIELD-SYMBOLS <ls_fieldcat> TYPE lvc_s_fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZBI_ACC_CAT_LIB_LOGALI'
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_BYPASSING_BUFFER     =
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_gui_tree_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  LOOP AT gt_gui_tree_fieldcat ASSIGNING <ls_fieldcat>.
    IF <ls_fieldcat>-fieldname = 'TIPO_ACCESO' OR <ls_fieldcat>-fieldname = 'DESC_ACCESO' OR <ls_fieldcat>-fieldname = 'BI_CATEG' OR
       <ls_fieldcat>-fieldname = 'ID_LIBRO' OR <ls_fieldcat>-fieldname = 'DESCRIPCION'.
      <ls_fieldcat>-no_out = abap_true.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM set_gui_tree_first_display .
  go_gui_tree_acc_cat_lib->set_table_for_first_display(
    EXPORTING
*      i_structure_name     =
*      is_variant           =
*      i_save               =
*      i_default            = 'X'
      is_hierarchy_header  = gs_gui_tree_header
*      is_exception_field   =
*      it_special_groups    =
*      it_list_commentary   =
*      i_logo               =
*      i_background_id      =
*      it_toolbar_excluding =
*      it_except_qinfo      =
    CHANGING
      it_outtab            = gt_temp_acc_cat_lib
*      it_filter            =
      it_fieldcatalog      = gt_gui_tree_fieldcat
  ).
ENDFORM.

FORM gui_tree_frontend_update .
  go_gui_tree_acc_cat_lib->frontend_update( ).
ENDFORM.

FORM get_gui_tree_data .
  CONSTANTS: lc_where_alias      TYPE string VALUE 'ACCESO~',
             lc_where_eq         TYPE c LENGTH 2 VALUE 'EQ',
             lc_where_and        TYPE c LENGTH 3 VALUE 'AND',
             lc_where_apostrophe TYPE c LENGTH 1 VALUE '''',
             lc_where_tipo_acc   TYPE string VALUE 'TIPO_ACCESO'.
  DATA: lt_where_clause TYPE TABLE OF string,
        lv_where_clause TYPE string,
        lv_string_value TYPE string.
  DATA: lt_values TYPE TABLE OF dd07v,
        ls_values TYPE dd07v.
  FIELD-SYMBOLS <ls_acc_cat_lib> TYPE zbi_acc_cat_lib_logali.
  IF NOT zbi_cln_alfa10-tipo_acceso IS INITIAL.
    lv_string_value = zbi_cln_alfa10-tipo_acceso.
    CONCATENATE lc_where_alias
                 lc_where_tipo_acc space
                 lc_where_eq space
                 lc_where_apostrophe
                 lv_string_value
                 lc_where_apostrophe
                 INTO lv_where_clause
                 RESPECTING BLANKS.
    APPEND lv_where_clause TO lt_where_clause.
  ENDIF.
  IF NOT lt_where_clause IS INITIAL.
    SELECT a~tipo_acceso
           c~bi_categ
           c~descripcion
           l~id_libro
           l~titulo
           l~autor
           l~editoral
           FROM zbi_a_c_alfa10 AS a
           INNER JOIN zbi_cat_alfa10 AS c ON a~bi_categ EQ c~bi_categ
           INNER JOIN zbi_lib_alfa10 AS l ON c~bi_categ EQ l~bi_categ
           INTO CORRESPONDING FIELDS OF TABLE gt_acc_cat_lib
           WHERE  (lt_where_clause)
           ORDER BY a~tipo_acceso c~bi_categ.
  ELSE.
    SELECT a~tipo_acceso
           c~bi_categ
           c~descripcion
           l~id_libro
           l~titulo
           l~autor
           l~editoral
           FROM zbi_a_c_alfa10 AS a
           INNER JOIN zbi_cat_alfa10 AS c ON a~bi_categ EQ c~bi_categ
           INNER JOIN zbi_lib_alfa10 AS l ON c~bi_categ EQ l~bi_categ
           INTO CORRESPONDING FIELDS OF TABLE gt_acc_cat_lib
           ORDER BY a~tipo_acceso c~bi_categ.
  ENDIF.

  CALL FUNCTION 'DD_DOMVALUES_GET'
    EXPORTING
      domname        = 'ZBI_TIPO_ACCESO'
      text           = abap_true
*     LANGU          = ' '
*     BYPASS_BUFFER  = ' '
* IMPORTING
*     RC             =
    TABLES
      dd07v_tab      = lt_values
    EXCEPTIONS
      wrong_textflag = 1
      OTHERS         = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE 'Domain error' TYPE 'E'.
  ENDIF.
  LOOP AT gt_acc_cat_lib ASSIGNING <ls_acc_cat_lib>.
    READ TABLE lt_values INTO ls_values
    WITH KEY domvalue_l = <ls_acc_cat_lib>-tipo_acceso.
    IF sy-subrc EQ 0.
      <ls_acc_cat_lib>-desc_acceso = ls_values-ddtext.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM set_gui_tree_nodes .
  FIELD-SYMBOLS <ls_acc_cat_lib> TYPE zbi_acc_cat_lib_logali.
  DATA: ls_node_layout  TYPE lvc_s_layn,
        lv_node_text    TYPE lvc_value,
        lv_new_node_acc TYPE lvc_nkey,
        lv_new_node_cat TYPE lvc_nkey.
  LOOP AT gt_acc_cat_lib ASSIGNING <ls_acc_cat_lib>.
    ON CHANGE OF <ls_acc_cat_lib>-tipo_acceso.
      ls_node_layout-isfolder = abap_true.
      ls_node_layout-expander = abap_true.
      lv_node_text = <ls_acc_cat_lib>-desc_acceso.

      go_gui_tree_acc_cat_lib->add_node(
       EXPORTING
        i_relat_node_key = space
        i_relationship = cl_gui_column_tree=>relat_last_child
        is_node_layout = ls_node_layout
        i_node_text = lv_node_text
        IMPORTING
          e_new_node_key = lv_new_node_acc
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found = 2
        OTHERS = 3
        ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 .
      ENDIF.
    ENDON.

    CLEAR ls_node_layout.
    ON CHANGE OF <ls_acc_cat_lib>-bi_categ.
      ls_node_layout-isfolder = abap_true.
      ls_node_layout-expander = abap_true.
      lv_node_text = <ls_acc_cat_lib>-descripcion.
      go_gui_tree_acc_cat_lib->add_node(
      EXPORTING
       i_relat_node_key = lv_new_node_acc " NodeAlready in Tree Hierarchy
       i_relationship = cl_gui_column_tree=>relat_last_child " How to InsertNode
*       is_outtab_line = " Attributes ofInserted Node
       is_node_layout = ls_node_layout " NodeLayout
*       it_item_layout = " Item Layout
        i_node_text = lv_node_text "Hierarchy Node Text
      IMPORTING
        e_new_node_key = lv_new_node_cat " Keyof New Node Key
      EXCEPTIONS
        relat_node_not_found = 1
        node_not_found = 2
        OTHERS = 3
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 .
      ENDIF.
    ENDON.
    CLEAR ls_node_layout.
    ls_node_layout-dragdropid = gv_fav_line_id.
    lv_node_text = <ls_acc_cat_lib>-id_libro.
    go_gui_tree_acc_cat_lib->add_node(
    EXPORTING
    i_relat_node_key = lv_new_node_cat
    i_relationship = cl_gui_column_tree=>relat_last_child
    is_outtab_line = <ls_acc_cat_lib>
    is_node_layout = ls_node_layout
    i_node_text = lv_node_text
    EXCEPTIONS
    relat_node_not_found = 1
    node_not_found = 2
    OTHERS = 3
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    CLEAR ls_node_layout.
  ENDLOOP.
ENDFORM.

FORM gui_tree_add_favourit .
  DATA: ls_node_layout TYPE lvc_s_layn,
        lv_node_text   TYPE lvc_value.

  ls_node_layout-dragdropid = gv_fav_folder_id.
  ls_node_layout-isfolder = abap_true.
  ls_node_layout-n_image = icon_system_favorites.

  go_gui_tree_acc_cat_lib->add_node(
    EXPORTING
      i_relat_node_key     = space
      i_relationship       = cl_gui_column_tree=>relat_last_child
*      is_outtab_line       =
      is_node_layout       = ls_node_layout
*      it_item_layout       =
      i_node_text          = lv_node_text
    IMPORTING
      e_new_node_key       = gv_fav_key
    EXCEPTIONS
      relat_node_not_found = 1
      node_not_found       = 2
      OTHERS               = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM set_gui_tree_drag_drop .
  CREATE OBJECT: go_line_behaviour, go_fav_behaviour.

  go_line_behaviour->add(
    EXPORTING
      flavor          = 'favorit'
      dragsrc         = abap_true
      droptarget      = space
      effect          = cl_dragdrop=>copy
*      effect_in_ctrl  = usedefaulteffect
    EXCEPTIONS
      already_defined = 1
      obj_invalid     = 2
      OTHERS          = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  go_fav_behaviour->add(
    EXPORTING
      flavor          = 'favorit'
      dragsrc         = space
      droptarget      = abap_true
      effect          = cl_dragdrop=>copy
*      effect_in_ctrl  = usedefaulteffect
    EXCEPTIONS
      already_defined = 1
      obj_invalid     = 2
      OTHERS          = 3
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  go_line_behaviour->get_handle(
    IMPORTING
      handle      = gv_fav_line_id
    EXCEPTIONS
      obj_invalid = 1
      OTHERS      = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  go_fav_behaviour->get_handle(
    IMPORTING
      handle      = gv_fav_folder_id
    EXCEPTIONS
      obj_invalid = 1
      OTHERS      = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.

FORM set_gui_tree_events .
  CREATE OBJECT go_gui_tree_events.
  SET HANDLER go_gui_tree_events->handle_on_drag FOR go_gui_tree_acc_cat_lib.
  SET HANDLER go_gui_tree_events->handle_on_drop FOR go_gui_tree_acc_cat_lib.
ENDFORM.
