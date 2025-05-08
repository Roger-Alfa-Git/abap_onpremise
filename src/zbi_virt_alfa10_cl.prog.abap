*&---------------------------------------------------------------------*
*& Include          ZBI_VIRT_ALFA10_CL
*&---------------------------------------------------------------------*
CLASS lcl_event_alv_grid DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING e_row
                e_column
                es_row_no.

    METHODS: handle_data_changed FOR EVENT data_changed
      OF cl_gui_alv_grid
      IMPORTING er_data_changed
                e_onf4
                e_onf4_before
                e_onf4_after
                e_ucomm
                sender.

    METHODS: handle_data_changed_finished FOR EVENT data_changed_finished
      OF cl_gui_alv_grid
      IMPORTING e_modified
                et_good_cells.

    METHODS: handle_user_command FOR EVENT user_command
      OF cl_gui_alv_grid
      IMPORTING e_ucomm.

    METHODS: handle_toolbar FOR EVENT toolbar
      OF cl_gui_alv_grid
      IMPORTING e_interactive
                e_object.

    METHODS: handle_cnf4 FOR EVENT onf4
      OF cl_gui_alv_grid
      IMPORTING e_fieldname
                e_fieldvalue
                es_row_no
                er_event_data
                et_bad_cells
                e_display.

    METHODS: handle_hotspot_click FOR EVENT hotspot_click
      OF cl_gui_alv_grid
      IMPORTING e_column_id
                e_row_id
                es_row_no.
ENDCLASS.

CLASS lcl_event_alv_grid IMPLEMENTATION.
  METHOD handle_double_click.
    DATA: ls_libros_papel TYPE gty_libros_papel,
          lt_tipo_ingreso TYPE TABLE OF dd07v,
          ls_tipo_ingreso TYPE dd07v,
          lv_tipo_acceso  TYPE zbi_tipo_acceso.
    CASE e_column.
      WHEN 'BI_CATEG'.
        CALL FUNCTION 'DD_DOMVALUES_GET'
          EXPORTING
            domname        = 'ZBI_TIPO_ACCESO_ALFA10'
            text           = abap_true
*           LANGU          = ' '
*           BYPASS_BUFFER  = ' '
*           IMPORTING
*           RC             =
          TABLES
            dd07v_tab      = lt_tipo_ingreso
          EXCEPTIONS
            wrong_textflag = 1
            OTHERS         = 2.
        IF sy-subrc <> 0.
* Implement suitable error handling here
        ENDIF.
        READ TABLE gt_libros_papel INTO ls_libros_papel INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          SELECT SINGLE tipo_acceso
           FROM zbi_a_c_alfa10
           INTO lv_tipo_acceso
           WHERE bi_categ EQ ls_libros_papel-bi_categ.
          IF sy-subrc EQ 0.
            READ TABLE lt_tipo_ingreso INTO ls_tipo_ingreso
            WITH KEY domvalue_l = lv_tipo_acceso.
            IF sy-subrc EQ 0.
              MESSAGE i000(zbi_msg_alfa10) WITH ls_tipo_ingreso-ddtext.
            ENDIF.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_data_changed_finished.
    FIELD-SYMBOLS <ls_libros_papel> TYPE gty_libros_papel.
    DATA: ls_good_cells TYPE lvc_s_modi.
    CHECK e_modified EQ abap_true.
    LOOP AT et_good_cells INTO ls_good_cells.
      READ TABLE gt_libros_papel ASSIGNING <ls_libros_papel> INDEX ls_good_cells-row_id.
      IF sy-subrc EQ 0.
        <ls_libros_papel>-bbdd = abap_true.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_data_changed.
    DATA: ls_data_changed TYPE lvc_s_modi,
          lv_categ        TYPE char1.
    LOOP AT er_data_changed->mt_good_cells INTO ls_data_changed.
      CASE ls_data_changed-fieldname.
        WHEN 'BI_CATEG'.
          er_data_changed->get_cell_value(
            EXPORTING
              i_row_id    = ls_data_changed-row_id
*              i_tabix     =
              i_fieldname = ls_data_changed-fieldname
            IMPORTING
              e_value     = lv_categ ).
          SELECT SINGLE bi_categ FROM zbi_cat_alfa10
          INTO lv_categ
          WHERE bi_categ EQ lv_categ.
          IF sy-subrc NE 0.
            er_data_changed->add_protocol_entry(
                          EXPORTING
                            i_msgid     = 'ZBI_MSG_ALFA10'
                            i_msgty     = 'E'
                            i_msgno     = '000'
                            i_msgv1     = TEXT-m01
                            i_msgv2     = lv_categ
                            i_msgv3     = TEXT-m02
*              i_msgv4     =
                            i_fieldname = ls_data_changed-fieldname
                            i_row_id    = ls_data_changed-row_id
*              i_tabix     =
                        ).
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_user_command.
    DATA: lt_bbdd_libros_papel TYPE TABLE OF zbi_lib_alfa10,
          ls_bbdd_libros_papel TYPE zbi_lib_alfa10,
          ls_libros_papel      TYPE gty_libros_papel.
    CASE e_ucomm.
      WHEN 'A_SAVE'.
        LOOP AT gt_libros_papel INTO ls_libros_papel WHERE bbdd EQ abap_true.
          MOVE-CORRESPONDING ls_libros_papel TO ls_bbdd_libros_papel.
          APPEND ls_bbdd_libros_papel TO lt_bbdd_libros_papel.
        ENDLOOP.
        IF sy-subrc EQ 0.
          MODIFY zbi_lib_alfa10 FROM TABLE lt_bbdd_libros_papel.
          IF sy-subrc EQ 0.
            MESSAGE s001(zbi_msg_alfa10).
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.
    ls_toolbar-function = 'A_SAVE'.
    ls_toolbar-quickinfo = 'SAVE'.
    ls_toolbar-icon = '@F_SAVE@'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_cnf4.
    TYPES: BEGIN OF lty_categoria,
             bi_categ    TYPE	zbi_categorias,
             descripcion TYPE text60,
           END OF lty_categoria.
    DATA: lt_categ       TYPE TABLE OF lty_categoria,
          ls_categ       TYPE lty_categoria,
          lt_return_tab  TYPE TABLE OF ddshretval,
          ls_return_tab  TYPE ddshretval,
          ls_modify_data TYPE lvc_s_modi.
    FIELD-SYMBOLS <lt_modify_data> TYPE lvc_t_modi.
    CASE e_fieldname.
      WHEN 'BI_CATEG'.
        SELECT bi_categ descripcion FROM zbi_cat_alfa10
          INTO CORRESPONDING FIELDS OF TABLE lt_categ
          WHERE bi_categ NE space AND descripcion NE space.
        IF sy-subrc EQ 0.
          CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
            EXPORTING
*             DDIC_STRUCTURE  = ' '
              retfield        = 'BI_CATEG'
*             PVALKEY         = ' '
              dynpprog        = sy-repid
              dynpnr          = sy-dynnr
              dynprofield     = 'BI_CATEG'
*             STEPL           = 0
*             WINDOW_TITLE    =
*             VALUE           = ' '
              value_org       = 'S'
*             MULTIPLE_CHOICE = ' '
*             DISPLAY         = ' '
*             CALLBACK_PROGRAM       = ' '
*             CALLBACK_FORM   = ' '
*             CALLBACK_METHOD =
*             MARK_TAB        =
*             IMPORTING
*             USER_RESET      =
            TABLES
              value_tab       = lt_categ
*             FIELD_TAB       =
              return_tab      = lt_return_tab
*             DYNPFLD_MAPPING =
            EXCEPTIONS
              parameter_error = 1
              no_values_found = 2
              OTHERS          = 3.
          IF sy-subrc <> 0.
* Implement suitable error handling here
          ELSE.
            READ TABLE lt_return_tab INTO ls_return_tab INDEX 1.
            IF sy-subrc EQ 0.
              ls_modify_data-row_id = es_row_no-row_id.
              ls_modify_data-fieldname = e_fieldname.
              ls_modify_data-value = ls_return_tab-fieldval.

              ASSIGN er_event_data->m_data->* TO <lt_modify_data>.

              APPEND ls_modify_data TO <lt_modify_data>.

            ENDIF.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
    er_event_data->m_event_handled = abap_true.
  ENDMETHOD.

  METHOD handle_hotspot_click.
    DATA: lt_clientes     TYPE STANDARD TABLE OF zbi_cln_alfa10,
          ls_libros_papel TYPE gty_libros_papel.
    CASE e_column_id.
      WHEN 'ID_LIBRO'.
        READ TABLE gt_libros_papel INTO ls_libros_papel INDEX es_row_no-row_id.
        IF sy-subrc EQ 0.
          SELECT cl~nombre cl~apellidos cl~email FROM zbi_cln_alfa10 AS cl
            JOIN zbi_c_l_alfa10 AS co ON cl~id_cliente EQ co~id_cliente
            JOIN zbi_lib_alfa10 AS li ON co~id_libro EQ li~id_libro
            INTO TABLE lt_clientes
            WHERE li~id_libro EQ ls_libros_papel-id_libro.
          IF sy-subrc EQ 0.
            CALL FUNCTION 'POPUP_WITH_TABLE'
              EXPORTING
                endpos_col   = 160
                endpos_row   = 15
                startpos_col = 20
                startpos_row = 10
                titletext    = TEXT-po1
*               IMPORTING
*               CHOICE       =
              TABLES
                valuetab     = lt_clientes
              EXCEPTIONS
                break_off    = 1
                OTHERS       = 2.
            IF sy-subrc <> 0.
* Implement suitable error handling here
            ENDIF.
          ELSE.
            MESSAGE s002(zbi_msg_alfa10) DISPLAY LIKE 'E'.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.


*/////Listado ALV//////////////////////////////////////////////////////////////////

CLASS lcl_event_salv_list DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_added_function FOR EVENT added_function
      OF cl_salv_events_table
      IMPORTING e_salv_function.
ENDCLASS.

CLASS lcl_event_salv_list IMPLEMENTATION.
  METHOD handle_added_function.
    DATA: lv_count TYPE i.
    DESCRIBE TABLE gt_libros_ele LINES lv_count.
    CASE e_salv_function.
      WHEN 'TOTAL'.
        MESSAGE i003(zbi_msg_alfa10) WITH lv_count.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

*//////ALV Jerárquico///////////////////////////////////////////////////////////

CLASS lcl_event_salv_hierseq DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_link_click FOR EVENT link_click OF cl_salv_events_hierseq IMPORTING level column row.
ENDCLASS.

CLASS lcl_event_salv_hierseq IMPLEMENTATION.
  METHOD handle_link_click.
    TYPES: BEGIN OF lty_clientes,
             nombre    TYPE psovn,
             apellidos TYPE psonm,
             email     TYPE zbi_email,
           END OF lty_clientes.

    DATA: lt_clientes TYPE STANDARD TABLE OF lty_clientes,
          ls_libro    TYPE  zbi_lib_alfa10.
    READ TABLE gt_hier_lib INTO ls_libro INDEX row.
    IF sy-subrc EQ 0.
      SELECT c~nombre
       c~apellidos
       c~email
       FROM zbi_cln_alfa10 AS c
       INNER JOIN zbi_c_l_alfa10 AS cl
       ON c~id_cliente EQ cl~id_cliente
       INTO TABLE lt_clientes
       WHERE cl~id_libro EQ ls_libro-id_libro.
      IF sy-subrc EQ 0.
        CALL FUNCTION 'POPUP_WITH_TABLE'
          EXPORTING
            endpos_col   = 160
            endpos_row   = 15
            startpos_col = 20
            startpos_row = 10
            titletext    = TEXT-l01
*           IMPORTING
*           CHOICE       =
          TABLES
            valuetab     = lt_clientes
          EXCEPTIONS
            break_off    = 1
            OTHERS       = 2.
        IF sy-subrc <> 0.
*           Implement suitable error handling here
        ENDIF.
      ELSE.
        MESSAGE i002(zbi_msg_alfa10).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_drag_drop_object DEFINITION.
  PUBLIC SECTION.
    DATA: gs_data      TYPE zbi_acc_cat_lib_logali,
          gv_node_text TYPE lvc_value.
ENDCLASS.

CLASS lcl_gui_tree_events DEFINITION.
  PUBLIC SECTION.
    METHODS: handle_on_drag FOR EVENT on_drag OF cl_gui_alv_tree IMPORTING sender drag_drop_object fieldname node_key,
      handle_on_drop FOR EVENT on_drop OF cl_gui_alv_tree IMPORTING sender drag_drop_object node_key.
ENDCLASS.

CLASS lcl_gui_tree_events IMPLEMENTATION.
  METHOD handle_on_drag.
    DATA: lo_drag_droop TYPE REF TO lcl_drag_drop_object.
    CREATE OBJECT lo_drag_droop.
    sender->get_outtab_line(
      EXPORTING
        i_node_key     = node_key
      IMPORTING
        e_outtab_line  = lo_drag_droop->gs_data
        e_node_text    = lo_drag_droop->gv_node_text
*        et_item_layout =
*        es_node_layout =
      EXCEPTIONS
        node_not_found = 1
        OTHERS         = 2
    ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
    drag_drop_object->object = lo_drag_droop.
  ENDMETHOD.

  METHOD handle_on_drop.
    DATA: lo_drag_drop   TYPE REF TO lcl_drag_drop_object,
          ls_layout_node TYPE lvc_s_layn.

    ls_layout_node-n_image = icon_system_favorites.

    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      lo_drag_drop ?= drag_drop_object->object.

      go_gui_tree_acc_cat_lib->add_node(
        EXPORTING
          i_relat_node_key     = gv_fav_key
          i_relationship       = cl_gui_column_tree=>relat_last_child
          is_outtab_line       = lo_drag_drop->gs_data
          is_node_layout       = ls_layout_node
*          it_item_layout       =
          i_node_text          = lo_drag_drop->gv_node_text
*        IMPORTING
*          e_new_node_key       =
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3
      ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
      sender->expand_node( i_node_key = gv_fav_key ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
      sender->frontend_update( ).
    ENDCATCH.
    IF sy-subrc EQ 0.
      drag_drop_object->abort( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
