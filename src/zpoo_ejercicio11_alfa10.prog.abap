*&---------------------------------------------------------------------*
*& Report ZPOO_EJERCICIO11_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_ejercicio11_alfa10.

CLASS expedientes DEFINITION.

  PUBLIC SECTION.
    METHODS: abrir_expediente_laboral IMPORTING i_fecha     TYPE sydatum
                                                i_nombre    TYPE string
                                                i_apellido1 TYPE string
                                                i_apellido2 TYPE string OPTIONAL.

ENDCLASS.

CLASS expedientes IMPLEMENTATION.

  METHOD abrir_expediente_laboral.

    WRITE: / i_fecha,
           / i_nombre,
           / i_apellido1,
           / i_apellido2.

  ENDMETHOD.

ENDCLASS.


START-OF-SELECTION.

  DATA: gr_expedientes TYPE REF TO expedientes.

  CREATE OBJECT gr_expedientes.

  gr_expedientes->abrir_expediente_laboral(
    EXPORTING
      i_fecha     = '20240625'
      i_nombre    = 'Roger'
      i_apellido1 = 'Valderrabano'
      i_apellido2 = 'Hipolito').
