*&---------------------------------------------------------------------*
*& Report ZESTR_ANIDADAS_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zestr_anidadas_alfa10.


DATA: gs_datos_empleados TYPE zestr_datos_empl_alfa10,
      gs_unidad_org      TYPE zestr_und_org_alfa10.

gs_datos_empleados-nombre = 'Alfa'.
gs_datos_empleados-apellido1 = '10'.
gs_datos_empleados-direccion-num_dir = '0147'.

gs_unidad_org-res_ventas-nombre = 'Alfa'.
gs_unidad_org-res_ventas-apellido1 = '03'.
gs_unidad_org-res_ventas-direccion-num_dir = '0369'.

gs_unidad_org-empleado = gs_datos_empleados.

WRITE: / gs_unidad_org-empleado-nombre.
