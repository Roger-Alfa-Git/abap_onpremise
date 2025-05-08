*&---------------------------------------------------------------------*
*& Report ZPOO_T6_EJERCICIO9_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t6_ejercicio9_alfa10.

CLASS cl_dep_administrativo DEFINITION.
  PUBLIC SECTION.
    EVENTS: nomina_pagada.
    METHODS: avisar_empleado IMPORTING tipo TYPE string.
ENDCLASS.

CLASS cl_dep_administrativo IMPLEMENTATION.
  METHOD avisar_empleado.

    WRITE: / 'Empleado: ',tipo.
    RAISE EVENT nomina_pagada.
  ENDMETHOD.
ENDCLASS.

CLASS cl_empleado DEFINITION.
  PUBLIC SECTION.
    METHODS: on_nomina_pagada FOR EVENT nomina_pagada OF cl_dep_administrativo,
      constructor.
ENDCLASS.

CLASS cl_empleado IMPLEMENTATION.
  METHOD on_nomina_pagada.
    WRITE: 'Activo'.
  ENDMETHOD.
  METHOD constructor.
    SET HANDLER me->on_nomina_pagada FOR ALL INSTANCES.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_gerente   TYPE REF TO cl_dep_administrativo,
        gr_contador  TYPE REF TO cl_dep_administrativo,
        gr_asistente TYPE REF TO cl_dep_administrativo,
        gr_empleado  TYPE REF TO cl_empleado.

  CREATE OBJECT: gr_gerente,
                 gr_contador,
                 gr_asistente,
                 gr_empleado.

  gr_gerente->avisar_empleado( tipo = 'Gerente' ).

  gr_contador->avisar_empleado( tipo = 'Contador' ).

  gr_asistente->avisar_empleado( tipo = 'Asistente' ).

  SKIP.

  gr_empleado->on_nomina_pagada( ).
