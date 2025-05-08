*&---------------------------------------------------------------------*
*& Include          Z_PRACTICA_ALV_ALFA10_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form get_data
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM sflight
    INTO TABLE gt_flights
    WHERE carrid IN so_carri AND connid IN so_conni
       AND fldate IN so_fldat AND price IN so_price
       AND currency IN so_curre AND planetype IN so_plant.
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
        lv_tabname TYPE DDOBJNAME VALUE 'SFLIGHT',
        ls_field   TYPE dfies.

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
      ls_fieldcat-fieldname = ls_field-fieldname.
      ls_fieldcat-seltext_l = ls_field-fieldname.
      APPEND ls_fieldcat TO gt_fieldcat.
      CLEAR ls_fieldcat.
    ENDLOOP.
  ENDIF.

*  DATA ls_fieldcat TYPE slis_fieldcat_alv.
*
*  ls_fieldcat-fieldname = 'MANDT'.
*  ls_fieldcat-seltext_l = 'MANDT'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'CARRID'.
*  ls_fieldcat-seltext_l = 'Código de aerolínea'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'CONNID'.
*  ls_fieldcat-seltext_l = 'Número de conexión de vuelo'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'FLDATE'.
*  ls_fieldcat-seltext_l = 'Fecha de vuelo'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'PRICE'.
*  ls_fieldcat-seltext_l = 'Pasaje aéreo'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'CURRENCY'.
*  ls_fieldcat-seltext_l = 'Moneda local de la aerolínea'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'PLANETYPE'.
*  ls_fieldcat-seltext_l = 'Tipo de aeronave'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSMAX'.
*  ls_fieldcat-seltext_l = 'Capacidad máxima en clase económica'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSOCC'.
*  ls_fieldcat-seltext_l = 'Asientos ocupados en clase económica'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'PAYMENTSUM'.
*  ls_fieldcat-seltext_l = 'Total de reservas actuales'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSMAX_B'.
*  ls_fieldcat-seltext_l = 'Capacidad máxima en clase ejecutiva'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSOCC_B'.
*  ls_fieldcat-seltext_l = 'Asientos ocupados en clase business'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSMAX_F'.
*  ls_fieldcat-seltext_l = 'Capacidad máxima en primera clase'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'SEATSOCC_F'.
*  ls_fieldcat-seltext_l = 'Asientos ocupados en primera clase'.
*  APPEND ls_fieldcat TO gt_fieldcat.
*
*  CLEAR ls_fieldcat.
*  ls_fieldcat-fieldname = 'NUM_PUERTA'.
*  ls_fieldcat-seltext_l = 'Numero de Puerta'.
*  APPEND ls_fieldcat TO gt_fieldcat.
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
*&---------------------------------------------------------------------*
*& Form display_alv_list_basic
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv_list.
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
      t_outtab           = gt_flights
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
    WRITE: / 'Exception error'.
  ENDIF.
ENDFORM.
