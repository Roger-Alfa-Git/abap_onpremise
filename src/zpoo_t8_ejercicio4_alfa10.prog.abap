*&---------------------------------------------------------------------*
*& Report ZPOO_T8_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t8_ejercicio4_alfa10.

CLASS lcl_check_user DEFINITION.
  PUBLIC SECTION.
    METHODS: acceso IMPORTING usuario TYPE syuname RAISING zcx_acceso_alfa10.

ENDCLASS.

CLASS lcl_check_user IMPLEMENTATION.
  METHOD acceso.
    DATA: lex_acceso TYPE REF TO zcx_acceso_alfa10.
    CREATE OBJECT lex_acceso.

    IF usuario EQ 'ALFA03'.
      RAISE EXCEPTION TYPE zcx_acceso_alfa10
        EXPORTING
          textid = zcx_acceso_alfa10=>zcx_acceso_alfa10
*         previous =
*         msjv1  =
        .
    ENDIF.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.
  DATA: go_check_user TYPE REF TO lcl_check_user,
        gcx_acceso    TYPE REF TO zcx_acceso_alfa10.

  CREATE OBJECT go_check_user.
  TRY.
      go_check_user->acceso( usuario = sy-uname ).
    CATCH zcx_acceso_alfa10 INTO gcx_acceso. " Clase para las practicas del tema 8 bloque 2
      WRITE: / gcx_acceso->get_text( ).
  ENDTRY.
