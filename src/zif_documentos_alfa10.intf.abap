interface ZIF_DOCUMENTOS_ALFA10
  public .

  type-pools ZTYPE .

  types ACTIVATION type ref to CL_AAB_ID .
  types:
    BEGIN OF detalles_doc,
           num_doc   TYPE belnr,
           proveedor TYPE lifnr,
         END OF detalles_doc .
  types RANGO_PO_DOC type /CWM/R_VBELN .

  data DOC_VENTAS type VBELN_VA .

  class-events DEUDOR_DESCONOCIDO
    exporting
      value(DEUDOR) type KUNNR optional .
  events SIN_USUARIO_RESP
    exporting
      value(DOC_VENTAS) type VBELN_VA optional .

  methods SET_DOC_VENTAS
    importing
      value(DOC_VENTAS) type VBELN_VA optional .
endinterface.
