*&---------------------------------------------------------------------*
*& Report ZCLAVE_SECUNDARIA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zclave_secundaria_alfa10.

TYPES: BEGIN OF ty_empleados,
         nombre    TYPE znombre_alfa10,
         apellido1 TYPE zapellido1_alfa10,
         apellido2 TYPE zapellido2_alfa10,
         cat_prof  TYPE zcateg_prof_alfa10,
         status    TYPE zstatus_alfa10,
       END OF ty_empleados.

TYPES:
tt_empleados TYPE STANDARD TABLE OF ty_empleados
WITH KEY nombre apellido1
WITH NON-UNIQUE SORTED KEY cat_status COMPONENTS cat_prof status.

DATA: gt_empleados TYPE tt_empleados,
      gs_empleados TYPE ty_empleados.

CONSTANTS: gc_cat_prof TYPE zcateg_prof_alfa10 VALUE '05', " Programador
           gc_status   TYPE zstatus_alfa10 VALUE 'A'. " Alta

LOOP AT gt_empleados INTO gs_empleados
      WHERE nombre EQ 'Alberto'
        AND apellido1 EQ 'Ruiz'.

ENDLOOP.

LOOP AT gt_empleados INTO gs_empleados
      USING KEY cat_status
      WHERE cat_prof EQ gc_cat_prof
        AND status EQ gc_status.

ENDLOOP.

READ TABLE gt_empleados INTO gs_empleados
WITH KEY cat_status COMPONENTS cat_prof = gc_cat_prof
                              status = gc_status.

DATA: gt_empl TYPE ztt_datos_empl_alfa10,
      gs_empl TYPE zestr_datos_empl_alfa10.

LOOP AT gt_empl INTO gs_empl
  USING KEY cat_status
      WHERE cat_prof EQ gc_cat_prof
        AND status EQ gc_status.

ENDLOOP.
