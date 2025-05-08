*&---------------------------------------------------------------------*
*& Report ZPOO_T9_EJERCICIO4_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t9_ejercicio4_alfa10.

DATA: gr_autor     TYPE REF TO zca_pedidos_alfa10,
      gr_pedidos   TYPE REF TO zcl_pedidos_alfa10,
      grx_exeption TYPE REF TO cx_root.

gr_autor = zca_pedidos_alfa10=>agent.

TRY.
    gr_pedidos = gr_autor->create_persistent( i_vbeln = '123456789' ).
    gr_pedidos->set_erdat( i_erdat = sy-datum ).
    gr_pedidos->set_erzet( i_erzet = sy-uzeit ).
    gr_pedidos->set_ernam( i_ernam = 'ALFA10' ).
  CATCH cx_os_object_existing INTO grx_exeption. " Excepción de servicios de objeto
    WRITE: / grx_exeption->get_text( ).
ENDTRY.

COMMIT WORK.

WRITE: / 'Se acgrego correctamente a la base de datos'.
