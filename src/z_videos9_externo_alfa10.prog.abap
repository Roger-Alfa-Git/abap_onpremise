*&---------------------------------------------------------------------*
*& Report Z_VIDEOS9_EXTERNO_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_videos9_externo_alfa10.

DATA: gt_empleados TYPE STANDARD TABLE OF zemp_alfa10,
      pv_flag      TYPE c.

*PERFORM obteber_datos IN PROGRAM z_videos9_alfa10.

PERFORM obtener_datos(z_videos9_alfa10) TABLES gt_empleados.

PERFORM visualizar_empleados
IN PROGRAM z_videos9_alfa10
TABLES gt_empleados
  CHANGING pv_flag.
