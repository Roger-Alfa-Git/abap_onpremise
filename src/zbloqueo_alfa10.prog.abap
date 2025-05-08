*&---------------------------------------------------------------------*
*& Report ZBLOQUEO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbloqueo_alfa10.

DATA: gs_facturas TYPE zfact_alfa10.

CALL FUNCTION 'ENQUEUE_EZ_FACT_ALFA10'
*  EXPORTING
*    mode_zfact_alfa10 = 'E'              " Modo de bloqueo p. tabla ZFACT_ALFA10
*    mandt             = sy-mandt         " 01. Argumento enqueue
*    factura           = '0000000001'     " 02. Argumento enqueue
*   x_factura         = space            " ¿Cumplimentar argumento 02 con valor inicial?
*   _scope            = '2'
*   _wait             = space
*   _collect          = ' '              " Por lo pronto, juntar bloqueo
  EXCEPTIONS
    foreign_lock   = 1                " Objeto ya está bloqueado
    system_failure = 2                " Error interno de servidor de cola
    OTHERS         = 3.
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

gs_facturas-factura = '0000000001'.
gs_facturas-cls_fact = 'BDR1'.
gs_facturas-tp_fact = 'A'.
gs_facturas-tp_doc = 'A'.
gs_facturas-ejercicio = '0001'.
gs_facturas-per_cntb = '001'.

INSERT zfact_alfa10 FROM gs_facturas .

IF sy-subrc EQ 0.
  MESSAGE i001(00) WITH 'Registro insertado correctamente'.
ENDIF.

CALL FUNCTION 'DEQUEUE_EZ_FACT_ALFA10'
* EXPORTING
*   MODE_ZFACT_ALFA10       = 'E'
*   MANDT                   = SY-MANDT
*   FACTURA                 =
*   X_FACTURA               = ' '
*   _SCOPE                  = '3'
*   _SYNCHRON               = ' '
*   _COLLECT                = ' '
  .
