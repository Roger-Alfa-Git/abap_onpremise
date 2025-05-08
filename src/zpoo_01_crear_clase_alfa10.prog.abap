*&---------------------------------------------------------------------*
*& Report ZPOO_01_CREAR_CLASE_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_01_crear_clase_alfa10.


CLASS empleado DEFINITION .

  PUBLIC SECTION.

    DATA: nombre TYPE string.

    METHODS: establecer_nombre IMPORTING i_nombre TYPE string,
      obtener_nombre    EXPORTING e_nombre TYPE string.

ENDCLASS.


CLASS empleado IMPLEMENTATION.

  METHOD establecer_nombre.
    nombre = i_nombre.
  ENDMETHOD.

  METHOD obtener_nombre.
    e_nombre = nombre.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_empleado  TYPE REF TO empleado,
        gr_empleado2 TYPE REF TO empleado.

  CREATE OBJECT: gr_empleado,
  gr_empleado2.
