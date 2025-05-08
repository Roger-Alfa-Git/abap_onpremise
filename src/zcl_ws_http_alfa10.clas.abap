class ZCL_WS_HTTP_ALFA10 definition
  public
  create public .

public section.

  methods CREAR_CONSTRUCTOR
    importing
      !PROTOCOLO_WS type STRING .
  methods SUPER
    exporting
      !PROTOCOLO_WS type STRING .
protected section.
private section.

  data PROTOCOLO_WS type STRING .
ENDCLASS.



CLASS ZCL_WS_HTTP_ALFA10 IMPLEMENTATION.


  method CREAR_CONSTRUCTOR.
    me->protocolo_ws = protocolo_ws.
  endmethod.


  method SUPER.
    protocolo_ws = me->protocolo_ws.
  endmethod.
ENDCLASS.
