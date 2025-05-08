*&---------------------------------------------------------------------*
*& Report ZPOO_T6_EJERCICIO8_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t6_ejercicio8_alfa10.

CLASS cl_operadora DEFINITION.
  PUBLIC SECTION.
    CLASS-EVENTS nueva_llamada EXPORTING VALUE(telefono_cliente) TYPE string.
    CLASS-METHODS: asignar_llamada.
ENDCLASS.

CLASS cl_operadora IMPLEMENTATION.
  METHOD asignar_llamada.
    RAISE EVENT nueva_llamada EXPORTING telefono_cliente = '2331133623'.
  ENDMETHOD.
ENDCLASS.

CLASS cl_servicio_clientes DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: on_nueva_llamada FOR EVENT nueva_llamada OF cl_operadora IMPORTING telefono_cliente.
ENDCLASS.

CLASS cl_servicio_clientes IMPLEMENTATION.
  METHOD on_nueva_llamada.
    WRITE: / 'Telefono: ',telefono_cliente.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.

  SET HANDLER cl_servicio_clientes=>on_nueva_llamada.

  cl_operadora=>asignar_llamada( ).
