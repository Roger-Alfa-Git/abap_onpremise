*&---------------------------------------------------------------------*
*& Report ZPOO_04_METODOS_INS_EST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_04_metodos_ins_est_alfa10.

CLASS tarifa DEFINITION.

  PUBLIC SECTION.

    METHODS set_tar_corp IMPORTING tarifa TYPE wertv8 EXPORTING total TYPE wertv8 EXCEPTIONS no_aplica.

    CLASS-METHODS set_tar_base IMPORTING tarifa TYPE wertv8.

  PRIVATE SECTION.

    DATA: tar_corp TYPE wertv8.

    CLASS-DATA tar_base TYPE wertv8.
ENDCLASS.

CLASS tarifa IMPLEMENTATION.

  METHOD set_tar_corp.

    tar_corp = tarifa.

    IF sy-datum+4(2) EQ 06.
      total = ( tar_base + tar_corp ) * 8 / 10.
    ELSE.
      total = tar_base + tar_corp.
      RAISE no_aplica.
    ENDIF.

  ENDMETHOD.

  METHOD set_tar_base.

    tar_base = tarifa.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_tarifa TYPE REF TO tarifa,
        gv_total  TYPE wertv8.

  "  CALL METHOD tarifa=>set_tar_base
  "   EXPORTING
  "    tarifa = '10.20'.

  tarifa=>set_tar_base( tarifa = '10.20' ).


  CREATE OBJECT gr_tarifa.

  "  CALL METHOD gr_tarifa->set_tar_corp
  "   EXPORTING
  "    tarifa    = '20.40'
  " IMPORTING
  "  total     = gv_total
  "EXCEPTIONS
  " no_aplica = 1
  "OTHERS    = 2.

  gr_tarifa->set_tar_corp( EXPORTING  tarifa    = '20.40'
                           IMPORTING  total     = gv_total
                           EXCEPTIONS no_aplica = 1
                                      OTHERS    = 2 ).

  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    MESSAGE 'No aplica la tarifa especial' TYPE 'I'.
  ENDIF.


  WRITE : / 'Total tarifa aplicada', gv_total.
