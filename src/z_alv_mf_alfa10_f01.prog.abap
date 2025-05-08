*&---------------------------------------------------------------------*
*& Include          Z_ALV_MF_ALFA10_F01
*&---------------------------------------------------------------------*

FORM get_data.
  IF p_hier EQ abap_false.
    SELECT carrid
           connid
           price
           currency
           seatsmax
           seatsocc
           FROM sflight INTO TABLE gt_flights
           WHERE carrid IN so_carr.
  ELSE.
    SELECT * FROM spfli INTO TABLE gt_header WHERE carrid IN so_carr.

    SELECT * FROM sflight INTO TABLE gt_items WHERE carrid IN so_carr.
  ENDIF.
ENDFORM.


FORM build_field_cat.

  DATA ls_fieldcat TYPE slis_fieldcat_alv.

  IF p_list EQ abap_true OR p_grid EQ abap_true.

    ls_fieldcat-fieldname = 'CARRID'.
    ls_fieldcat-seltext_l = 'Airline Code'.
    APPEND ls_fieldcat TO gt_fieldcat.

    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = 'CONNID'.
    ls_fieldcat-seltext_l = 'Flight Connection Number'.
    APPEND ls_fieldcat TO gt_fieldcat.

    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = 'PRICE'.
    ls_fieldcat-seltext_l = 'Airfare'.
    APPEND ls_fieldcat TO gt_fieldcat.

    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = 'CURRENCY'.
    ls_fieldcat-seltext_l = 'Local currency of airline'.
    APPEND ls_fieldcat TO gt_fieldcat.

    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = 'SEATSMAX'.
    ls_fieldcat-seltext_l = 'Maximum capacity in economy class'.
    APPEND ls_fieldcat TO gt_fieldcat.

    CLEAR ls_fieldcat.
    ls_fieldcat-fieldname = 'SEATSOCC'.
    ls_fieldcat-seltext_l = 'Occupied seats in economy class'.
    APPEND ls_fieldcat TO gt_fieldcat.

  ELSE.
    PERFORM build_fieldcat_hier USING sy-repid
                                      'GT_HEADER'
                                      'SPFLI'
                             CHANGING gt_fieldcat.

    PERFORM build_fieldcat_hier USING sy-repid
                                      'GT_ITEMS'
                                      'SFLIGHT'
                             CHANGING gt_fieldcat.
  ENDIF.
ENDFORM.

FORM display_alv_list.

  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
    EXPORTING
*     i_interface_check  = space
*     i_bypassing_buffer =
*     i_buffer_active    = space
      i_callback_program = sy-repid
*     i_callback_pf_status_set = space
*     i_callback_user_command  = space
*     i_structure_name   =
*     is_layout          =
      it_fieldcat        = gt_fieldcat
*     it_excluding       =
*     it_special_groups  =
*     it_sort            =
*     it_filter          =
*     is_sel_hide        =
*     i_default          = 'X'
*     i_save             = space
*     is_variant         =
      it_events          = gt_events
*     it_event_exit      =
*     is_print           =
*     is_reprep_id       =
*     i_screen_start_column    = 0
*     i_screen_start_line      = 0
*     i_screen_end_column      = 0
*     i_screen_end_line  = 0
*     ir_salv_list_adapter     =
*     it_except_qinfo    =
*     i_suppress_empty_data    = abap_false
*  IMPORTING
*     e_exit_caused_by_caller  =
*     es_exit_caused_by_user   =
    TABLES
      t_outtab           = gt_flights
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    WRITE: / 'Exception error'.
  ENDIF.
*
*
*
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_grid
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_grid .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK        = ' '
*     I_BYPASSING_BUFFER       = ' '
*     I_BUFFER_ACTIVE          = ' '
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_PF_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE   = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME         =
*     I_BACKGROUND_ID          = ' '
*     I_GRID_TITLE             =
*     I_GRID_SETTINGS          =
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
*     IT_EXCLUDING             =
*     IT_SPECIAL_GROUPS        =
*     IT_SORT                  =
*     IT_FILTER                =
*     IS_SEL_HIDE              =
*     I_DEFAULT                = 'X'
*     I_SAVE                   = ' '
*     IS_VARIANT               =
      it_events                = gt_events
*     IT_EVENT_EXIT            =
*     IS_PRINT                 =
*     IS_REPREP_ID             =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE        = 0
*     I_HTML_HEIGHT_TOP        = 0
*     I_HTML_HEIGHT_END        = 0
*     IT_ALV_GRAPHICS          =
*     IT_HYPERLINK             =
*     IT_ADD_FIELDCAT          =
*     IT_EXCEPT_QINFO          =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER  =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab                 = gt_flights
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    WRITE: / 'Exception error'.
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

  gs_layout-zebra = abap_true.
  gs_layout-edit = abap_true.

ENDFORM.

FORM user_command USING PV_ucomm LIKE sy-ucomm
                        ps_selfield TYPE slis_selfield.
  IF pv_ucomm = '&AIR'.

    DATA: lt_flight TYPE gty_flights,
          lv_name   TYPE s_carrname.

    IF ps_selfield-tabindex IS INITIAL.
      MESSAGE 'Seleccione un Registro' TYPE 'I'.
    ELSE.
      READ TABLE gt_flights INTO lt_flight INDEX ps_selfield-tabindex.
      IF sy-subrc EQ 0.
        SELECT SINGLE carrname FROM scarr
        INTO lv_name
        WHERE carrid EQ lt_flight-carrid.
        IF sy-subrc EQ 0.
          MESSAGE i002(zmsj_alfa10) WITH lv_name DISPLAY LIKE 'S'.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
ENDFORM.

FORM set_pf_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'CUSTOM_STATUS'.
ENDFORM.

FORM add_event.
  DATA: ls_event TYPE slis_alv_event.
  ls_event-name = 'TOP_OF_PAGE'.
  ls_event-form = 'TOP_OF_PAGE'.
  APPEND ls_event TO gt_events.
ENDFORM.

FORM top_of_page.

  CASE abap_true.
    WHEN p_list OR p_hier.
      DATA: count   TYPE i.
      count = lines( gt_flights ).
      WRITE: / 'Hora de ejecucion: ', sy-uzeit ENVIRONMENT TIME FORMAT,
             / 'Numero de registros: ', count.
    WHEN p_grid.
      DATA: lt_list_commentary TYPE slis_t_listheader,
            ls_list_commentary TYPE slis_listheader.

      ls_list_commentary-typ = 'H'.
      ls_list_commentary-info = 'Vuelos disponibles'.
      APPEND ls_list_commentary TO lt_list_commentary.

      ls_list_commentary-typ = 'S'.
      CONCATENATE 'Fecha de ejecución : ' sy-datum INTO ls_list_commentary-info RESPECTING BLANKS.
      APPEND ls_list_commentary TO lt_list_commentary.

      ls_list_commentary-typ = 'A'.
      CONCATENATE 'Nombre del usuario que ejecuta la aplicación: ' sy-uname INTO ls_list_commentary-info RESPECTING BLANKS.
      APPEND ls_list_commentary TO lt_list_commentary.

      CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
        EXPORTING
          it_list_commentary = lt_list_commentary.

  ENDCASE.
ENDFORM.

FORM build_fieldcat_hier USING pv_PROGRAM_NAME  LIKE  sy-repid
                               pv_INTERNAL_TABNAME  TYPE  slis_tabname
                               pv_STRUCTURE_NAME  LIKE  dd02l-tabname
                      CHANGING ct_fieldcat  TYPE  slis_t_fieldcat_alv.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name         = pv_PROGRAM_NAME
      i_internal_tabname     = pv_INTERNAL_TABNAME
      i_structure_name       = pv_STRUCTURE_NAME
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    CHANGING
      ct_fieldcat            = ct_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE 'Error on fieldcat merge' TYPE 'E'.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_hier
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_hier.

  DATA: is_keyinfo  TYPE  slis_keyinfo_alv.

  is_keyinfo-header01 = 'MANDT'.
  is_keyinfo-header02 = 'CARRID'.
  is_keyinfo-header03 = 'CONNID'.

  is_keyinfo-item01 = 'MANDT'.
  is_keyinfo-item02 = 'CARRID'.
  is_keyinfo-item03 = 'CONNID'.

  CALL FUNCTION 'REUSE_ALV_HIERSEQ_LIST_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
      i_callback_program = sy-repid
*     I_CALLBACK_PF_STATUS_SET       = ' '
*     I_CALLBACK_USER_COMMAND        = ' '
*     IS_LAYOUT          =
      it_fieldcat        = gt_fieldcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_SCREEN_START_COLUMN          = 0
*     I_SCREEN_START_LINE            = 0
*     I_SCREEN_END_COLUMN            = 0
*     I_SCREEN_END_LINE  = 0
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
      it_events          = gt_events
*     IT_EVENT_EXIT      =
      i_tabname_header   = 'GT_HEADER'
      i_tabname_item     = 'GT_ITEMS'
*     I_STRUCTURE_NAME_HEADER        =
*     I_STRUCTURE_NAME_ITEM          =
      is_keyinfo         = is_keyinfo
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_BYPASSING_BUFFER =
*     I_BUFFER_ACTIVE    =
*     IR_SALV_HIERSEQ_ADAPTER        =
*     IT_EXCEPT_QINFO    =
*     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER        =
*     ES_EXIT_CAUSED_BY_USER         =
    TABLES
      t_outtab_header    = gt_header
      t_outtab_item      = gt_items
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE 'Error on HIERSEQ_LIST_DISPLAY' TYPE 'E'.
  ENDIF.

ENDFORM.
