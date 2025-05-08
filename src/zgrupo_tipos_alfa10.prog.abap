*&---------------------------------------------------------------------*
*& Report ZGRUPO_TIPOS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zgrupo_tipos_alfa10.

*TYPE-POOL zfa10.

DATA: gs_tipo_cntr TYPE zfa10_tipo_cntr.

gs_tipo_cntr-tipo_cntr = 'I'.
gs_tipo_cntr-horas_sem = '40'.
gs_tipo_cntr-dias_vac  = '30'.

WRITE: / 'Tarifa tecnico ',zfa10_tarifa_tecnico.
