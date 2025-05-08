*&---------------------------------------------------------------------*
*& Report Z_CALL_ME_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_call_me_alfa10.

DATA gt_materiales TYPE mara.

*Cambie la fecha del 2012 al 2023 por la cuestion de que no existen archivos con la fecha de 2012
CALL FUNCTION 'Z_MF_MATERIALES_ALFA10'
  EXPORTING
    date_from = '20121101'
    date_to   = '20121231'
* TABLES
*   TI_MATERIALES       =
  EXCEPTIONS
    ex_sin_materiales = 1.
IF sy-subrc ne 0.

    WRITE 'No exsisten los materiales de esa fecha'.
  ENDIF.
