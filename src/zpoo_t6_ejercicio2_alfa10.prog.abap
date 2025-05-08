*&---------------------------------------------------------------------*
*& Report ZPOO_T6_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t6_ejercicio2_alfa10.

CLASS cl_screen DEFINITION.
  PUBLIC SECTION.
    EVENTS touch_screen EXPORTING VALUE(horizontal) TYPE string VALUE(vertical) TYPE string.
    DATA: screen_type TYPE string.
    METHODS: constructor IMPORTING screen_type TYPE string,
      touch.
ENDCLASS.

CLASS cl_screen IMPLEMENTATION.
  METHOD constructor.
    me->screen_type = screen_type.
  ENDMETHOD.
  METHOD touch.
    RAISE EVENT touch_screen EXPORTING horizontal = '50' vertical = '50'.
  ENDMETHOD.
ENDCLASS.

*T6_ejercicio3_alfa10
CLASS cl_navegacion DEFINITION.
  PUBLIC SECTION.
    METHODS: on_touch_screen FOR EVENT touch_screen OF cl_screen IMPORTING horizontal vertical sender.
ENDCLASS.

CLASS cl_navegacion IMPLEMENTATION.
  METHOD on_touch_screen.
    WRITE: / sender->screen_type.
  ENDMETHOD.
ENDCLASS.

*T6_ejercicio4_alfa10
START-OF-SELECTION.
  DATA: gr_navegacion TYPE REF TO cl_navegacion,
        gr_screen     TYPE REF TO cl_screen.

  CREATE OBJECT: gr_navegacion,gr_screen
    EXPORTING
      screen_type = 'Alfa10'.

  SET HANDLER gr_navegacion->on_touch_screen FOR gr_screen.

  DO 2 TIMES.
    gr_screen->touch( ).
  ENDDO.
