*&---------------------------------------------------------------------*
*& Report ZPOO_POLIM_CL_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_polim_cl_alfa10.

CLASS avion DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS tipo_avion ABSTRACT.
ENDCLASS.

CLASS avion_carga DEFINITION INHERITING FROM avion.
  PUBLIC SECTION.
    METHODS: tipo_avion REDEFINITION.
ENDCLASS.

CLASS avion_carga IMPLEMENTATION.
  METHOD tipo_avion.
    WRITE: / 'Avion de carga'.
  ENDMETHOD.
ENDCLASS.

CLASS avion_pasajeros DEFINITION INHERITING FROM avion.
  PUBLIC SECTION.
    METHODS: tipo_avion REDEFINITION.
ENDCLASS.

CLASS avion_pasajeros IMPLEMENTATION.
  METHOD tipo_avion.
    WRITE: / 'Avion de pasajeros'.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gt_avion           TYPE STANDARD TABLE OF REF TO avion,
        gr_avion           TYPE REF TO avion,
        gr_avion_carga     TYPE REF TO avion_carga,
        gr_avion_pasajeros TYPE REF TO avion_pasajeros.

  CREATE OBJECT: gr_avion_carga, gr_avion_pasajeros.

  APPEND: gr_avion_carga TO gt_avion.

  APPEND gr_avion_pasajeros TO gt_avion.

  LOOP AT gt_avion INTO gr_avion.
    gr_avion->tipo_avion( ).
  ENDLOOP.
