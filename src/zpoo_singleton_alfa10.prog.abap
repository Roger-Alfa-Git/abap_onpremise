*&---------------------------------------------------------------------*
*& Report ZPOO_SINGLETON_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_singleton_alfa10.

DATA: gr_singleton  TYPE REF TO zcl_singleton_alfa10,
      gr_singleton2 TYPE REF TO zcl_singleton_alfa10.

zcl_singleton_alfa10=>obtener_instancia(
  IMPORTING
    instancia = gr_singleton                 " Singlenton
).

WAIT UP TO 2 SECONDS.

zcl_singleton_alfa10=>obtener_instancia(
  IMPORTING
    instancia = gr_singleton2                 " Singlenton
).

WRITE: / gr_singleton->hora_creacion ENVIRONMENT TIME FORMAT,
       / gr_singleton2->hora_creacion ENVIRONMENT TIME FORMAT.
