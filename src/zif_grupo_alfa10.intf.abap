INTERFACE zif_grupo_alfa10
  PUBLIC .


  TYPES: BEGIN OF detalles_grupo,
           sector            TYPE spart,
           grupo_de_clientes TYPE kdgrp,
           solicitante       TYPE kunag,
         END OF detalles_grupo.
  TYPES documentos TYPE REF TO zif_documentos_alfa10 .

  CLASS-DATA grupo_cliente TYPE kdgrp .
  DATA dest_mercancia TYPE kunwe .

  EVENTS avisar_canal_distribuicion
    EXPORTING
      VALUE(canal_dist) TYPE vtweg .

  METHODS set_dest_mercancia
    IMPORTING
      !dest_mercancia TYPE kunwe .
ENDINTERFACE.
