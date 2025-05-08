*&---------------------------------------------------------------------*
*& Report ZPOO_T9_EJERCICIO5_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t9_ejercicio5_alfa10.

DATA: gr_autor     TYPE REF TO zca_pedidos_alfa10,
      gr_pedidos   TYPE REF TO zcl_pedidos_alfa10,
      grx_exeption TYPE REF TO cx_root.

gr_autor = zca_pedidos_alfa10=>agent.

TRY.
    gr_pedidos = gr_autor->get_persistent( i_vbeln = '1234567890' ).
    WRITE: / gr_pedidos->get_vbeln( ),
           / gr_pedidos->get_erdat( ),
           / gr_pedidos->get_erzet( ),
           / gr_pedidos->get_ernam( ).
  CATCH cx_os_object_not_found INTO grx_exeption. " Excepción de servicios de objeto
    WRITE: / grx_exeption->get_text( ).
ENDTRY.
