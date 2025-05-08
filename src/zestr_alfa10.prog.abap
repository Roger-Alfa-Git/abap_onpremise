*&---------------------------------------------------------------------*
*& Report ZESTR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zestr_alfa10.

TYPES: BEGIN OF empleados,
         num_dir        TYPE znum_dir_alfa10,
         pais           TYPE land1,
         poblacion      TYPE ad_city1,
         distrito       TYPE ad_city2,
         agr_reg        TYPE regiogroup,
         code_post_pobl TYPE ad_pstcd1,
       END OF empleados.

DATA: ls_empleado1 TYPE empleados.

ls_empleado1-num_dir = 1.

DATA: ls_empleados2 TYPE zestr_empleados_alfa10.

ls_empleados2-num_dir = 2.
