class ZCL_LONGITUDES_ALFA10 definition
  public
  create public .

public section.
protected section.
private section.

  methods CIRCUNFERENCIA
    importing
      !RADIO type DECFLOAT16
    returning
      value(LONGITUD) type DECFLOAT16 .
ENDCLASS.



CLASS ZCL_LONGITUDES_ALFA10 IMPLEMENTATION.


  METHOD circunferencia.
    longitud = 2 * lcl_ayuda_longitudes=>pi * radio.
  ENDMETHOD.
ENDCLASS.
