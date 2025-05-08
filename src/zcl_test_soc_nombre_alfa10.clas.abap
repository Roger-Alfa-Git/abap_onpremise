class ZCL_TEST_SOC_NOMBRE_ALFA10 definition
  public
  create public
  for testing
  duration short
  risk level harmless .

public section.

  methods COMPROBAR_SOCIEDAD FOR TESTING.
protected section.
private section.
ENDCLASS.



CLASS ZCL_TEST_SOC_NOMBRE_ALFA10 IMPLEMENTATION.


  METHOD comprobar_sociedad.
    DATA: lr_proveedor TYPE REF TO lcl_sociedad,
          lv_resultado TYPE butxt.

    CREATE OBJECT lr_proveedor.

    lr_proveedor->obtener_sociedad(
      EXPORTING
        bukrs = '0008'
      IMPORTING
                butxt = lv_resultado
    ).
    CL_AUNIT_ASSERT=>assert_char_cp(
      EXPORTING
        act              = 'Saudi Petrochemical'
        exp              = lv_resultado
        msg              = 'Mensaje incorrecto'
*        level            = if_aunit_constants=>severity-medium
*        quit             = if_aunit_constants=>quit-test
*      RECEIVING
*        assertion_failed =
    ).
  ENDMETHOD.
ENDCLASS.
