CLASS zcl_test_proveedor_alfa10 DEFINITION
  PUBLIC
  CREATE PUBLIC
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS .

  PUBLIC SECTION.

    METHODS test_obtener_nombre FOR TESTING.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_PROVEEDOR_ALFA10 IMPLEMENTATION.


  METHOD test_obtener_nombre.

    DATA: lr_proveedor TYPE REF TO lcl_proveedor,
          lv_resultado TYPE name1_gp.

    CREATE OBJECT lr_proveedor.

    lr_proveedor->obtener_nombre(
      EXPORTING
        lifnr = '0010300001'
      IMPORTING
        name1 = lv_resultado
    ).
    cl_aunit_assert=>assert_char_cp(
      EXPORTING
        act              = 'Inlandslieferant DE 1'
        exp              = lv_resultado
        msg              = 'Nombre Incorrecto'
*        level            = if_aunit_constants=>severity-medium
*        quit             = if_aunit_constants=>quit-test
*      RECEIVING
*        assertion_failed =
    ).
  ENDMETHOD.
ENDCLASS.
