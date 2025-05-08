class ZCL_CONEXION_HTTP_ALFA10 definition
  public
  create public .

public section.

  interfaces ZIF_GRUPO_ALFA10 .

  aliases SET_DEST_MERCANCIA
    for ZIF_GRUPO_ALFA10~SET_DEST_MERCANCIA .
  aliases AVISAR_CANAL_DISTRIBUICION
    for ZIF_GRUPO_ALFA10~AVISAR_CANAL_DISTRIBUICION .

  events ERROR_CONEXION .
  class-events SIN_AUTORIZACION .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !REQUEST_METHOD type STRING .
  methods SET_REQUEST_URI .
  methods GET_REQUEST_URI .
  methods SET_SERVER_PROTOCOL .
  methods GET_SERVER_PROTOCOL .
protected section.

  aliases DEST_MERCANCIA
    for ZIF_GRUPO_ALFA10~DEST_MERCANCIA .
  aliases GRUPO_CLIENTE
    for ZIF_GRUPO_ALFA10~GRUPO_CLIENTE .
private section.

  aliases DETALLES_GRUPO
    for ZIF_GRUPO_ALFA10~DETALLES_GRUPO .
  aliases DOCUMENTOS
    for ZIF_GRUPO_ALFA10~DOCUMENTOS .

  data REQUEST_URI type STRING .
  data SERVER_PROTOCOL type STRING .

  methods CREA_CONEXION .
  methods COMPRUEBA_AUTORIZACION .
ENDCLASS.



CLASS ZCL_CONEXION_HTTP_ALFA10 IMPLEMENTATION.


  METHOD class_constructor.
  ENDMETHOD.


  METHOD comprueba_autorizacion.
    RAISE event SIN_AUTORIZACION.
  ENDMETHOD.


  METHOD constructor.
    me->request_uri = request_method.
  ENDMETHOD.


  METHOD crea_conexion.
    RAISE EVENT error_conexion.
  ENDMETHOD.


  METHOD get_request_uri.
    request_uri = me->request_uri.
  ENDMETHOD.


  METHOD get_server_protocol.
    server_protocol = me->server_protocol.
  ENDMETHOD.


  METHOD set_request_uri.
    me->request_uri = request_uri.
  ENDMETHOD.


  METHOD set_server_protocol.
    me->server_protocol = server_protocol.
  ENDMETHOD.
ENDCLASS.
