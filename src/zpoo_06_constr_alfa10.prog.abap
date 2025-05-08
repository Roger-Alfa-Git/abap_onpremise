*&---------------------------------------------------------------------*
*& Report ZPOO_06_CONSTR_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_06_constr_alfa10.

CLASS empleado DEFINITION.

  PUBLIC SECTION.

    METHODS: constructor IMPORTING i_nombre TYPE string .

    CLASS-METHODS class_constructor.

  PRIVATE SECTION.

    DATA: nombre TYPE string.

ENDCLASS.

CLASS empleado IMPLEMENTATION.

  METHOD constructor.
    nombre = i_nombre.

    WRITE: / 'Constructor de instancia'.

  ENDMETHOD.


  METHOD class_constructor.

    WRITE: / 'Constructor estatico'.

  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA: gr_empleado  TYPE REF TO empleado,
        gr_empleado2 TYPE REF TO empleado.

  CREATE OBJECT gr_empleado
    EXPORTING
      i_nombre = 'Carlos'.

  CREATE OBJECT gr_empleado2
    EXPORTING
      i_nombre = 'Alberto'.
