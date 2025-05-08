*&---------------------------------------------------------------------*
*& Report Z_RAISE_EXCEP_ALFA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_raise_excep_alfa10.

CLASS lcl_check_user DEFINITION.
  PUBLIC SECTION.
    METHODS: check_user IMPORTING user TYPE syuname
                        RAISING   zcx_autorizacion_alfa10,
      check_recurso IMPORTING user TYPE syuname
                    RAISING   zcx_permisos_alfa10.

ENDCLASS.

CLASS lcl_check_user IMPLEMENTATION.
  METHOD check_user.
    DATA: lex_autorizacion TYPE REF TO zcx_autorizacion_alfa10.

    CREATE OBJECT lex_autorizacion.

    IF user = 'ALFA03'.
      RAISE EXCEPTION TYPE zcx_autorizacion_alfa10
        EXPORTING
          textid = zcx_autorizacion_alfa10=>usuario_inactivo.
*          previous =
      .
    ENDIF.
  ENDMETHOD.
  METHOD check_recurso.
    DATA: lv_msgv1 TYPE msgv1,
          lv_msgv2 TYPE msgv2,
          lv_msgv3 TYPE msgv3,
          lv_msgv4 TYPE msgv4.

    lv_msgv1 = sy-uname.
    lv_msgv2 = sy-repid.
    lv_msgv3 = sy-datum.
    lv_msgv4 = sy-uzeit.

    " El usuario & No tiene permiso al recurso & solicitado en la fecha & y h &

    IF user = 'ALFA03'.
      RAISE EXCEPTION TYPE zcx_permisos_alfa10
        EXPORTING
*         textid =
*         previous =
          msgv1 = lv_msgv1
          msgv2 = lv_msgv2
          msgv3 = lv_msgv3
          msgv4 = lv_msgv4.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gcx_autorizacion TYPE REF TO zcx_autorizacion_alfa10,
        gcx_permisos     TYPE REF TO zcx_permisos_alfa10,
        gcl_check_user   TYPE REF TO lcl_check_user,
        gv_resultado     TYPE i,
        gv_n1            TYPE i,
        gv_n2            TYPE i,
        gcx_exepcion     TYPE REF TO cx_root.

  CREATE OBJECT: gcl_check_user.
  TRY.
      gcl_check_user->check_user( user = sy-uname ).
    CATCH zcx_autorizacion_alfa10 INTO gcx_autorizacion. " Clase de Exepcion para las autorizaciones
      WRITE: / gcx_autorizacion->get_text( ).
      WRITE / 'Se ha emitido la exepcion'.
  ENDTRY.

  TRY.
      gcl_check_user->check_recurso( user = sy-uname ).
    CATCH zcx_permisos_alfa10 INTO gcx_permisos. " Clase de exepcion con clase de mensajes
      WRITE: / gcx_permisos->get_text( ).
  ENDTRY.

  SKIP 3.
  WRITE / '-----------------------Con un solo bloque TRY-----------------------------'.
  SKIP.

  gv_n1 = 10.
  gv_n2 = 0.

  TRY.
*      gcl_check_user->check_user( user = sy-uname ).
*      gcl_check_user->check_recurso( user = sy-uname ).
      gv_resultado = gv_n1 / gv_n2.

      WRITE: / 'Resultado es: ',gv_resultado.
    CATCH zcx_autorizacion_alfa10 INTO gcx_autorizacion. " Clase de Exepcion para las autorizaciones
      WRITE: / gcx_autorizacion->get_text( ).
    CATCH zcx_permisos_alfa10 INTO gcx_permisos. " Clase de exepcion con clase de mensajes
      WRITE: / gcx_permisos->get_text( ).
    CATCH cx_root INTO gcx_exepcion.
      WRITE: / 'Capturando y tratando por la clase padre'.
      WRITE: / gcx_exepcion->get_text( ).
      gv_n2 = 2.
      RETRY.
  ENDTRY.
