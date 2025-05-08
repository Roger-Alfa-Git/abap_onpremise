*&---------------------------------------------------------------------*
*& Report ZPOO_T10_EJERCICIO2_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t10_ejercicio2_alfa10.

CLASS lcl_calculadora DEFINITION.
  PUBLIC SECTION.
    METHODS: suma IMPORTING num1 TYPE i num2 TYPE i EXPORTING respuesta TYPE i.
ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PUBLIC SECTION.
    METHODS: test_suma FOR TESTING.
ENDCLASS.

CLASS lcl_calculadora IMPLEMENTATION.
  METHOD suma.
    respuesta = num1 + num2.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.
  METHOD test_suma.
    DATA: lr_calculadora TYPE REF TO lcl_calculadora,
          lv_resultado   TYPE i.

    CREATE OBJECT lr_calculadora.

    lr_calculadora->suma(
      EXPORTING
        num1      = 5
        num2      = 10
      IMPORTING
        respuesta = lv_resultado
    ).
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 15
        act                  = lv_resultado
        msg                  = 'No se reaizo la suma correctamente'
*      level                = if_aunit_constants=>severity-medium
*      tol                  =
*      quit                 = if_aunit_constants=>quit-test
*      ignore_hash_sequence = abap_false
*    RECEIVING
*      assertion_failed     =
    ).
  ENDMETHOD.
ENDCLASS.
