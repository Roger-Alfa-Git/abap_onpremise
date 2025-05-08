class ZCL_SINGLETON_ALFA10 definition
  public
  create private .

public section.

  data HORA_CREACION type SYUZEIT .

  methods CONSTRUCTOR .
  class-methods OBTENER_INSTANCIA
    exporting
      !INSTANCIA type ref to ZCL_SINGLETON_ALFA10 .
protected section.
private section.

  class-data OBJETO type ref to ZCL_SINGLETON_ALFA10 .
ENDCLASS.



CLASS ZCL_SINGLETON_ALFA10 IMPLEMENTATION.


  METHOD constructor.

    hora_creacion = sy-uzeit.

  ENDMETHOD.


  METHOD obtener_instancia.

    IF zcl_singleton_alfa10=>objeto IS NOT BOUND.
      CREATE OBJECT objeto.
      instancia = zcl_singleton_alfa10=>objeto.
    ELSE.
      instancia = zcl_singleton_alfa10=>objeto.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
