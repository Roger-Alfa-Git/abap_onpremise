*&---------------------------------------------------------------------*
*& Report Z_LLAMADA_MF_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_llamada_mf_alfa10.

DATA gt_facturas TYPE TABLE OF vbrk.

CALL FUNCTION 'Z_LISTAR_FACTURAS_ALFA10'
  EXPORTING
    iv_fecha        = '20210128'
    iv_listar       = abap_true
  TABLES
    tabla_facturas  = gt_facturas
  EXCEPTIONS
    ex_sin_facturas = 1.

IF sy-subrc NE 0.
  WRITE / 'NO'.
ENDIF.

IF gt_facturas IS NOT INITIAL.
  WRITE / 'SI'.
ENDIF.

WRITE / 'Fin'.
