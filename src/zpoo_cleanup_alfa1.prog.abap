*&---------------------------------------------------------------------*
*& Report ZPOO_CLEANUP_ALFA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_cleanup_alfa1.

PARAMETERS: pa_n1 TYPE i,
            pa_n2 TYPE i.

START-OF-SELECTION.
  DATA:gv_resultado TYPE i,
       gcx_exepcion TYPE REF TO cx_root.

  TRY.
      TRY.
          gv_resultado = pa_n1 + pa_n2.
          gv_resultado = pa_n1 /  pa_n2.
          gv_resultado = pa_n1 - pa_n2.
        CATCH zcx_permisos_alfa10.
          WRITE: 'No tiene permisos al recursos solicitudos'.
        CATCH zcx_autorizacion_alfa10.
          WRITE: / 'No tiene autorizacion'.
        CLEANUP INTO gcx_exepcion.
          "WRITE: / 'Estructura de control CLEANUP'.
          "WRITE: / 'Resultado = ', gv_resultado.
          WRITE: / gcx_exepcion->get_text( ).
      ENDTRY.
    CATCH cx_sy_zerodivide INTO gcx_exepcion.
      WRITE: / gcx_exepcion->get_text( ).
  ENDTRY.
