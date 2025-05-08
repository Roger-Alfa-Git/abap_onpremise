*&---------------------------------------------------------------------*
*& Report ZTABLA_BD_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztabla_bd_alfa10.

DATA: gs_empleados TYPE zemple_alfa10.

gs_empleados-num_dir = 1.
gs_empleados-nombre = 'Lorena'.
gs_empleados-apellido1 = 'Garcia'.
gs_empleados-apellido2 = 'Suarez'.
gs_empleados-cat_prof = '07'.
gs_empleados-status = 'A'.

INSERT zemple_alfa10 FROM gs_empleados.

IF sy-subrc EQ 0.
  WRITE: / 'Registro insertado correctamente'.
ELSE.
  WRITE: / 'Registro no insertado'.
ENDIF.
