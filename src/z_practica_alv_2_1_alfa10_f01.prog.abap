*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_2_1_ALFA10_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form init_2000
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM init_2000 .
  CHECK code IS NOT INITIAL.
  CASE code.
    WHEN 'B_TAB'.
      IF gv_first_time EQ abap_true.
        PERFORM free_container.
      ELSEIF gv_first_time EQ abap_false.
        gv_first_time = abap_true.
      ELSE.
      ENDIF.
      PERFORM tabla2.
    WHEN 'BTN_L'.
      PERFORM free_container.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form free_container
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
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
  CLEAR: gt_tabla2, gt_fieldcat.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form tabla2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM tabla2 .
  IF go_custom_container IS NOT BOUND.
    PERFORM get_data.
    PERFORM instance_cust_cont.
*    PERFORM build_layout.
    PERFORM build_field_cat.
    PERFORM instance_alv_tabla2.
*    PERFORM create_alv_grid_header.
*    PERFORM set_alv_grid_handlers.
*    PERFORM register_events.
    PERFORM create_alv_grid_variants.
*    PERFORM exclude_alv_grid_toolbar.
    PERFORM display_alv_tabla2.
  ELSE.
    PERFORM refresh_alv_tabla2.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form instance_cust_cont
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM instance_cust_cont .
  DATA: lo_gui_splitter_cont TYPE REF TO cl_gui_splitter_container.
  CREATE OBJECT go_custom_container
    EXPORTING
*     parent                      = " Parent container
      container_name              = 'ALV_SPACE' " Name of the Screen CustCtrl Name to Link Container To
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

  CREATE OBJECT lo_gui_splitter_cont
    EXPORTING
*     link_dynnr        =
*     link_repid        =
*     shellstyle        =
*     left              =
*     top               =
*     width             =
*     height            =
*     metric            = cntl_metric_dynpro
*     align             = 15
      parent            = go_custom_container
      rows              = 2
      columns           = 1
*     no_autodef_progid_dynnr =
*     name              =
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
      height            = 1
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

ENDFORM.
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  DATA: countryfr TYPE landx50,
        countryto TYPE landx50,
        airfrname TYPE name,
        airtoname TYPE name.

  DATA: lt_conditions   TYPE TABLE OF string,
        lv_where_clause TYPE string.

  IF gv_carri IS NOT INITIAL.
    APPEND |s1~carrid eq '{ gv_carri }'| TO lt_conditions.
  ENDIF.

  IF gv_conni IS NOT INITIAL AND gv_conni NE '0000'.
    APPEND |s2~connid eq '{ gv_conni }'| TO lt_conditions.
  ENDIF.

  IF gv_confr IS NOT INITIAL.
    APPEND |s2~countryfr eq '{ gv_confr }'| TO lt_conditions.
  ENDIF.

  IF gv_conto IS NOT INITIAL.
    APPEND |s2~countryto eq '{ gv_conto }'| TO lt_conditions.
  ENDIF.

  CONCATENATE LINES OF lt_conditions INTO lv_where_clause SEPARATED BY ' AND '.
  SELECT DISTINCT s1~carrid,
              s1~carrname,
              s1~currcode,
              s2~connid,
              s2~countryfr,
              s2~cityfrom,
              s2~airpfrom AS airfrname,
              s2~countryto,
              s2~cityto ,
              s2~airpto AS airtoname,
              s2~distance,
              s2~distid,
              s3~fldate,
              s3~price,
              s3~currency,
              s3~seatsmax,
              s3~seatsocc,
              s3~seatsmax_b,
              s3~seatsocc_b,
              s3~seatsmax_f,
              s3~seatsocc_f,
              s3~paymentsum
  FROM scarr AS s1
  INNER JOIN spfli    AS s2 ON s1~carrid    EQ s2~carrid
  INNER JOIN sflight  AS s3 ON s2~connid    EQ s3~connid
  INTO CORRESPONDING FIELDS OF TABLE @gt_tabla
  WHERE (lv_where_clause)
  ORDER BY s3~fldate DESCENDING.

  IF sy-subrc EQ 0.
    LOOP AT gt_tabla INTO gs_tabla.
      SELECT SINGLE landx50 FROM t005t AS t1
        INTO countryfr
        WHERE t1~land1 EQ gs_tabla-countryfr.
      IF sy-subrc EQ 0.
        gs_tabla-countryfr = countryfr.
      ENDIF.

      SELECT SINGLE landx50 FROM t005t AS t1
         INTO countryto
         WHERE t1~land1 EQ gs_tabla-countryto.
      IF sy-subrc EQ 0.
        gs_tabla-countryto = countryto.
      ENDIF.

      SELECT SINGLE name FROM sairport AS t1
         INTO airfrname
         WHERE t1~id EQ gs_tabla-airfrname.
      IF sy-subrc EQ 0.
        gs_tabla-airfrname = airfrname.
      ENDIF.

      SELECT SINGLE name FROM sairport AS t1
         INTO airtoname
         WHERE t1~id EQ gs_tabla-airtoname.
      IF sy-subrc EQ 0.
        gs_tabla-airtoname = airtoname.
      ENDIF.

      MOVE-CORRESPONDING gs_tabla TO gs_tabla2.
      gs_tabla2-seat_t_a = gs_tabla-seatsmax - gs_tabla-seatsocc.
      gs_tabla2-seat_t_b = gs_tabla-seatsmax_b - gs_tabla-seatsocc_b.
      gs_tabla2-seat_t_f = gs_tabla-seatsmax_f - gs_tabla-seatsocc_f.
      gs_tabla2-seat_t = gs_tabla2-seat_t_a + gs_tabla2-seat_t_b + gs_tabla2-seat_t_f.

      IF gs_tabla2-seat_t LT 10.
        gs_tabla2-icon = '@08@'.
      ELSEIF gs_tabla2-seat_t GE 10 AND gs_tabla2-seat_t LE 20.
        gs_tabla2-icon = '@09@'.
      ELSEIF gs_tabla2-seat_t GT 20.
        gs_tabla2-icon = '@0A@'.
      ENDIF.

      APPEND gs_tabla2 TO gt_tabla2.

      gv_table_start = abap_true.
    ENDLOOP.

  ELSE.
    MESSAGE 'No existe ningun registro' TYPE 'I'.
    gv_table_start = abap_false.
    RETURN.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form build_layout
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM build_layout .
*  FIELD-SYMBOLS <ls_tabla2> TYPE zdataflighttablealfa10.
*  DATA: ls_style TYPE lvc_s_styl.
*  gs_layout-zebra = abap_true.
*  gs_layout-edit = abap_true.
*  gs_layout-stylefname = 'FIELD_STYLE'.
*  gs_layout-cwidth_opt = abap_true.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form build_field_cat
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM build_field_cat .
  FIELD-SYMBOLS: <ls_fieldcat> TYPE lvc_s_fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     I_BUFFER_ACTIVE        =
      i_structure_name       = 'ZDATAFLIGHTTABLEALFA10'
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

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form instance_alv_tabla2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM instance_alv_tabla2 .
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
*&---------------------------------------------------------------------*
*& Form create_alv_grid_header
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_alv_grid_header .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form set_alv_grid_handlers
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
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
*&---------------------------------------------------------------------*
*& Form register_events
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM register_events .
*  DATA: lt_f4 TYPE lvc_t_f4,
*        ls_f4 TYPE lvc_s_f4.
*  ls_f4-fieldname = 'CARRID'.
*  ls_f4-register = abap_true.
*  APPEND ls_f4 TO lt_f4.
*
*  go_alv_grid->register_f4_for_fields( it_f4 = lt_f4 ).
*
*  CALL METHOD go_alv_grid->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter
*    EXCEPTIONS
*      error      = 1
*      OTHERS     = 2.
*  IF sy-subrc <> 0.
*    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form create_alv_grid_variants
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM create_alv_grid_variants .
  gs_variante-report = sy-repid.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form exclude_alv_grid_toolbar
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM exclude_alv_grid_toolbar .
  DATA:ls_exclude TYPE ui_func.
  ls_exclude = cl_gui_alv_grid=>mc_fc_info.
  APPEND ls_exclude TO gt_toolbar_excluding.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_tabla2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_tabla2 .
  DATA: lt_sort TYPE lvc_t_sort,
        ls_sort TYPE lvc_s_sort.
  DATA: lt_filter TYPE lvc_t_filt,
        ls_filter TYPE lvc_s_filt,
        lv_filtro TYPE string VALUE 'S'.

  go_alv_grid->set_table_for_first_display(
    EXPORTING
*      i_buffer_active               =
*      i_bypassing_buffer            =
*      i_consistency_check           =
*      i_structure_name              =
*      is_variant                    = gs_variante
*      i_save                        = 'U'
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
      it_outtab                     = gt_tabla2
      it_fieldcatalog               = gt_fieldcat
*      it_sort                       = lt_sort
*      it_filter                     = lt_filter
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
*&---------------------------------------------------------------------*
*& Form refresh_alv_tabla2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM refresh_alv_tabla2 .
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
