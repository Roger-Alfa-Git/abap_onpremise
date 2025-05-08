*&---------------------------------------------------------------------*
*& Report ZPOO_MVC_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_mvc_alfa10.

CLASS lcl_empleado_modelo DEFINITION.
  PUBLIC SECTION.
    METHODS:constructor IMPORTING nombre TYPE string
                                  roll   TYPE string,
      set_nombre IMPORTING nombre TYPE string,
      get_nombre EXPORTING nombre TYPE string,
      set_roll IMPORTING roll TYPE string,
      get_roll EXPORTING roll TYPE string.
  PRIVATE SECTION.
    DATA: nombre TYPE string,
          roll   TYPE string.
ENDCLASS.

CLASS lcl_empleado_modelo IMPLEMENTATION.
  METHOD constructor.
    me->nombre = nombre.
    me->roll = roll.
  ENDMETHOD.
  METHOD set_nombre.
    me->nombre = nombre.
  ENDMETHOD.

  METHOD get_nombre.
    nombre = me->nombre.
  ENDMETHOD.

  METHOD set_roll.
    me->roll = roll.
  ENDMETHOD.

  METHOD get_roll.
    roll = me->roll.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_empleado_vista DEFINITION.
  PUBLIC SECTION.
    METHODS: display_empleado IMPORTING nombre TYPE string
                                        roll   TYPE string.
ENDCLASS.

CLASS lcl_empleado_vista IMPLEMENTATION.
  METHOD display_empleado.
    WRITE: / 'Empleado......',
           / nombre,
           / roll.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_empleado_controlador DEFINITION.
  PUBLIC SECTION.
    METHODS: set_modelo IMPORTING modelo TYPE REF TO lcl_empleado_modelo,
      get_modelo EXPORTING modelo TYPE REF TO lcl_empleado_modelo,
      set_vista IMPORTING vista TYPE REF TO lcl_empleado_vista,
      get_vista EXPORTING vista TYPE REF TO lcl_empleado_vista.
  PRIVATE SECTION.
    DATA: modelo TYPE REF TO lcl_empleado_modelo,
          vista  TYPE REF TO lcl_empleado_vista.
ENDCLASS.

CLASS lcl_empleado_controlador IMPLEMENTATION.
  METHOD set_modelo.
    me->modelo = modelo.
  ENDMETHOD.
  METHOD get_modelo.
    modelo = me->modelo.
  ENDMETHOD.

  METHOD set_vista.
    DATA: lv_nombre TYPE string,
          lv_roll   TYPE string.

    me->vista = vista.

    modelo->get_nombre(
      IMPORTING
        nombre = lv_nombre
    ).

    modelo->get_roll(
      IMPORTING
        roll = lv_roll
    ).

    vista->display_empleado(
      EXPORTING
        nombre = lv_nombre
        roll   = lv_roll
    ).
  ENDMETHOD.

  METHOD get_vista.
    vista = me->vista.
  ENDMETHOD.
ENDCLASS.

PARAMETERS: pa_nomb TYPE string,
            pa_roll TYPE string.

START-OF-SELECTION.

  DATA: gr_modelo      TYPE REF TO lcl_empleado_modelo,
        gr_vista       TYPE REF TO lcl_empleado_vista,
        gr_controlador TYPE REF TO lcl_empleado_controlador.

  CREATE OBJECT gr_modelo
    EXPORTING
      nombre = pa_nomb
      roll   = pa_roll.

  CREATE OBJECT: gr_vista,
                 gr_controlador.

  gr_controlador->set_modelo( modelo = gr_modelo ).

  gr_controlador->set_vista( vista = gr_vista ).
