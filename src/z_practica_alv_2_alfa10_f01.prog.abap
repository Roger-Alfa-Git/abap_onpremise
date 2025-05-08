*&---------------------------------------------------------------------*
*& Include z_practica_alv_2_alfa10_f01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data CHANGING lv_confirm.

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
    INTO CORRESPONDING FIELDS OF TABLE @gt_table
    WHERE s1~carrid IN @so_carri AND s2~connid IN @so_conni
    AND s2~countryfr IN @so_coufr AND s2~countryto IN @so_couto
    ORDER BY s3~fldate DESCENDING.

    IF sy-subrc EQ 0.
      LOOP AT gt_table INTO gs_table.
        MOVE-CORRESPONDING gs_table TO gs_table2.
        gs_table2-seat_t_a = gs_table-seatsmax - gs_table-seatsocc.
        gs_table2-seat_t_b = gs_table-seatsmax_b - gs_table-seatsocc_b.
        gs_table2-seat_t_f = gs_table-seatsmax_f - gs_table-seatsocc_f.
        gs_table2-seat_t = gs_table2-seat_t_a + gs_table2-seat_t_b + gs_table2-seat_t_f.

        IF gs_table2-seat_t LT 10.
          gs_table2-icon = '@08@'.
        ELSEIF gs_table2-seat_t GE 10 AND gs_table2-seat_t LE 20.
          gs_table2-icon = '@09@'.
        ELSEIF gs_table2-seat_t GT 20.
          gs_table2-icon = '@0A@'.
        ENDIF.

        APPEND gs_table2 TO gt_table2.

      ENDLOOP.

      lv_confirm = abap_true.

    ELSE.
      MESSAGE 'No existe ningun registro' TYPE 'I'.

      lv_confirm = abap_false.

    ENDIF.
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
  DATA ls_fieldcat TYPE slis_fieldcat_alv.
  DATA: lt_fields  TYPE STANDARD TABLE OF dfies,
        lv_tabname TYPE ddobjname VALUE 'ZDATAFLIGHTTABLEALFA10',
        ls_field   TYPE dfies.
  FIELD-SYMBOLS: <ls_fieldcat> TYPE slis_fieldcat_alv.

  CALL FUNCTION 'DDIF_FIELDINFO_GET'
    EXPORTING
      tabname        = lv_tabname
*     FIELDNAME      = ' '
*     LANGU          = SY-LANGU
*     LFIELDNAME     = ' '
*     ALL_TYPES      = ' '
*     GROUP_NAMES    = ' '
*     UCLEN          =
*     DO_NOT_WRITE   = ' '
* IMPORTING
*     X030L_WA       =
*     DDOBJTYPE      =
*     DFIES_WA       =
*     LINES_DESCR    =
    TABLES
      dfies_tab      = lt_fields
*     FIXED_VALUES   =
    EXCEPTIONS
      not_found      = 1
      internal_error = 2
      OTHERS         = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE 'ERROR AL LEER LOS CAMPOS DE LA TABLA' TYPE 'E'.
  ELSE.
    LOOP AT lt_fields INTO ls_field.

      IF ls_field-fieldname EQ 'ICON'.
        ls_fieldcat-fieldname = ls_field-fieldname.
        ls_fieldcat-seltext_l = ls_field-fieldname.
        ls_fieldcat-icon = 'X'.
        APPEND ls_fieldcat TO gt_fieldcat.
      ELSE.
        ls_fieldcat-fieldname = ls_field-fieldname.
        ls_fieldcat-seltext_l = ls_field-fieldname.
        APPEND ls_fieldcat TO gt_fieldcat.
      ENDIF.
      CLEAR ls_fieldcat.
    ENDLOOP.
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
  gs_layout-colwidth_optimize = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form display_alv_list
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_list .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK  = ' '
*     I_BYPASSING_BUFFER = ' '
*     I_BUFFER_ACTIVE    = ' '
      i_callback_program = sy-repid
*     i_callback_pf_status_set = ' '
*     i_callback_user_command  = ' '
*     I_CALLBACK_TOP_OF_PAGE   = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME   =
*     I_BACKGROUND_ID    = ' '
*     I_GRID_TITLE       =
*     I_GRID_SETTINGS    =
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
*     IT_EXCLUDING       =
*     IT_SPECIAL_GROUPS  =
*     IT_SORT            =
*     IT_FILTER          =
*     IS_SEL_HIDE        =
*     I_DEFAULT          = 'X'
*     I_SAVE             = ' '
*     IS_VARIANT         =
*     it_events          = gt_events
*     IT_EVENT_EXIT      =
*     IS_PRINT           =
*     IS_REPREP_ID       =
*     I_SCREEN_START_COLUMN    = 0
*     I_SCREEN_START_LINE      = 0
*     I_SCREEN_END_COLUMN      = 0
*     I_SCREEN_END_LINE  = 0
*     I_HTML_HEIGHT_TOP  = 0
*     I_HTML_HEIGHT_END  = 0
*     IT_ALV_GRAPHICS    =
*     IT_HYPERLINK       =
*     IT_ADD_FIELDCAT    =
*     IT_EXCEPT_QINFO    =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER  =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER  =
*     ES_EXIT_CAUSED_BY_USER   =
    TABLES
      t_outtab           = gt_table2
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    WRITE: / 'Exception error'.
  ENDIF.
ENDFORM.
