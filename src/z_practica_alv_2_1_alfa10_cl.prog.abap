*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_2_1_ALFA10_CL
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
    DATA: ls_tabla2       TYPE zdataflighttablealfa10,
          lt_tipo_ingreso TYPE TABLE OF dd07v,
          ls_tipo_ingreso TYPE dd07v,
          lv_tipo_acceso  TYPE zbi_tipo_acceso.
    CASE e_column.
      WHEN 'BI_CATEG'.
*        CALL FUNCTION 'DD_DOMVALUES_GET'
*          EXPORTING
*            domname        = 'ZBI_TIPO_ACCESO_ALFA10'
*            text           = abap_true
**           LANGU          = ' '
**           BYPASS_BUFFER  = ' '
**           IMPORTING
**           RC             =
*          TABLES
*            dd07v_tab      = lt_tipo_ingreso
*          EXCEPTIONS
*            wrong_textflag = 1
*            OTHERS         = 2.
*        IF sy-subrc <> 0.
** Implement suitable error handling here
*        ENDIF.
*        READ TABLE gt_tabla2 INTO ls_tabla2 INDEX es_row_no-row_id.
*        IF sy-subrc EQ 0.
*          SELECT SINGLE tipo_acceso
*           FROM zbi_a_c_alfa10
*           INTO lv_tipo_acceso
*           WHERE bi_categ EQ ls_libros_papel-bi_categ.
*          IF sy-subrc EQ 0.
*            READ TABLE lt_tipo_ingreso INTO ls_tipo_ingreso
*            WITH KEY domvalue_l = lv_tipo_acceso.
*            IF sy-subrc EQ 0.
*              MESSAGE i000(zbi_msg_alfa10) WITH ls_tipo_ingreso-ddtext.
*            ENDIF.
*          ENDIF.
*        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_data_changed_finished.
    FIELD-SYMBOLS <ls_tabla2> TYPE zdataflighttablealfa10.
    DATA: ls_good_cells TYPE lvc_s_modi.
    CHECK e_modified EQ abap_true.
    LOOP AT et_good_cells INTO ls_good_cells.
      READ TABLE gt_tabla2 ASSIGNING <ls_tabla2> INDEX ls_good_cells-row_id.
      IF sy-subrc EQ 0.
*        <ls_tabla2>-bbdd = abap_true.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_data_changed.
    DATA: ls_data_changed TYPE lvc_s_modi,
          lv_categ        TYPE char1.
    LOOP AT er_data_changed->mt_good_cells INTO ls_data_changed.
      CASE ls_data_changed-fieldname.
        WHEN 'BI_CATEG'.
*          er_data_changed->get_cell_value(
*            EXPORTING
*              i_row_id    = ls_data_changed-row_id
**              i_tabix     =
*              i_fieldname = ls_data_changed-fieldname
*            IMPORTING
*              e_value     = lv_categ ).
*          SELECT SINGLE bi_categ FROM zbi_cat_alfa10
*          INTO lv_categ
*          WHERE bi_categ EQ lv_categ.
*          IF sy-subrc NE 0.
*            er_data_changed->add_protocol_entry(
*                          EXPORTING
*                            i_msgid     = 'ZBI_MSG_ALFA10'
*                            i_msgty     = 'E'
*                            i_msgno     = '000'
*                            i_msgv1     = TEXT-m01
*                            i_msgv2     = lv_categ
*                            i_msgv3     = TEXT-m02
**              i_msgv4     =
*                            i_fieldname = ls_data_changed-fieldname
*                            i_row_id    = ls_data_changed-row_id
**              i_tabix     =
*                        ).
*          ENDIF.
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_user_command.
    DATA: lt_bbdd_tabla2 TYPE TABLE OF zdataflighttablealfa10,
          ls_bbdd_tabla2 TYPE zdataflighttablealfa10,
          ls_tabla2      TYPE zdataflighttablealfa10.
    CASE e_ucomm.
      WHEN 'A_SAVE'.
*        LOOP AT gt_tabla2 INTO ls_tabla2.
*          MOVE-CORRESPONDING ls_tabla2 TO ls_bbdd_tabla2.
*          APPEND ls_bbdd_tabla2 TO lt_bbdd_tabla2.
*        ENDLOOP.
*        IF sy-subrc EQ 0.
*          MODIFY zdataflighttablealfa10 FROM TABLE lt_bbdd_tabla2.
*          IF sy-subrc EQ 0.
*            MESSAGE 'INSERTADO CORECTAMENTE' TYPE 'I'.
*          ENDIF.
*        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_toolbar.
*    DATA: ls_toolbar TYPE stb_button.
*    ls_toolbar-function = 'A_SAVE'.
*    ls_toolbar-quickinfo = 'SAVE'.
*    ls_toolbar-icon = '@F_SAVE@'.
*    APPEND ls_toolbar TO e_object->mt_toolbar.
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
*        SELECT bi_categ descripcion FROM zbi_cat_alfa10
*          INTO CORRESPONDING FIELDS OF TABLE lt_categ
*          WHERE bi_categ NE space AND descripcion NE space.
*        IF sy-subrc EQ 0.
*          CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*            EXPORTING
**             DDIC_STRUCTURE  = ' '
*              retfield        = 'BI_CATEG'
**             PVALKEY         = ' '
*              dynpprog        = sy-repid
*              dynpnr          = sy-dynnr
*              dynprofield     = 'BI_CATEG'
**             STEPL           = 0
**             WINDOW_TITLE    =
**             VALUE           = ' '
*              value_org       = 'S'
**             MULTIPLE_CHOICE = ' '
**             DISPLAY         = ' '
**             CALLBACK_PROGRAM       = ' '
**             CALLBACK_FORM   = ' '
**             CALLBACK_METHOD =
**             MARK_TAB        =
**             IMPORTING
**             USER_RESET      =
*            TABLES
*              value_tab       = lt_categ
**             FIELD_TAB       =
*              return_tab      = lt_return_tab
**             DYNPFLD_MAPPING =
*            EXCEPTIONS
*              parameter_error = 1
*              no_values_found = 2
*              OTHERS          = 3.
*          IF sy-subrc <> 0.
** Implement suitable error handling here
*          ELSE.
*            READ TABLE lt_return_tab INTO ls_return_tab INDEX 1.
*            IF sy-subrc EQ 0.
*              ls_modify_data-row_id = es_row_no-row_id.
*              ls_modify_data-fieldname = e_fieldname.
*              ls_modify_data-value = ls_return_tab-fieldval.
*
*              ASSIGN er_event_data->m_data->* TO <lt_modify_data>.
*
*              APPEND ls_modify_data TO <lt_modify_data>.
*
*            ENDIF.
*          ENDIF.
*        ENDIF.
      WHEN OTHERS.
    ENDCASE.
    er_event_data->m_event_handled = abap_true.
  ENDMETHOD.

  METHOD handle_hotspot_click.
    DATA: lt_clientes TYPE STANDARD TABLE OF zdataflighttablealfa10,
          ls_tabla    TYPE zdataflighttablealfa10.
    CASE e_column_id.
      WHEN 'ID_LIBRO'.
*        READ TABLE gt_libros_papel INTO ls_libros_papel INDEX es_row_no-row_id.
*        IF sy-subrc EQ 0.
*          SELECT cl~nombre cl~apellidos cl~email FROM zbi_cln_alfa10 AS cl
*            JOIN zbi_c_l_alfa10 AS co ON cl~id_cliente EQ co~id_cliente
*            JOIN zbi_lib_alfa10 AS li ON co~id_libro EQ li~id_libro
*            INTO TABLE lt_clientes
*            WHERE li~id_libro EQ ls_libros_papel-id_libro.
*          IF sy-subrc EQ 0.
*            CALL FUNCTION 'POPUP_WITH_TABLE'
*              EXPORTING
*                endpos_col   = 160
*                endpos_row   = 15
*                startpos_col = 20
*                startpos_row = 10
*                titletext    = TEXT-po1
**               IMPORTING
**               CHOICE       =
*              TABLES
*                valuetab     = lt_clientes
*              EXCEPTIONS
*                break_off    = 1
*                OTHERS       = 2.
*            IF sy-subrc <> 0.
** Implement suitable error handling here
*            ENDIF.
*          ELSE.
*            MESSAGE s002(zbi_msg_alfa10) DISPLAY LIKE 'E'.
*          ENDIF.
*        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
