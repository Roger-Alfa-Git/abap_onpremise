*&---------------------------------------------------------------------*
*& Report ZTIPO_TABLA_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztipo_tabla_alfa10.

CLASS lcl_empresa DEFINITION.
  PUBLIC SECTION.
    METHODS: alta_empleados IMPORTING tabla_empleados TYPE ztt_datos_empl_alfa10,
      listar_empleados.

  PRIVATE SECTION.
    DATA: tabla_empleados TYPE ztt_datos_empl_alfa10.

ENDCLASS.

CLASS lcl_empresa IMPLEMENTATION.
  METHOD alta_empleados.
    me->tabla_empleados = tabla_empleados.
  ENDMETHOD.

  METHOD listar_empleados.
    DATA: LS_empleados TYPE zestr_datos_empl_alfa10.

    LOOP AT me->tabla_empleados INTO ls_empleados.
      WRITE: / ls_empleados-nombre.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.
  DATA: gt_empleados TYPE ztt_datos_empl_alfa10,
        gs_empleados TYPE zestr_datos_empl_alfa10,
        gr_empresa   TYPE REF TO lcl_empresa.

  gs_empleados-nombre = 'Alejandro'.
  APPEND gs_empleados TO gt_empleados.

  gs_empleados-nombre = 'Lorena'.
  APPEND gs_empleados TO gt_empleados.

  CREATE OBJECT gr_empresa.

  gr_empresa->alta_empleados( tabla_empleados = gt_empleados ).

  gr_empresa->listar_empleados( ).
