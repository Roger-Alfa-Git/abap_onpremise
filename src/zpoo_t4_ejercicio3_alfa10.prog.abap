*&---------------------------------------------------------------------*
*& Report ZPOO_T4_EJERCICIO3_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t4_ejercicio3_alfa10.

INTERFACE if_alta.
  METHODS alta_propuesta.
ENDINTERFACE.

INTERFACE if_modificacion.
  METHODS modificacion_propuesta.
ENDINTERFACE.

CLASS propuesta DEFINITION.
  PUBLIC SECTION.
    INTERFACES: if_alta,if_modificacion.
ENDCLASS.

CLASS propuesta IMPLEMENTATION.
  METHOD if_alta~alta_propuesta.

  ENDMETHOD.

  METHOD if_modificacion~modificacion_propuesta.

  ENDMETHOD.
ENDCLASS.
