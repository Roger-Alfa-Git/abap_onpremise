*&---------------------------------------------------------------------*
*& Report ZPOO_T9_EJERCICIO6_ALFA10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpoo_t9_ejercicio6_alfa10.

DATA: gr_autor     TYPE REF TO zca_pedidos_alfa10,
      grx_exeption TYPE REF TO cx_root.

gr_autor = zca_pedidos_alfa10=>agent.

TRY.
    gr_autor->delete_persistent( i_vbeln = '123456789' ).
    COMMIT WORK.
    WRITE: / 'Se elimino correctamente'.
  CATCH cx_os_object_not_existing INTO grx_exeption. " Excepción de servicios de objeto
    WRITE: / grx_exeption->get_text( ).
ENDTRY.
