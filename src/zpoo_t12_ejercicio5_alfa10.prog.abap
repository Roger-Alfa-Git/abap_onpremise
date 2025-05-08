*&---------------------------------------------------------------------*
*& Report ZPOO_T12_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t12_ejercicio5_alfa10.

DATA: gv_provedores TYPE lifnr.

SELECT-OPTIONS so_lifnr FOR gv_provedores.

CLASS lcl_modelo DEFINITION.
  PUBLIC SECTION.
    METHODS: set_modelo,
      get_modelo RETURNING VALUE(proveedores) TYPE bbp_lfa1_t.
  PRIVATE SECTION.
    DATA t_proveedores TYPE bbp_lfa1_t.
ENDCLASS.

CLASS lcl_modelo IMPLEMENTATION.
  METHOD set_modelo.
    SELECT * FROM lfa1
      INTO TABLE t_proveedores
      WHERE lifnr IN so_lifnr.
  ENDMETHOD.
  METHOD get_modelo.
    proveedores = t_proveedores.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_vista DEFINITION.
  PUBLIC SECTION.
    METHODS imprimir_prov IMPORTING proveedores TYPE bbp_lfa1_t.
ENDCLASS.

CLASS lcl_vista IMPLEMENTATION.
  METHOD imprimir_prov.
    DATA lt_datos  TYPE TABLE OF lfa1.
    lt_datos = proveedores.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
*       I_INTERFACE_CHECK                 = ' '
*       I_BYPASSING_BUFFER                = ' '
*       I_BUFFER_ACTIVE  = ' '
*       I_CALLBACK_PROGRAM                = ' '
*       I_CALLBACK_PF_STATUS_SET          = ' '
*       I_CALLBACK_USER_COMMAND           = ' '
*       I_CALLBACK_TOP_OF_PAGE            = ' '
*       I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*       I_CALLBACK_HTML_END_OF_LIST       = ' '
        i_structure_name = 'LFA1'
*       I_BACKGROUND_ID  = ' '
*       I_GRID_TITLE     =
*       I_GRID_SETTINGS  =
*       IS_LAYOUT        =
*       it_fieldcat      = lt_fieldcat
*       IT_EXCLUDING     =
*       IT_SPECIAL_GROUPS                 =
*       IT_SORT          =
*       IT_FILTER        =
*       IS_SEL_HIDE      =
*       I_DEFAULT        = 'X'
*       I_SAVE           = ' '
*       IS_VARIANT       =
*       IT_EVENTS        =
*       IT_EVENT_EXIT    =
*       IS_PRINT         =
*       IS_REPREP_ID     =
*       I_SCREEN_START_COLUMN             = 0
*       I_SCREEN_START_LINE               = 0
*       I_SCREEN_END_COLUMN               = 0
*       I_SCREEN_END_LINE                 = 0
*       I_HTML_HEIGHT_TOP                 = 0
*       I_HTML_HEIGHT_END                 = 0
*       IT_ALV_GRAPHICS  =
*       IT_HYPERLINK     =
*       IT_ADD_FIELDCAT  =
*       IT_EXCEPT_QINFO  =
*       IR_SALV_FULLSCREEN_ADAPTER        =
*    IMPORTING
*       E_EXIT_CAUSED_BY_CALLER           =
*       ES_EXIT_CAUSED_BY_USER            =
      TABLES
        t_outtab         = lt_datos
      EXCEPTIONS
        program_error    = 1
        OTHERS           = 2.
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_controlador DEFINITION.
  PUBLIC SECTION.
    METHODS: set_modelo IMPORTING modelo TYPE REF TO lcl_modelo,
      get_modelo EXPORTING modelo TYPE REF TO lcl_modelo,
      set_vista IMPORTING vista TYPE REF TO lcl_vista,
      get_vista EXPORTING vista TYPE REF TO lcl_vista.
  PRIVATE SECTION.
    DATA: modelo TYPE REF TO lcl_modelo,
          vista  TYPE REF TO lcl_vista.
ENDCLASS.

CLASS lcl_controlador IMPLEMENTATION.
  METHOD set_modelo.
    me->modelo = modelo.
  ENDMETHOD.
  METHOD get_modelo.
    modelo = me->modelo.
  ENDMETHOD.
  METHOD set_vista.
    me->vista = vista.
    me->vista->imprimir_prov( proveedores = me->modelo->get_modelo( ) ).
  ENDMETHOD.
  METHOD get_vista.
    vista = me->vista.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA: gr_vista       TYPE REF TO lcl_vista,
        gr_modelo      TYPE REF TO lcl_modelo,
        gr_controlador TYPE REF TO lcl_controlador.
  CREATE OBJECT: gr_vista,
                 gr_modelo,
                 gr_controlador.
  gr_modelo->set_modelo( ).
  gr_controlador->set_modelo( modelo = gr_modelo ).
  gr_controlador->set_vista( vista = gr_vista ).
