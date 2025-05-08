*&---------------------------------------------------------------------*
*& Report ZPOO_T4_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t4_ejercicio4_alfa10.

INTERFACE if_comunidad.
  DATA: comunidad TYPE string.
  METHODS set_comunidad IMPORTING comunidad TYPE string.
ENDINTERFACE.

INTERFACE if_ciudad.
  DATA: ciudad TYPE string.
  INTERFACES if_comunidad.
  METHODS set_ciudad IMPORTING ciudad TYPE string.
ENDINTERFACE.

CLASS edificio DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ciudad.
ENDCLASS.

CLASS edificio IMPLEMENTATION.
  METHOD if_comunidad~set_comunidad.
    me->if_comunidad~comunidad = comunidad.
  ENDMETHOD.

  METHOD if_ciudad~set_ciudad.
    me->if_ciudad~ciudad = ciudad.
  ENDMETHOD.
ENDCLASS.
