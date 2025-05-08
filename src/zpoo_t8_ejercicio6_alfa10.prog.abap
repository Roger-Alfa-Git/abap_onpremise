*&---------------------------------------------------------------------*
*& Report ZPOO_T8_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t8_ejercicio6_alfa10.

START-OF-SELECTION.

  DATA: gv_v1     TYPE i,
        gv_v2     TYPE i,
        gv_result TYPE i.

  gv_v1 = 50.

  gv_v2 = 0.

  TRY.
      gv_result = gv_v1 / gv_v2.
      WRITE: / gv_result.
      CATCH cx_root.
        WRITE: / 'Error no es divicible del 0'.
        gv_v2 = 2.
        RETRY.
    ENDTRY.
