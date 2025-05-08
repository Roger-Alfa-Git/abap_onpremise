*&---------------------------------------------------------------------*
*& Report ZPOO_CLASE_TEST_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_clase_test_alfa10.

CLASS lcl_calculos DEFINITION.
  PUBLIC SECTION.
    METHODS: obtener_factorial IMPORTING numero    TYPE i
                               EXPORTING factorial TYPE i.
ENDCLASS.

CLASS lcl_calculos IMPLEMENTATION.
  METHOD obtener_factorial.
    DATA: lv_nuemro TYPE i.
    lv_nuemro = numero.
    factorial = 1.
    WHILE lv_nuemro NE 0.
      factorial = factorial * lv_nuemro.
      lv_nuemro = lv_nuemro - 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PUBLIC SECTION.
    METHODS: test_factorial FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.
  METHOD test_factorial.
    DATA: lr_calculos  TYPE REF TO lcl_calculos,
          lv_resultado TYPE i.
    CREATE OBJECT: lr_calculos.
    lr_calculos->obtener_factorial(
      EXPORTING
        numero    = 4
      IMPORTING
        factorial = lv_resultado
    ).
    cl_aunit_assert=>assert_equals(
      EXPORTING
        exp                  = 24
        act                  = lv_resultado
        msg                  = 'Factorial incorrecto'
*        level                = if_aunit_constants=>severity-medium
*        tol                  =
*        quit                 = if_aunit_constants=>quit-test
*        ignore_hash_sequence = abap_false
*      RECEIVING
*        assertion_failed     =
    ).
  ENDMETHOD.
ENDCLASS.
