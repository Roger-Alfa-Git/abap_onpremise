class ZCL_DOCUMENTOS_ALFA10 definition
  public
  create public .

public section.

  interfaces ZIF_DOCUMENTOS_ALFA10 .

  aliases ACTIVATION
    for ZIF_DOCUMENTOS_ALFA10~ACTIVATION .

  class-data CLAVE_OPERACION type KTOSL .

  events DOCUMENTO_CADUCADO
    exporting
      value(FECHA) type SYDATUM .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !NUM_DOC type BELNR .
  class-methods ANADIR_CLAVE_OPERACION
    importing
      !CLAVE_OPERACION type KTOSL .
  methods SET_PLAN_CUENTAS
    importing
      !PLAN_CUENTAS type KTOPL .
  methods GET_PLAN_CUENTAS
    exporting
      !PLAN_CUENTAS type KTOPL .
  methods CREAR_AVISOS .
  class-methods GENERAR_AVISOS
    importing
      !DEUDOR type KUNNR .
protected section.

  aliases DEUDOR_DESCONOCIDO
    for ZIF_DOCUMENTOS_ALFA10~DEUDOR_DESCONOCIDO .
  aliases DETALLES_DOC
    for ZIF_DOCUMENTOS_ALFA10~DETALLES_DOC .

  data PLAN_CUENTAS type KTOPL .
private section.

  aliases DOC_VENTAS
    for ZIF_DOCUMENTOS_ALFA10~DOC_VENTAS .
  aliases SET_DOC_VENTAS
    for ZIF_DOCUMENTOS_ALFA10~SET_DOC_VENTAS .
  aliases SIN_USUARIO_RESP
    for ZIF_DOCUMENTOS_ALFA10~SIN_USUARIO_RESP .
  aliases RANGO_PO_DOC
    for ZIF_DOCUMENTOS_ALFA10~RANGO_PO_DOC .

  constants CONT_MODIF type BWMOD value '32A' ##NO_TEXT.
  data NUM_DOC type BELNR .
ENDCLASS.



CLASS ZCL_DOCUMENTOS_ALFA10 IMPLEMENTATION.


  METHOD anadir_clave_operacion.

    zcl_documentos_alfa10=>clave_operacion = clave_operacion.

  ENDMETHOD.


  method CLASS_CONSTRUCTOR.
    write: / 'Documentos creados'.
  endmethod.


  METHOD constructor.
    me->num_doc = num_doc.
  ENDMETHOD.


  METHOD crear_avisos.

    RAISE EVENT: documento_caducado EXPORTING fecha = sy-datum,
                 sin_usuario_resp EXPORTING doc_ventas = zif_documentos_alfa10~doc_ventas.

  ENDMETHOD.


  METHOD generar_avisos.
    DATA: lv_kunnr TYPE kunnr.
    SELECT SINGLE kunnr FROM kna1
      INTO lv_kunnr
      WHERE kunnr EQ !deudor.
    IF sy-subrc EQ 0.
      RAISE EVENT deudor_desconocido EXPORTING deudor = !deudor.
    ENDIF.
  ENDMETHOD.


  method GET_PLAN_CUENTAS.
    plan_cuentas = me->plan_cuentas.
  endmethod.


  METHOD set_plan_cuentas.

    me->plan_cuentas = plan_cuentas.

  ENDMETHOD.


  method ZIF_DOCUMENTOS_ALFA10~SET_DOC_VENTAS.
  endmethod.
ENDCLASS.
